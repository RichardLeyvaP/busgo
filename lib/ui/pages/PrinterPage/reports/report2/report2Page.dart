import 'package:BusGo/domain/signals/reports_signals/reports_services.dart';
import 'package:BusGo/domain/signals/reports_signals/reports_signals.dart';
import 'package:flutter/material.dart';

class Report2Page extends StatefulWidget {
  const Report2Page({super.key});

  @override
  _Report2PageState createState() => _Report2PageState();
}

class _Report2PageState extends State<Report2Page> {
  late Future<void> _reportDataFuture;

  @override
  void initState() {
    super.initState();
    _reportDataFuture = _loadReportData();
  }

  Future<void> _loadReportData() async {
    // Aquí puedes llamar al método que obtenga los datos, como getReports2(id, type, date, endDate)
    await getReports2(1, 'Company', '2025-02-13', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _reportDataFuture,
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

          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                        "TOTAL: \$178.500",
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
