import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/ui/component/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: [
            // Header con imagen y título
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Icon(MdiIcons.busMultiple, color: Colors.white, size: 100),
                      ],
                    ),
                    Text('      '),
                  ],
                ),
              ),
            ),
            // Card para detalles "From" y "To"
            Expanded(  // Añadimos Expanded para que ocupe el espacio restante
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Icons.location_on, color: Colors.blue),
                                        SizedBox(height: 5),
                                        Container(
                                          width: 1,
                                          height: 40,
                                          color: Colors.grey[400],
                                        ),
                                        SizedBox(height: 5),
                                        Icon(Icons.location_on, color: const Color.fromARGB(255, 85, 105, 143)),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ORIGEN",
                                          style: TextStyle(color: Colors.grey[600]),
                                        ),
                                        Text(
                                          "Aeropuerto el Tepual",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          width: 200,
                                          height: 1,
                                          color: Colors.grey[400],
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "DESTINO",
                                          style: TextStyle(color: Colors.grey[600]),
                                        ),
                                        Text(
                                          "Terminal de buses Puerto Montt",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          tripsSignal.watch(context) == null || tripsSignal.watch(context)!.isEmpty
                              ? Center(
                                  child: Text(
                                    "No hay recorridos disponibles",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: tripsSignal.watch(context)!.length,
                                  itemBuilder: (context, index) {
                                    final trip = tripsSignal.watch(context)![index];
                                    return ScheduleCard(
                                      timeIni: trip.schedule?.split('-')[0] ?? "N/A",
                                      timeFin: trip.schedule != null && trip.schedule!.contains('-') 
                                          ? trip.schedule!.split('-')[1] 
                                          : "N/A",
                                      price: trip.price ?? "0.0",
                                      place: trip.name ?? "Desconocido",
                                      amount: trip.seats ?? 0,
                                      seats: trip.seats ?? 0,
                                      seatsAvailable: trip.seats! - (trip.reservedSeats!.length),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class SalesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[400],
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header con imagen y título
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.blue[400],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         GoRouter.of(context).pop();
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 8.0),
//                         child: Icon(Icons.arrow_back, color: Colors.white),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Icon(MdiIcons.busMultiple, color: Colors.white, size: 100),
//                       ],
//                     ),
//                     Text('      '),
//                   ],
//                 ),
//               ),
//             ),
//             // Card para detalles "From" y "To"
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade400,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Icon(Icons.location_on, color: Colors.blue),
//                                       SizedBox(height: 5),
//                                       Container(
//                                         width: 1,
//                                         height: 40,
//                                         color: Colors.grey[400],
//                                       ),
//                                       SizedBox(height: 5),
//                                       Icon(Icons.location_on, color: const Color.fromARGB(255, 85, 105, 143)),
//                                     ],
//                                   ),
//                                   SizedBox(width: 20),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "ORIGEN",
//                                         style: TextStyle(color: Colors.grey[600]),
//                                       ),
//                                       Text(
//                                         "Aeropuerto el Tepual",
//                                         style: TextStyle(fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(height: 12),
//                                       Container(
//                                         width: 200,
//                                         height: 1,
//                                         color: Colors.grey[400],
//                                       ),
//                                       SizedBox(height: 12),
//                                       Text(
//                                         "DESTINO",
//                                         style: TextStyle(color: Colors.grey[600]),
//                                       ),
//                                       Text(
//                                         "Terminanl de buses Puerto Montt",
//                                         style: TextStyle(fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         tripsSignal.watch(context) == null || tripsSignal.watch(context)!.isEmpty
//                             ? Center(
//                                 child: Text(
//                                   "No hay recorridos disponibles",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontStyle: FontStyle.italic,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               )
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: BouncingScrollPhysics(),
//                                 itemCount: tripsSignal.watch(context)!.length,
//                                 itemBuilder: (context, index) {
//                                   final trip = tripsSignal.watch(context)![index];
//                                   return ScheduleCard(
//                                     timeIni: trip.schedule?.split('-')[0] ?? "N/A",
//                                     timeFin: trip.schedule != null && trip.schedule!.contains('-') 
//           ? trip.schedule!.split('-')[1] 
//           : "N/A",

//                                     price: trip.price ?? "0.0",
//                                     place: trip.name ?? "Desconocido",
//                                     amount: trip.seats ?? 0,
//                                     seats: trip.seats??0,
//                                     seatsAvailable: trip.seats! - (trip.reservedSeats!.length )  ,
//                                   );
//                                 },
//                               ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class ScheduleCard extends StatelessWidget {
  final String timeIni;
  final String timeFin;
  final String price;
  final String place;
  final int amount;
  final int seats;
  final int seatsAvailable;

  ScheduleCard({required this.timeIni, required this.price, required this.timeFin, required this.place, required this.amount, required this.seats, required this.seatsAvailable});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Text(
                    timeIni,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
                  ),
                  Text(
                    timeFin,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(MdiIcons.bus,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Bus: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        place,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(MdiIcons.seatReclineExtra,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Capacidad: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        seats.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          
          
          Column(
            children: [
             seatsAvailable ==0 ? CustomButton(
            title: "Saliendo",
            onTap: () {
               if(seatsAvailable != 0)
              {
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
            color: Colors.red,
          )
            :

            CustomButton(
            title: "Seleccionar",
            onTap: () {
              if(seatsAvailable != 0)
              {
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
          )
              ,
              SizedBox(height: 5),
            seatsAvailable == 0 ?  Row(
                children: [
                  Icon(MdiIcons.carSeat,size: 15, color: Colors.red),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Disponible: ',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        seatsAvailable.toString(),
                        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ):
              Row(
                children: [
                  Icon(MdiIcons.carSeat,size: 15, color: Colors.green),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Disponible: ',
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        seatsAvailable.toString(),
                        style: TextStyle( color: Colors.green,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
              ,
              
            ],
          ),
        ],
      ),
    );
  }
}
