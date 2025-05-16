import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes de Boletines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Resumen de Boletines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ReportCard(
              title: 'Boletines Vendidos',
              count: '1500',
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            ReportCard(
              title: 'Boletines Cancelados',
              count: '300',
              icon: Icons.cancel,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  ReportCard({required this.title, required this.count, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          count,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
