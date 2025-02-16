
import 'package:flutter/material.dart';

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
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación superior
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: double.infinity, // Ocupa el máximo alto posible
            ),
            padding: const EdgeInsets.all(16.0), // Separación interna
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Icon(icon, size: 32, color: Colors.white), // Ícono más grande
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
                  value,
                  style: TextStyle(fontSize: 22, color: color,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

