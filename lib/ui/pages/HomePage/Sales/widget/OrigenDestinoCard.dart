import 'package:flutter/material.dart';

class OrigenDestinoCard extends StatelessWidget {
  final String origen;
  final String destino;

  const OrigenDestinoCard({
    super.key,
    required this.origen,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Ajusta el ancho y alto a tus necesidades
      width: 315,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Columna con los círculos y la línea punteada
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 25),
                child: Column(
                  children: [
                    // Círculo de Origen (azul)
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Línea punteada
                    Expanded(
                      child: CustomPaint(
                        size: const Size(0, 1),
                        painter: DottedLinePainter(),
                        child: const SizedBox(width: 1),
                      ),
                    ),
                    // Círculo de Destino (naranja)
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Columna con la información de Origen y Destino
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Origen',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    const SizedBox(height: 4),
                    // Texto de Origen con máx. 3 líneas
                    Text(
                      origen,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black54),
                    ),
                    // const SizedBox(height: 3),
                    const Divider(
                      color: Colors.black38,
                      thickness: 1,
                      endIndent: 30,
                      indent: 1,
                    ),
                    // const SizedBox(height: 3),
                    Text(
                      'Destino',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    const SizedBox(height: 4),
                    // Texto de Destino con máx. 3 líneas
                    Text(
                      destino,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
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
