import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
import 'package:BusGo/env.dart';
import 'package:BusGo/ui/component/CustomButton.dart';
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
  

  ScheduleCard(
      {required this.timeIni,
      required this.price,
      required this.timeFin,
      required this.place,
      required this.amount,
      required this.seats,
      required this.seatsAvailable,
      required this.idTrip,
      required this.originImage,
      required this.destinationImage, required this.name, required this.plate, required this.reservedSeats, required this.origin, required this.destination});

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 15, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        widget.timeIni,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
                      ),
                      Text(
                        widget.timeFin,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(MdiIcons.bus, size: 15, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        'Bus: ${widget.place}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(MdiIcons.seatReclineExtra, size: 15, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        'Capacidad: ${widget.seats}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  widget.seatsAvailable == 0
                      ? CustomButton(
                          title: "Saliendo",
                          onTap: () {},
                          color: Colors.red,
                        )
                      : CustomButton(
                          title: "Seleccionar",
                                          onTap: () {
                  if(widget.seatsAvailable != 0)
                  {
                    dataSelectedRoute(widget.idTrip);
                  GoRouter.of(context).push('/TicketPage');
                  }
                  else{
                     ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('No hay disponibilidad para este viaje')),
                                            );
                  }
                 
                  // Aquí puedes implementar la lógica deseada
                },
                          color: Colors.blue,
                        ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.carSeat,
                        size: 15,
                        color: widget.seatsAvailable == 0 ? Colors.red : Colors.green,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Disponible: ${widget.seatsAvailable}',
                        style: TextStyle(
                          color: widget.seatsAvailable == 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded; // Cambiar el estado para expandir o contraer
              });
            },
            child: !isExpanded? Column(
              children: [
                Text('Más detalles', style: TextStyle(fontSize: 8, color: Colors.black87)),
                Icon(MdiIcons.chevronDown, size: 20, color: Colors.black),
              ],
            ):
            Column(
              children: [
                Text('Menos detalles', style: TextStyle(fontSize: 8, color: Colors.black87)),
                Icon(MdiIcons.chevronUp, size: 20, color: Colors.black),
              ],
            ),
          ),
          // Aquí es donde se agrega el contenido adicional que se muestra al expandir
          if (isExpanded) ...[
           
            TripDetailsCard(
  name: widget.name,
  origin: widget.origin,
  destination: widget.destination,
  arrival: "14:30",
  seats: 4,
  price: widget.price,
  plate: widget.plate,
  originImage: '${Env.apiEndpoint}/images/${widget.originImage}',
  destinationImage: '${Env.apiEndpoint}/images/${widget.destinationImage}',
  reservedSeats: widget.reservedSeats,
)

          ]
        ],
      ),
    );
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
