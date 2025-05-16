import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModuleCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final String route;

  const ModuleCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await fetchTrips(1);
        GoRouter.of(context).push(route);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 175,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
