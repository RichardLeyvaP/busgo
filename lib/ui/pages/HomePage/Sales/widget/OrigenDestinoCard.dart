import 'package:flutter/material.dart';

import '../../../../../domain/signals/sales_signals/sales_signals.dart';
import '../../../../../domain/signals/tickets_signals/tickets_signal.dart';
import '../../../../../models/trips/trips_model.dart';

class OrigenDestinoCard extends StatefulWidget {
  final String origen;
  final String destino;

  const OrigenDestinoCard({
    super.key,
    required this.origen,
    required this.destino,
  });

  @override
  State<OrigenDestinoCard> createState() => _OrigenDestinoCardState();
}

class _OrigenDestinoCardState extends State<OrigenDestinoCard> {
  late String _selectedDestino;

  @override
  void initState() {
    super.initState();
    _selectedDestino = widget.destino; // Usar widget.destino [9]
  }
  // método _showDestinoModal para seleccionar el destino
  void _showDestinoModal(BuildContext context) {
    final trips = tripsSignal.value;
    final isLoading = isLoadingTripsSignal.value;
    final error = tripsErrorSignal.value;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Selecciona un destino",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),

              // Contenido principal
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : error != null
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $error', style: const TextStyle(color: Colors.red)),
                  ),
                )
                    : (trips == null || trips.isEmpty)
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No hay destinos disponibles'),
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _getUniqueDestinations(trips).length,
                  itemBuilder: (context, index) {
                    final destino = _getUniqueDestinations(trips)[index]!;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.place, color: Colors.blue),
                          title: Text(destino),
                          onTap: () {
                            selectedDestinationSignal.value = destino;
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hoverColor: Colors.blue.shade50,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        ),
                        // Línea sutil
                        if (index != _getUniqueDestinations(trips).length - 1)
                          const Divider(
                            height: 2,
                            thickness: 1,
                            color: Colors.black12,
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    );
                  },
                ),
              ),

              const Divider(height: 1),
              // Botones abajo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Cancelar'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(

                        onPressed: () {
                          selectedDestinationSignal.value = null;
                          Navigator.of(context).pop();
                        },
                        child: const FittedBox(

                          fit: BoxFit.scaleDown,
                          child: Text('Mostrar todos', style: TextStyle(
                            fontSize: 50
                          ),),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDestinoOption(String destino) {
    return ListTile(
      title: Text(destino),
      onTap: () {
        setState(() { // Ahora setState está disponible [7]
          _selectedDestino = destino;
        });
        selectedDestinationSignal.value = destino;
        Navigator.pop(context); // Usar context del builder
      },
    );
  }

  List<String?> _getUniqueDestinations(List<Trip> trips) {
    final destinations = trips.map((trip) => trip.destination).toSet();
    return destinations.toList();
  }

  Widget build(BuildContext context) { // Contexto propio del State [5]
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.20,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 13, 15, 19),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna de círculos y línea (sin cambios)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Column(
                    children: [
                      Container(width: 14, height: 14, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                      Expanded(child: CustomPaint(size: const Size(0, 1), painter: DottedLinePainter(), child: const SizedBox(width: 1))),
                      Container(width: 14, height: 14, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                    ],
                  ),
                ),
                const SizedBox(width: 13),
                // Columna de información
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Origen (sin cambios)
                      Text('Origen', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 10)),
                      const SizedBox(height: 1),
                      Text(
                        widget.origen, // Acceso correcto a propiedades [9]
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54),
                      ),
                      const Divider(color: Colors.black38, thickness: 1, endIndent: 30, indent: 1),

                      // Destino (con interacción)
                      Text('Destino', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 10)),
                      const SizedBox(height: 1),
                      GestureDetector(
                        onTap: () => _showDestinoModal(context), // Contexto del build [8]
                        child: Text(
                          _selectedDestino, // Variable de estado [7]
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Painter para la línea punteada vertical
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashHeight = 4;
    const dashSpace = 2;
    double startY = 0;

    // Dibujamos segmentos cortos para simular la línea punteada
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
