import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String complement;
  final String value;

  const StatisticCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.complement,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    String formatoChilenoSinSimbolo(int valor) {
      final formatter = NumberFormat('####', 'es_CL');
      return formatter.format(valor);
    }

    int valorInt = double.tryParse(value)?.toInt() ?? 0; // Si falla, usa 0
    String valorFormateado = formatoChilenoSinSimbolo(valorInt);
    return Container(
      width: MediaQuery.of(context).size.width, // Toma el 100% del ancho
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación superior
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity, // Ocupa el máximo alto posible
            ),
            padding: const EdgeInsets.all(16.0), // Separación interna
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child:
                Icon(icon, size: 32, color: Colors.white), // Ícono más grande
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ' $complement',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  valorFormateado,
                  style: TextStyle(
                    fontSize: 22,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
