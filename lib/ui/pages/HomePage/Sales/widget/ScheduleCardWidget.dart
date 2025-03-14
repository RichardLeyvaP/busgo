import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:BusGo/domain/signals/login_signals/login_signal.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/env.dart';
import 'package:BusGo/ui/component/CustomButton_component.dart';
import 'package:BusGo/ui/pages/HomePage/Sales/widget/TripDetailsCardWidged.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScheduleCard extends StatefulWidget {
  final String name;
  final String origin;
  final String destination;
  final String plate;
  final String originImage;
  final String destinationImage;
  final String timeIni;
  final String timeFin;
  final String price;
  final String place;
  final int amount;
  final int seats;
  final int idTrip;
  final int seatsAvailable;
  final List<int> reservedSeats;

  const ScheduleCard(
      {super.key,
      required this.timeIni,
      required this.price,
      required this.timeFin,
      required this.place,
      required this.amount,
      required this.seats,
      required this.seatsAvailable,
      required this.idTrip,
      required this.originImage,
      required this.destinationImage,
      required this.name,
      required this.plate,
      required this.reservedSeats,
      required this.origin,
      required this.destination});

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String travelTime = _calculateTravelTime(widget.timeIni, widget.timeFin);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoText("Salida en:", "2 min"),
                  const VerticalDivider(
                    width: 10,
                  ),
                  _infoText("Tiempo de Viaje:", travelTime),
                  const VerticalDivider(
                    width: 10,
                  ),
                  _infoText("Capacidad:", '${widget.seats}'),
                  const VerticalDivider(
                    width: 10,
                  ),
                  _infoText("Disponibles:", '${widget.seatsAvailable}'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Column(
                    children: [
                      _routeInfo(
                          "Aeropuerto El Tepual",
                          "Salida: ${widget.timeIni}",
                          Icons.radio_button_checked),
                      _routeInfo("Terminal Puerto Montt",
                          "Llegada: ${widget.timeFin}", Icons.location_on,
                          isDestination: true),
                    ],
                  ),
                  const VerticalDivider(
                    width: 25,
                  ),
                  Column(
                    children: [
                      _infoPrice("Precio:", '\$'),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(50, 36),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            if (widget.seatsAvailable != 0) {
                              dataSelectedRoute(
                                  widget.idTrip); // Guardar datos del viaje
                              GoRouter.of(context).push(
                                  '/TicketPage'); // Navegar a la página de asientos
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'No hay disponibilidad para este viaje'),
                                ),
                              );
                            }
                          },
                          child: const Text("Seleccionar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _infoText(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      Text(value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _infoPrice(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
      Text(value,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
    ],
  );
}

Widget _routeInfo(String title, String subtitle, IconData icon,
    {bool isDestination = false}) {
  return Row(
    children: [
      Icon(icon, size: 15, color: isDestination ? Colors.orange : Colors.blue),
      const SizedBox(width: 6),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(subtitle,
              style: TextStyle(color: Colors.grey[700], fontSize: 10)),
        ],
      ),
    ],
  );
}

String _calculateTravelTime(String start, String end) {
  // Convertir los strings en objetos DateTime
  DateTime startTime = DateTime.parse("2024-01-01 $start:00");
  DateTime endTime = DateTime.parse("2024-01-01 $end:00");

  // Diferencia en minutos
  int minutes = endTime.difference(startTime).inMinutes;

  return "$minutes min";
}


// import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
// import 'package:BusGo/ui/component/CustomButton.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class ScheduleCard extends StatelessWidget {
//   final String originImage;
//   final String destinationImage;
//   final String timeIni;
//   final String timeFin;
//   final String price;
//   final String place;
//   final int amount;
//   final int seats;
//   final int idTrip;
//   final int seatsAvailable;

//   ScheduleCard({required this.timeIni, required this.price, required this.timeFin, required this.place, required this.amount, required this.seats, required this.seatsAvailable, required this.idTrip, required this.originImage, required this.destinationImage});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.access_time,size: 15, color: Colors.black),
//                       SizedBox(width: 5,),
//                       Text(
//                         timeIni,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 5,right: 5),
//                         child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
//                       ),
//                       Text(
//                         timeFin,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(MdiIcons.bus,size: 15, color: Colors.black),
//                       SizedBox(width: 5,),
//                       Row(
//                         children: [
//                           Text(
//                             'Bus: ',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                           Text(
//                             place,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(MdiIcons.seatReclineExtra,size: 15, color: Colors.black),
//                       SizedBox(width: 5,),
//                       Row(
//                         children: [
//                           Text(
//                             'Capacidad: ',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                           Text(
//                             seats.toString(),
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
                 
                  
//                 ],
//               ),
              
              
//               Column(
//                 children: [
//                  seatsAvailable == 0 ? CustomButton(
//                 title: "Saliendo",
//                 onTap: () {
//                    if(seatsAvailable != 0)
//                   {
//                   GoRouter.of(context).push('/TicketPage');
//                   }
//                   else{
//                      ScaffoldMessenger.of(context).showSnackBar(
//                                               const SnackBar(
//                                                   content: Text('No hay disponibilidad para este viaje')),
//                                             );
//                   }
//                   // Aquí puedes implementar la lógica deseada
//                 },
//                 color: Colors.red,
//               )
//                 :
          
//                 CustomButton(
//                 title: "Seleccionar",
//                 onTap: () {
//                   if(seatsAvailable != 0)
//                   {
//                     dataSelectedRoute(idTrip);
//                   GoRouter.of(context).push('/TicketPage');
//                   }
//                   else{
//                      ScaffoldMessenger.of(context).showSnackBar(
//                                               const SnackBar(
//                                                   content: Text('No hay disponibilidad para este viaje')),
//                                             );
//                   }
                 
//                   // Aquí puedes implementar la lógica deseada
//                 },
//                 color: Colors.blue,
//               )
//                   ,
//                   SizedBox(height: 5),
//                 seatsAvailable == 0 ?  Row(
//                     children: [
//                       Icon(MdiIcons.carSeat,size: 15, color: Colors.red),
//                       SizedBox(width: 5,),
//                       Row(
//                         children: [
//                           Text(
//                             'Disponible: ',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                           Text(
//                             seatsAvailable.toString(),
//                             style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ):
//                   Row(
//                     children: [
//                       Icon(MdiIcons.carSeat,size: 15, color: Colors.green),
//                       SizedBox(width: 5,),
//                       Row(
//                         children: [
//                           Text(
//                             'Disponible: ',
//                             style: TextStyle(color: Colors.green),
//                           ),
//                           Text(
//                             seatsAvailable.toString(),
//                             style: TextStyle( color: Colors.green,fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                   ,
                  
//                 ],
//               ),
              
//             ],
//           ),
          
//            Column(
//              children: [
//               Text('Mas Detalles',style: TextStyle(fontSize: 8,color: Colors.black87),),
//                Icon(MdiIcons.chevronDown, size: 20, color: Colors.black),
//              ],
//            )

//         ],
//       ),
//     );
//   }
// }
