import 'package:BusGo/domain/signals/reports_signals/reports_services.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Report2Page extends StatefulWidget {
  const Report2Page({super.key});

  @override
  _Report2PageState createState() => _Report2PageState();
}

class _Report2PageState extends State<Report2Page> {
  late Future<void> _reportDataFuture2;
   DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _reportDataFuture2 = _loadReportData2();
  }

  Future<void> _loadReportData2() async {
    // Aquí puedes llamar al método que obtenga los datos, como getReports2(id, type, date, endDate)
    await getReports2(-999, 'ya esta por defecto en el metodo',
        DateFormat('yyyy-MM-dd').format(DateTime.now()), null);
  }

    // Variables de estado globales para el rango de fechas
  DateTime? startDate;
  DateTime? endDate;
  String formatDate2(DateTime? dateTime) {
    // Si dateTime es null, se toma la fecha actual
    dateTime ??= DateTime.now();

    // Formatear la fecha a "yyyy-MM-dd"
    return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }
  

  Future<void> _selectDateRange2() async {
    DateTime today = DateTime.now();
    startDate ??= today;
    endDate ??= today;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          // ⬅ Usa StatefulBuilder para actualizar el modal
          return Container(
            height: 500,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Seleccionar rango de fechas",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Expanded(
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: startDate ?? DateTime.now(),
                    selectedDayPredicate: (day) {
                      if (startDate != null && endDate != null) {
                        return day.isAfter(
                                startDate!.subtract(Duration(days: 1))) &&
                            day.isBefore(endDate!.add(Duration(days: 1)));
                      }
                      return day == startDate;
                    },
                    onDaySelected: (selectedDay, _) {
                      setModalState(() {
                        // ⬅ Actualiza solo el modal
                        if (startDate == null ||
                            (startDate != null && endDate != null)) {
                          startDate = selectedDay;
                          endDate = null;
                        } else {
                          endDate = selectedDay.isAfter(startDate!)
                              ? selectedDay
                              : startDate;
                        }
                      });
                    },
                    calendarStyle: CalendarStyle(
                      rangeHighlightColor: Colors.orange.withOpacity(0.3),
                      todayDecoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (startDate != null && endDate != null) {
                          setState(() {
                            // ⬅ Actualiza la UI principal
                            _selectedDateRange =
                                DateTimeRange(start: startDate!, end: endDate!);
                          });
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            // ⬅ Actualiza la UI principal
                            endDate = startDate!;
                            _selectedDateRange =
                                DateTimeRange(start: startDate!, end: endDate!);
                          });
                          Navigator.pop(context);
                        }
                        await getReports2(
                            -999,
                            'ya esta por defecto en el metodo',
                            formatDate2(startDate),
                            formatDate2(endDate));
                        setState(() {
                          //actualizar ui
                        });
                      },
                      child: Text("Aceptar"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _reportDataFuture2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Muestra el indicador de carga
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si hay un problema
          }

          // Aquí debes acceder a los datos cargados, por ejemplo:
          final resultReport2 = resultReport2RP.value;
          final totalesPorMetodos = resultReport2RP.value?.totalesPorMetodo;

          return Column(
            children: [
               Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8,bottom: 8),
                      child: ElevatedButton(
                        
                        onPressed: _selectDateRange2,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8), // Ajusta el padding si es necesario
                        ),
                        child: Row(
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
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${resultReport2?.nombre??'-Sin Nombre-'}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("FECHA: ${resultReport2?.fecha??'-Sin fecha-'}"),
                        SizedBox(height: 10),
                        Text("RESUMEN:", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("EMISIÓN DE PASAJES", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Pasajes emitidos: ${resultReport2?.pasejesEmitidos??'0'}"),
                        Text("Reimpresiones: ${resultReport2?.reimpresiones??'0'}"),
                        SizedBox(height: 5),
                        if (totalesPorMetodos != null) ...[
                          for (var totalesPorMetodo in totalesPorMetodos) ...[
                            Text(
                              "${totalesPorMetodo.metodo}: ${totalesPorMetodo.cantidad ?? 0}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ],
                        SizedBox(height: 10),
                        if (totalesPorMetodos != null) ...[
                          Text("TOTALES:", style: TextStyle(fontWeight: FontWeight.bold)),
                          for (var totalesPorMetodo in totalesPorMetodos) ...[
                            Text(
                              "${totalesPorMetodo.metodo}: \$${totalesPorMetodo.total ?? 0}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ],
                        Text(
                          "TOTAL: \$${resultReport2?.totales ?? 0}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("TRAMOS:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    if (resultReport2?.tramos != null)
                  ...resultReport2!.tramos!.map<Widget>((tramo) {
                    int efectivo = 0;
                    int debito = 0;
                    int credito = 0;
                                
                    if (tramo.totalesPorMetodo != null) {
                    var  tramototalesPorMetodo = tramo.totalesPorMetodo;
                                for (var metodo in tramototalesPorMetodo!) {
                                  if (metodo.metodo == "EFECTIVO") efectivo = metodo.total ?? 0;
                                  if (metodo.metodo == "TARJETA") debito = metodo.total ?? 0;
                                  if (metodo.metodo == "CREDITO") credito = metodo.total ?? 0;
                                }
                    }
                                
                    return _buildTramo(
                                tramo.nombre ?? "-Sin nombre-",
                                tramo.totalPasajes ?? 0,
                                efectivo,
                                debito,
                                credito,
                                tramo.totalTramo ?? 0,
                                efectivo,
                                debito,
                                credito,
                    );
                  }).toList(),
                                  ],
                                )
                                ,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Llamar al método de impresión aquí
        },
        child: Icon(Icons.print),
      ),
    );
  }

  Widget _buildTramo(
    String name,
    int totalPasajes,
    int efectivo,
    int debito,
    int credito,
    int totalTramo,
    int efectivoTramo,
    int debitoTramo,
    int creditoTramo,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4,),
        Text('Total pasajes: $totalPasajes'),
        Text('Efectivo: $efectivo'),
        Text('Débito: $debito'),
        Text('Crédito: $credito'),
        SizedBox(height: 5),
        Text('Total Tramo: \$${totalTramo}'),
        Text('Efectivo: \$${efectivoTramo}'),
        Text('Débito: \$${debitoTramo}'),
        Text('Crédito: \$${creditoTramo}'),
        SizedBox(height: 10),
      ],
    );
  }
}
