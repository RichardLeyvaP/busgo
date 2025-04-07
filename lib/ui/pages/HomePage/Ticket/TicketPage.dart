import 'package:BusGo/data/services/local_database_service.dart';
import 'package:BusGo/data/services/network_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/ticket/ticket_dabase_local/ticket_dabase_local_model.dart';
import 'package:BusGo/ui/component/internetConnectionModal_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTikecket.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/paymentCard.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicketLocal.dart';
import 'package:BusGo/util/util_class_sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatefulWidget {
  @override
  State<TicketPage> createState() => _TicketPageState();
}

final utilsTicket = UtilsTicket();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          bool checkConnection = await _checkConnection();
          if (checkConnection) {
            print('TIENE CONEXION - SI, MANDAR A PAGAR');
            utilsTicket.verifyPurchaseTicketClass(
                context, tripsSelectSignal.value!.price.toString());
          } else {
            InternetConnectionModal.show(
              context,
              onPayWithCash: () async {
                // Lógica para pagar con efectivo
                print('TIENE CONEXION - NO, GUARDAR EN DB-LOCAL');
                // Si no hay conexión, guardamos el ticket en la base de datos local
                double total =
                    ((double.parse(tripsSelectSignal.value!.price!) / 2) *
                            quantityMenoresSignal.watch(context)) +
                        ((double.parse(tripsSelectSignal.value!.price!)) *
                            quantitySignal.watch(context));
                int branch_id = currentUserBranchLG.value!.id;
                int trip_id = tripsSelectSignal.value!.id!;
                int quantity =
                    quantityMenoresSignal.value + quantitySignal.value;
                List<int> seats = selectedSeatNumbersSN.value;
                DateTime date = tripsSelectSignal.value!.date!;
                int adults = quantitySignal.value;
                int minors = quantityMenoresSignal.value;

                Ticket newTicket = Ticket(
                  id: DateTime.now().millisecondsSinceEpoch,
                  branchId: branch_id,
                  tripId: trip_id,
                  method: 'Efectivo',
                  quantity: quantity,
                  price: double.parse(tripsSelectSignal.value!.price!),
                  seats: seats,
                  date: DateFormat('yyyy-MM-dd').format(date),
                  adults: adults,
                  minors: minors,
                  total: total,
                  //estos estan ahi pero no se envian
                  //************************* */
                  status: 1,
                  transactionStatus: 'pending',
                  sequenceNumber: 'abc123',
                  extraData: 'no extra data',
                  transactionTip: 10.0,
                  transactionCashback: 5.0,
                  //************************* */
                );

                final resultTicket = await dbHelper.insertTicket(newTicket);
                if (resultTicket != null) {
                  //Aumento la variable que me controla la cantidad de tickets guardados en la db-local
                  sharedPreferencesStorage.incrementCounter();
                  showCustomSnackBar(
                      context: context,
                      title:
                          'Compra de Ticket guardada correctamente db-Local', // Obligatorio
                      backgroundColor: Colors.green);
                  //Mandar a Imprimir
                  String scheduleActual =
                      DateFormat('HH:mm').format(DateTime.now());
                  await utilsPrinterTicketLocal.printTicketPasajeLocal(
                      newTicket,
                      scheduleActual,
                      tripsSelectSignal.value!.origin.toString(),
                      tripsSelectSignal.value!.destination.toString());
                } else {
                  showCustomSnackBar(
                      context: context,
                      title: 'Error al guardar el Ticket', // Obligatorio
                      backgroundColor: Colors.red);
                }
              },
              onCancel: () {
                // Lógica cuando se cancela
              },
            );
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
                        selectedSeatNumbersSN.value = [];
                        selectedSeatNumbersSN.value = []; // Asientos
                        quantitySignal.value = 0; // Cantidad adultos
                        quantityMenoresSignal.value = 0; // Cantidad menores
                        (context as Element).markNeedsBuild();
                        GoRouter.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    const Text(
                      "Ticket",
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
                          0, 30, 0, 0), // Empuja hacia abajo
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 150, 10, 0),
                        child: Card(
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: 50), // Espacio para el Card superior
                              const Text(
                                "Pago de Pasaje",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.blue),
                                      const SizedBox(height: 5),
                                      Container(
                                        width: 1,
                                        height: 40,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 5),
                                      const Icon(Icons.location_on,
                                          color: Color(0xFF55698F)),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("ORIGEN",
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                        Text(
                                          tripsSelectSignal.value!.origin
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Divider(color: Colors.grey[400]),
                                        const SizedBox(height: 4),
                                        Text("DESTINO",
                                            style: TextStyle(
                                                color: Colors.grey[600])),
                                        Text(
                                          tripsSelectSignal.value!.destination
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
