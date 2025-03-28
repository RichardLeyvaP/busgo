import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/ui/pages/PrinterPage/widget/classUtilsPrinterTicket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowTicketPage extends StatefulWidget {
  @override
  _ShowTicketPageState createState() => _ShowTicketPageState();
}

class _ShowTicketPageState extends State<ShowTicketPage> {
  DateTime? _selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _reportDataFuture1 = _loadReportData1(DateFormat('yyyy-MM-dd').format(_selectedDate!));
    } else {
      // No se seleccionó ninguna fecha
    }
  }


  late Future<void> _reportDataFuture1;
  

  @override
  void initState() {
    super.initState();
    _reportDataFuture1 = _loadReportData1(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  Future<void> _loadReportData1(String date) async {
    await getTickets(1, date);
  }
  Future<void> _reprintTickets(int id) async {
    await reprintTickets(id);
  }
  UtilsPrinterTicket utilsPrinterTicket = UtilsPrinterTicket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _reportDataFuture1,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Row(
                        mainAxisSize: MainAxisSize
                            .min, // Hace que el Row ocupe solo el tamaño necesario
                        children: [
                          Icon(Icons.calendar_month, color: Colors.white),
                          SizedBox(
                              width: 8), // Espacio entre el icono y el texto
                          Text("Seleccionar Fecha"),
                        ],
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded( // Envuelve el ListView en un Expanded
                child: 
                (ticketsSignal.value != null)?
                
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: ListView.builder(
                    itemCount: ticketsSignal.value?.length??0, // Número de elementos a mostrar
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0), // Márgenes entre los contenedores
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
                          children: [
                             Text(
                        currentUserBranchCompanyLG.value?.name ??
                            '-- No tiene --',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          "Sucursal: ${currentUserBranchLG.value?.name ?? '-- No tiene --'}"),
                      const SizedBox(height: 10),
                            _buildInfoRow('ID: ', ticketsSignal.value![index].id.toString()),
                            _buildInfoRow('Método de pago: ', ticketsSignal.value![index].method.toString()),
                            _buildInfoRow('Cantidad: ', ticketsSignal.value![index].quantity.toString()),
                            _buildInfoRow('Precio: ', '\$${ticketsSignal.value![index].price}'),
                            _buildInfoRow('Total: ', '\$${ticketsSignal.value![index].total}'),
                            _buildInfoRow('Fecha: ', ticketsSignal.value![index].date.toString()),
                            _buildInfoRow('Sucursal: ', ticketsSignal.value![index].branchName.toString()),
                            _buildInfoRow('Usuario: ', ticketsSignal.value![index].userName.toString()),
                            _buildInfoRow('Ruta: ', ticketsSignal.value![index].tripName.toString()),
                            _buildInfoRow('Origen: ', ticketsSignal.value![index].tripOrigin.toString()),
                            _buildInfoRow('Destino: ', ticketsSignal.value![index].tripDestination.toString()),
                            _buildInfoRow('Horario: ', ticketsSignal.value![index].schedule.toString()),
                           ticketsSignal.value![index].print == 2?
                            ElevatedButton(
  onPressed: null, // Deshabilita el botón
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey, // Color de fondo gris
    foregroundColor: Colors.white, // Color del texto
    disabledBackgroundColor: Colors.grey, // Color de fondo cuando está deshabilitado
    disabledForegroundColor: Colors.white, // Color del texto cuando está deshabilitado
  ),
  child: const Center(child: Text('Ya fue reimpreso')),
):
                              ElevatedButton(
                              onPressed: () {
                                // Acción del botón
                                _reprintTickets(ticketsSignal.value![index].id!);
                                utilsPrinterTicket.printTicketPasaje(ticketsSignal.value![index]);
                              },
                              child: const Center(child: Text('Reimprimir')),)
                          ],
                        ),
                      );
                    },
                  ),
                ):
                Center(child: Text('No hay Tickets en ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}')),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              softWrap: true, // Permite el salto de línea
              overflow: TextOverflow.visible, // Para que no se trunque
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return 'Fecha inválida';
    }
  }
}