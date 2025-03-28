import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_services.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Report1Page extends StatefulWidget {
  const Report1Page({super.key});

  @override
  _Report1PageState createState() => _Report1PageState();
}

class _Report1PageState extends State<Report1Page> {
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
    await getReports1(-999, 'ya esta por defecto en el metodo',
        DateFormat('yyyy-MM-dd').format(DateTime.now()), null);
  }

  Future<void> _selectDateRange() async {
    DateTime today = DateTime.now();
    startDate ??= today;
    endDate ??= today;

    await showDialog(
      // <-- Cambia a showDialog
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Stack(
              children: [
                // Fondo semitransparente
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(color: Colors.black54),
                  ),
                ),
                // Card flotante
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.65,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Seleccionar rango de fechas",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 15),
                            Expanded(
                              child: TableCalendar(
                                firstDay: DateTime(2000),
                                lastDay: DateTime(2100),
                                focusedDay: startDate ?? DateTime.now(),
                                selectedDayPredicate: (day) {
                                  if (startDate != null && endDate != null) {
                                    return day.isAfter(startDate!.subtract(
                                            const Duration(days: 1))) &&
                                        day.isBefore(endDate!
                                            .add(const Duration(days: 1)));
                                  }
                                  return day == startDate;
                                },
                                onDaySelected: (selectedDay, _) {
                                  setModalState(() {
                                    if (startDate == null ||
                                        (startDate != null &&
                                            endDate != null)) {
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
                                  rangeHighlightColor:
                                      Colors.orange.withOpacity(0.3),
                                  todayDecoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                  selectedDecoration: const BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (startDate != null && endDate != null) {
                                      setState(() {
                                        _selectedDateRange = DateTimeRange(
                                            start: startDate!, end: endDate!);
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        endDate = startDate!;
                                        _selectedDateRange = DateTimeRange(
                                            start: startDate!, end: endDate!);
                                      });
                                      Navigator.pop(context);
                                    }
                                    await getReports1(
                                        -999,
                                        'ya esta por defecto en el método',
                                        formatDate(startDate),
                                        formatDate(endDate));
                                    setState(() {});
                                  },
                                  child: const Text("Aceptar"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _reportDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          String fechaIni = DateTime.now().toLocal().toString().split(' ')[0];
          final totalesPorMetodos = resultReport1RP.value?.totalesPorMetodo;
          if (_selectedDateRange?.start != null) {
            if (_selectedDateRange!.start == _selectedDateRange!.end) {
              fechaIni =
                  "${_selectedDateRange!.start.toLocal().toString().split(' ')[0]}";
            } else {
              fechaIni =
                  "${_selectedDateRange!.start.toLocal().toString().split(' ')[0]} - ${_selectedDateRange!.end.toLocal().toString().split(' ')[0]}";
            }
          }

          return Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: ElevatedButton(
                      onPressed: _selectDateRange,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8), // Ajusta el padding si es necesario
                      ),
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
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: .5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // currentUserBranchCompanyLG.value?.name ??
                        currentUserBranchLG.value?.name ??
                            '-- No tiene --',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          "FECHA: ${resultReport1RP.value?.fecha ?? fechaIni}"),
                      Text(
                          "Sucursal: ${currentUserBranchLG.value?.name ?? '-- No tiene --'}"),
                      const SizedBox(height: 10),
                      const Text("RESUMEN:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text("EMISIÓN DE PASAJES",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          "Pasajes emitidos: ${resultReport1RP.value?.pasajesEmitidos ?? 0}"),
                      Text(
                          "Reimpresiones: ${resultReport1RP.value?.reimpresiones ?? 0}"),
                      if (totalesPorMetodos != null) ...[
                        for (var totalesPorMetodo in totalesPorMetodos) ...[
                          Text(
                            "${totalesPorMetodo.metodo}: ${totalesPorMetodo.cantidad ?? 0}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                      const SizedBox(height: 10),
                      if (totalesPorMetodos != null) ...[
                        const Text("TOTALES:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        for (var totalesPorMetodo in totalesPorMetodos) ...[
                          Text(
                            "${totalesPorMetodo.metodo}: \$${totalesPorMetodo.total ?? 0}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                      Text(
                        "TOTAL: \$${resultReport1RP.value?.totales ?? 0}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
