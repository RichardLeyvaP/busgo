import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
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

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          // ⬅ Usa StatefulBuilder para actualizar el modal
          return Stack(
            children: [
              Positioned.fill(
                  child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.black54,
                ),
              )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.95,
                      padding: const EdgeInsets.fromLTRB(10,10,10,0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Seleccionar rango de fechas",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Expanded(
                            child: TableCalendar(
                              locale: 'es_ES',
                              firstDay: DateTime(2000),
                              lastDay: DateTime(2100),
                              focusedDay: startDate ?? DateTime.now(),
                              availableCalendarFormats: const {
                                CalendarFormat.month: 'Mes',
                                CalendarFormat.twoWeeks: '2 semanas',
                                CalendarFormat.week: 'Semana',
                              },
                              selectedDayPredicate: (day) {
                                if (startDate != null && endDate != null) {
                                  return day.isAfter(startDate!
                                          .subtract(const Duration(days: 1))) &&
                                      day.isBefore(endDate!
                                          .add(const Duration(days: 1)));
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
                                rangeHighlightColor:
                                    Colors.orange.withOpacity(0.3),
                                todayDecoration: const BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                selectedDecoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
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
                                child: const Text("Cancelar"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (startDate != null && endDate != null) {
                                    setState(() {
                                      // ⬅ Actualiza la UI principal
                                      _selectedDateRange = DateTimeRange(
                                          start: startDate!, end: endDate!);
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      // ⬅ Actualiza la UI principal
                                      endDate = startDate!;
                                      _selectedDateRange = DateTimeRange(
                                          start: startDate!, end: endDate!);
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
            return const Center(
                child:
                    CircularProgressIndicator()); // Muestra el indicador de carga
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // Muestra un mensaje de error si hay un problema
          }

          // Aquí debes acceder a los datos cargados, por ejemplo:
          final resultReport2 = resultReport2RP.value;
          final totalesPorMetodos = resultReport2RP.value?.totalesPorMetodo;

          return Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                  child: ElevatedButton(
                    onPressed: _selectDateRange2,
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
                        SizedBox(width: 8), // Espacio entre el icono y el texto
                        Text("Seleccionar Fecha"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(width: .5),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TODO: cambiar el nombre por defecto(-Sin Nombre-) si no tienen resultado, al igual que la fecha
                          Text(resultReport2?.nombre ?? 'Nombre Sucursal',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(
                              "FECHA: ${resultReport2?.fecha ?? '-Sin fecha-'}"),
                          Text(
                              "Sucursal: ${currentUserBranchLG.value?.name ?? '-- No Tiene--'}"),
                          const SizedBox(height: 10),
                          const Text("RESUMEN:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text("EMISIÓN DE PASAJES",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              "Pasajes emitidos: ${resultReport2?.pasejesEmitidos ?? '0'}"),
                          Text(
                              "Reimpresiones: ${resultReport2?.reimpresiones ?? '0'}"),
                          const SizedBox(height: 5),
                          if (totalesPorMetodos != null) ...[
                            for (var totalesPorMetodo in totalesPorMetodos) ...[
                              Text(
                                "${totalesPorMetodo.metodo}: ${totalesPorMetodo.cantidad ?? 0}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ],
                          Text(
                            "TOTAL: \$${resultReport2?.totales ?? 0}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DashedDivider(
                                color: Colors.black,
                                height: 2,
                                dashWidth: 10,
                                dashSpace: 5,
                                endIndent: 5,
                              ),
                              const Text("TRAMOS:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const DashedDivider(
                                color: Colors.black,
                                height: 2,
                                dashWidth: 10,
                                dashSpace: 5,
                                endIndent: 5,
                              ),
                              const SizedBox(height: 5),
                              if (resultReport2?.tramos != null)
                                ...resultReport2!.tramos!.map<Widget>((tramo) {
                                  int efectivo = 0;
                                  int debito = 0;
                                  int credito = 0;

                                  if (tramo.totalesPorMetodo != null) {
                                    var tramototalesPorMetodo =
                                        tramo.totalesPorMetodo;
                                    for (var metodo in tramototalesPorMetodo!) {
                                      if (metodo.metodo == "EFECTIVO")
                                        efectivo = metodo.total ?? 0;
                                      if (metodo.metodo == "TARJETA")
                                        debito = metodo.total ?? 0;
                                      if (metodo.metodo == "CREDITO")
                                        credito = metodo.total ?? 0;
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Llamar al método de impresión aquí
        },
        child: const Icon(Icons.print),
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
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 4,
        ),
        Text('Total pasajes: $totalPasajes'),
        Text('Efectivo: $efectivo'),
        Text('Débito: $debito'),
        Text('Crédito: $credito'),
        const SizedBox(height: 5),
        Text('Total Tramo: \$$totalTramo'),
        Text('Efectivo: \$$efectivoTramo'),
        Text('Débito: \$$debitoTramo'),
        Text('Crédito: \$$creditoTramo'),
        const SizedBox(height: 10),
        const DashedDivider(
          color: Colors.black,
          height: 2,
          dashWidth: 10,
          dashSpace: 5,
          endIndent: 5,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

//espaciador horizontal punteado
class DashedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;
  final double endIndent;

  const DashedDivider({
    super.key,
    this.color = Colors.black,
    this.height = 2,
    this.dashWidth = 10,
    this.dashSpace = 5,
    this.endIndent = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            size: Size.fromHeight(height),
            painter: DashedLinePainter(
              color: color,
              strokeWidth: height,
              dashWidth: dashWidth,
              dashSpace: dashSpace,
            ),
          ),
        ),
        SizedBox(width: endIndent),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
