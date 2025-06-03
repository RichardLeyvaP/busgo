import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/data/services/network_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:BusGo/ui/component/internetConnectionModal_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTicket.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/paymentCard.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicketLocal.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';
import 'package:intl/intl.dart';

enum PaymentMethod { cash, creditCard, debitCard }

class TicketPage extends StatefulWidget {
  @override
  State<TicketPage> createState() => _TicketPageState();
}

// final utilsTicket = UtilsTicket();
final NetworkService _networkService = NetworkService();
final DatabaseHelper dbHelper =
    DatabaseHelper(); // Instancia de la base de datos
SharedPreferencesStorage sharedPreferencesStorage =
    SharedPreferencesStorage(); // Instancia de la base de datos
UtilsPrinterTicketLocal utilsPrinterTicketLocal = UtilsPrinterTicketLocal();

// Método para verificar la conexión y actualizar el estado
Future<bool> _checkConnection() async {
  bool isConnected = await _networkService.checkInternetConnection();
  if (isConnected) {
    return true;
  } else {
    return false;
  }
}

class _TicketPageState extends State<TicketPage> {

  //modal para seleccionar el metodo de pago
  Future<PaymentMethod?> _showPaymentMethodModal(BuildContext context) async {
    return showModalBottomSheet<PaymentMethod>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Seleccione método de pago',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildPaymentMethodItem(
                context,
                icon: Icons.money_off,
                color: Colors.orange,
                text: 'Efectivo',
                method: PaymentMethod.cash,
              ),
              const SizedBox(height: 10),
              _buildPaymentMethodItem(
                context,
                icon: Icons.credit_card,
                color: Colors.blue,
                text: 'Tarjeta de Débito',
                method: PaymentMethod.debitCard,
              ),
              const SizedBox(height: 10),
              _buildPaymentMethodItem(
                context,
                icon: Icons.credit_score,
                color: Colors.green,
                text: 'Tarjeta de Crédito',
                method: PaymentMethod.creditCard,
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // 3. Método para construir los ítems del modal
  Widget _buildPaymentMethodItem(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String text,
        required PaymentMethod method,
      }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(text, style: TextStyle(color: Colors.grey[800])),
        onTap: () => Navigator.pop(context, method),
      ),
    );
  }

  // 4. Manejo de pagos en efectivo
  Future<void> _handleCashPayment() async {
    double total = ((double.parse(tripsSelectSignal.value!.price!) / 2) *
        quantityMenoresSignal.value) +
        (double.parse(tripsSelectSignal.value!.price!) * quantitySignal.value);

    Ticket newTicket = Ticket(
      id: DateTime.now().millisecondsSinceEpoch,
      branchId: currentUserBranchLG.value!.id,
      tripId: tripsSelectSignal.value!.id!,
      method: 'Efectivo',
      quantity: quantitySignal.value + quantityMenoresSignal.value,
      price: double.parse(tripsSelectSignal.value!.price!),
      seats: selectedSeatNumbersSN.value,
      date: DateFormat('yyyy-MM-dd').format(tripsSelectSignal.value!.date!),
      adults: quantitySignal.value,
      minors: quantityMenoresSignal.value,
      total: total,
      status: 1,
      transactionStatus: 'pending',
      sequenceNumber: 'abc123',
      transactionTip: 10.0,
      transactionCashback: 5.0,
    );

    final resultTicket = await dbHelper.insertTicket(newTicket);
    if (resultTicket != null) {
      sharedPreferencesStorage.incrementCounter();
      showCustomSnackBar(
        context: context,
        title: 'Compra de Ticket guardada correctamente db-Local',
        backgroundColor: Colors.green,
      );

      String scheduleActual = DateFormat('HH:mm').format(DateTime.now());
      await utilsPrinterTicketLocal.printTicketPasajeLocal(
        newTicket,
        scheduleActual,
        tripsSelectSignal.value!.origin.toString(),
        tripsSelectSignal.value!.destination.toString(),
      );
    } else {
      showCustomSnackBar(
        context: context,
        title: 'Error al guardar el Ticket',
        backgroundColor: Colors.red,
      );
    }
  }

  // 5. Manejo de pagos con tarjeta
  Future<void> _handleCardPayment(PaymentMethod method) async {
    final hasConnection = await _checkConnection();
    if (!hasConnection) {
      showCustomSnackBar(
        context: context,
        title: 'Se requiere conexión para pagos con tarjeta',
        backgroundColor: Colors.red,
      );
      return;
    }

    final methodName = method == PaymentMethod.creditCard ? 'Crédito' : 'Débito';
    verifyPurchaseTicketClass(
      context,
      tripsSelectSignal.value!.price.toString(),
      paymentMethod: methodName,
    );
  }

  String formatoChilenoSinSimbolo(int valor) {
    final formatter = NumberFormat('####', 'es_CL');
    return formatter.format(valor);
  }

  @override
  Widget build(BuildContext context) {
    String value=tripsSelectSignal.value!.price.toString();
    int valorInt = double.tryParse(value)?.toInt() ?? 0;  // Si falla, usa 0
    String valorFormateado = formatoChilenoSinSimbolo(valorInt);
    return Scaffold(
      floatingActionButton:  Watch.builder(
        builder: (context) {
          final hasSeats = selectedSeatNumbersSN
              .watch(context)
              .isNotEmpty;

          return FloatingActionButton.extended(
            onPressed: () async {
              if (selectedSeatNumbersSN.value.isEmpty) {
                showCustomSnackBar(
                  context: context,
                  title: 'Debe seleccionar al menos un asiento',
                  backgroundColor: Colors.red,
                );
                return;
              }

              bool checkConnection = await _checkConnection();
              final paymentMethod = await _showPaymentMethodModal(context);
              if (paymentMethod == null) return;

              if (paymentMethod == PaymentMethod.cash) {
                await _handleCashPayment();
              } else {
                await _handleCardPayment(paymentMethod);
              }
            },
            backgroundColor: Colors.blue,
            label: Row(
              children: [
                Icon(MdiIcons.ticket, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Comprar Ticket', style: TextStyle(fontSize: 14)),
              ],
            ),
          );
        }
      ),
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado fijo
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).pop();
                        quantitySignal.value = 0;
                        quantityMenoresSignal.value = 0;
                        quantityAdultsSignal.value = 0;
                        selectedSeatNumbersSN.value = [];
                        tripsSelectSignal.value = null;
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    const Text(
                      "Pago de Pasaje",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 50), // Espaciador para equilibrar
                  ],
                ),
              ),
            ),
            // Contenido desplazable
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none, // Permite que el Card sobresalga
                  children: [
                    // Contenedor blanco de detalles
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          0, 40, 0, 0), // Empuja hacia abajo
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Card(
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: 50), // Espacio para el Card superior

                              const SizedBox(height: 5),
                              PaymentCard(
                                timeIni: tripsSelectSignal.value!.schedule
                                    .toString(),
                                timeFin: '10:30xxx',
                                price:
                                    tripsSelectSignal.value!.price.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Tarjeta flotante con detalles del ticket
                    Positioned(
                      top: 0, // Ajusta la posición de la tarjeta flotante
                      left: 35,
                      right: 35,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      size: 15, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text(
                                    tripsSelectSignal.value!.schedule
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Icon(MdiIcons.rayStartArrow,
                                        size: 24, color: Colors.black),
                                  ),
                                  Text(
                                    tripsSelectSignal.value!.arrival.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(MdiIcons.bus,
                                      size: 15, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text('Bus: ',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  Text(
                                    tripsSelectSignal.value!.plate.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(MdiIcons.seatReclineExtra,
                                      size: 15, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text('Capacidad: ',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  Text(
                                    tripsSelectSignal.value!.seats.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(MdiIcons.ticket, size: 15, color: Colors.black),
                                  const SizedBox(width: 5),
                                  Text('Precio: ', style: TextStyle(color: Colors.grey[600])),
                                  Text(
                                      valorFormateado ,// Asegúrate que es int

                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
