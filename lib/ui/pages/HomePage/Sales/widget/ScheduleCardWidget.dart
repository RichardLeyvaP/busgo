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
    List<String> timeToGo = _calculateTimeToGo(widget.timeIni);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: InkWell(
        onTap: () {
          if (widget.seatsAvailable != 0) {
            dataSelectedRoute(widget.idTrip); // Guardar datos del viaje
            GoRouter.of(context)
                .push('/TicketPage'); // Navegar a la página de asientos
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No hay disponibilidad para este viaje'),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12), // Para efecto visual
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey, width: 0.5)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 12, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoText("Salida en:", timeToGo[0], timeToGo[1]),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Tiempo de Viaje:", travelTime, "min"),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Capacidad:", '${widget.seats}'),
                    const VerticalDivider(
                      width: 5,
                    ),
                    _infoText("Disponibles:", '${widget.seatsAvailable}'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _routeInfo(
                          getRegionFromAddress(
                              widget.origin), // Extraemos la región
                          "Salida: ${widget.timeIni}",
                          Icons.radio_button_checked,
                        ),
                        const SizedBox(height: 16),
                        _routeInfo(
                          getRegionFromAddress(
                              widget.destination), // Extraemos la región
                          "Llegada: ${widget.timeFin}",
                          Icons.location_on,
                          isDestination: true,
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      width: 6,
                    ),
                    Column(
                      children: [
                        CustomButton(
                          title: "\$10000.00",
                          onTap: () {
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
                          color: Colors.green,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _infoText(String title, String value, [String? subtitle]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style:
              TextStyle(fontSize: 14, color: Colors.grey[600], fontFamily: '')),
      Row(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto')),
          const VerticalDivider(
            width: 0.5,
          ),
          if (subtitle != null)
            Text(" $subtitle",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
        ],
      )
    ],
  );
}

Widget _infoPrice(String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w900, color: Colors.orange)),
    ],
  );
}

Widget _routeInfo(
  String title,
  String subtitle,
  IconData icon, {
  bool isDestination = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18, color: isDestination ? Colors.orange : Colors.blue),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            limitTextLength(title, 23),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          // Aquí aplicamos el truncado y el TextOverflow.ellipsis
          Text(
            subtitle, // Limita a 20 caracteres
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
            maxLines: 1, // Limita el texto a una sola línea
            overflow:
                TextOverflow.ellipsis, // Agrega "..." si el texto se desborda
          ),
        ],
      ),
    ],
  );
}

String limitTextLength(String text, int maxLength) {
  if (text.length > maxLength) {
    return '${text.substring(0, maxLength)}...'; // Recorta y agrega "..."
  }
  return text;
}

String getRegionFromAddress(String address) {
  // Dividimos la dirección por las comas y tomamos la última parte
  List<String> parts = address.split(',');
  // Retornamos la última parte, que sería la región
  return parts.isNotEmpty ? parts.last.trim() : '';
}

String _calculateTravelTime(String start, String end) {
  // Convertir los strings en objetos DateTime
  DateTime startTime = DateTime.parse("2024-01-01 $start:00");
  DateTime endTime = DateTime.parse("2024-01-01 $end:00");

  // Diferencia en minutos
  int minutes = endTime.difference(startTime).inMinutes;

  return "$minutes";
}

List<String> _calculateTimeToGo(String start) {
  DateTime now = DateTime.now();
  DateTime startTime = DateTime.parse(
      "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $start:00");

  if (startTime.isBefore(now)) {
    startTime = startTime.add(const Duration(days: 1));
  }

  int minutes = startTime.difference(now).inMinutes;
  int hours = startTime.difference(now).inHours;

  if (minutes > 60) {
    return [hours.toString(), "h"]; // Retorna [valor, unidad]
  } else {
    return [minutes.toString(), "min"]; // Retorna [valor, unidad]
  }
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
