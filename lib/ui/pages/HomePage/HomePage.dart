
import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Módulos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                // Modules Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ModuleCard(
                      color: Colors.blue,
                      icon: Icons.sell,
                      title: 'Venta',
                      description: 'Módulo de venta de pasajes',
                      route: '/SalesPage',
                    ),
                    ModuleCard(
                      color: Colors.orange,
                      icon: Icons.bar_chart,
                      title: 'Reportes',
                      description: 'Módulo de reportes y estadísticas',
                      
                      route: '/PrinterPage',
                      //route: '/ReportPage',
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Statistics Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estadísticas diarias',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push('/StatisticsPageAll');
                      },
                      child: Text(
                        'Ver todas',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Statistics Cards
                 Column(
                  children: [
                    StatisticCard(
                      color: Colors.green,
                      icon: MdiIcons.ticket,
                      title: 'Total vendido',
                      complement: 'Sucursal Aeropuerto',
                      value: '\$1.358.990',
                    ),
                    SizedBox(height: 10,),
                    StatisticCard(
                      color: Colors.red,
                      icon: MdiIcons.ticketConfirmation,
                      title: 'Total de',
                      complement: 'Tikecks Vendidos',
                      value: '423',
                    ),
                    SizedBox(height: 10,),
                    StatisticCard(
                      color: Colors.blue,
                      icon: MdiIcons.busMarker,
                      title: 'Total de',
                      complement: 'Recorridos',
                      value: '4',
                    ),
                    SizedBox(height: 10,),
                    StatisticCard(
                      color: Colors.orange,
                      icon: MdiIcons.bus,
                      title: 'Total de',
                      complement: 'Buses',
                      value: '12',
                    ),
                   
                   
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      
    
  }
}


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
        width: MediaQuery.of(context).size.width * 0.44,
        height: 170,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

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





