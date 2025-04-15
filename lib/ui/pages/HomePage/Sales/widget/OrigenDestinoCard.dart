import 'package:flutter/material.dart';

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
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material( // <-- Agregar este Material [[9]]
          color: Colors.transparent, // Fondo transparente
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Selecciona un destino",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 1, thickness: 1),
                  _buildDestinoOption("Región Metropolitana"),
                  _buildDestinoOption("Puerto Natales"),
                  _buildDestinoOption("Nueva Costanera"),
                  _buildDestinoOption("Región Metropolitana"),
                  _buildDestinoOption("Puerto Natales"),
                  _buildDestinoOption("Nueva Costanera"),
                  _buildDestinoOption("Región Metropolitana"),
                  _buildDestinoOption("Puerto Natales"),
                  _buildDestinoOption("Nueva Costanera"),

                ],
              ),
            ),
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
        Navigator.pop(context); // Usar context del builder
      },
    );
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
