import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_services.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Report3Page extends StatefulWidget {
  const Report3Page({super.key});

  @override
  _Report3PageState createState() => _Report3PageState();
}

class _Report3PageState extends State<Report3Page> {
  late Future<void> _reportDataFuture;
  DateTimeRange? _selectedDateRange;

String formatDate(DateTime? dateTime) {
  // Si dateTime es null, se toma la fecha actual
  dateTime ??= DateTime.now();

  // Formatear la fecha a "yyyy-MM-dd"
  return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}



  // Variables de estado globales para el rango de fechas
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    _reportDataFuture = _loadReportData();
  }

  Future<void> _loadReportData() async {
    await getReports1(1, 'Company', '2025-02-13', null);
  }

  Future<void> _selectDateRange() async {
    DateTime today = DateTime.now();
    startDate ??= today;
    endDate ??= today;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) { // ⬅ Usa StatefulBuilder para actualizar el modal
            return Container(
              height: 500,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Seleccionar rango de fechas", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: TableCalendar(
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      focusedDay: startDate ?? DateTime.now(),
                      selectedDayPredicate: (day) {

                        if (startDate != null && endDate != null) {
                          return day.isAfter(startDate!.subtract(Duration(days: 1))) &&
                                 day.isBefore(endDate!.add(Duration(days: 1)));
                        }
                        return day == startDate;
                      },
                      onDaySelected: (selectedDay, _) {
                        setModalState(() { // ⬅ Actualiza solo el modal
                          if (startDate == null || (startDate != null && endDate != null)) {
                            startDate = selectedDay;
                            endDate = null;
                          } else {
                            endDate = selectedDay.isAfter(startDate!) ? selectedDay : startDate;
                          }
                        });
                      },
                      calendarStyle: CalendarStyle(
                        rangeHighlightColor: Colors.orange.withOpacity(0.3),
                        todayDecoration: BoxDecoration(
                          color: Colors.blue, 
                          shape: BoxShape.circle
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.orange, 
                          shape: BoxShape.circle
                        ),
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
                            setState(() { // ⬅ Actualiza la UI principal
                              _selectedDateRange = DateTimeRange(start: startDate!, end: endDate!);
                            });
                            Navigator.pop(context);
                          }
                          else{

                            setState(() { // ⬅ Actualiza la UI principal
                            endDate = startDate!;
                              _selectedDateRange = DateTimeRange(start: startDate!, end: endDate!);
                            });
                            Navigator.pop(context);
                             
                          }
                          await getReports1(1, 'Company', formatDate(startDate) , formatDate(endDate));
                        },
                        child: Text("Aceptar"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
      },
    );

    if (_selectedDateRange != null) {
      await getReports1(1, 'Company', _selectedDateRange!.start.toIso8601String(), _selectedDateRange!.end.toIso8601String());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _reportDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final totalesPorMetodos = resultReport1RP.value?.totalesPorMetodo;

          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 300,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUserBranchCompanyLG.value?.name ?? '-- No tiene --',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("FECHA: ${resultReport1RP.value?.fecha ?? '-Sin fecha-'}"),
                        Text("Sucursal: ${currentUserBranchLG.value?.name ?? '-- No tiene --'}"),
                        SizedBox(height: 10),
                        Text("RESUMEN:", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("EMISIÓN DE PASAJES", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Pasajes emitidos: ${resultReport1RP.value?.pasajesEmitidos ?? 0}"),
                        Text("Reimpresiones: ${resultReport1RP.value?.reimpresiones ?? 0}"),
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
                          "TOTAL: \$${resultReport1RP.value?.totales ?? 0}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectDateRange,
                    child: Text("Seleccionar Fecha"),
                  ),
                  if (_selectedDateRange != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Rango seleccionado: ${_selectedDateRange!.start.toLocal()} - ${_selectedDateRange!.end.toLocal()}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
