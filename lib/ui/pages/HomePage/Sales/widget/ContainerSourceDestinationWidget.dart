import 'package:flutter/material.dart';

class ContainerSourceDestinationWidget extends StatelessWidget {
  const ContainerSourceDestinationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(//container de origen y
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(height: 5),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 5),
                  const Icon(Icons.location_on, color: Color.fromARGB(255, 85, 105, 143)),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ORIGEN",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const Text(
                    "Aeropuerto el Tepual",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "DESTINO",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const Text(
                    "Terminal de buses Puerto Montt",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

