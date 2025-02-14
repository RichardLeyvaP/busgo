import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTikecket.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/paymentCard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TicketPage extends StatefulWidget {
  @override
  State<TicketPage> createState() => _TicketPageState();
}

final utilsTicket = UtilsTicket();

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    utilsTicket.verifyPurchaseTicketClass(context, tripsSelectSignal.value!.price.toString());
  },
  backgroundColor: Colors.blue,
  label: Row(
    children: [
      Icon(MdiIcons.ticket, color: Colors.white),
      SizedBox(width: 8),
      Text('Comprar Ticket', style: TextStyle(fontSize: 14)),
    ],
  ),
),


      
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado fijo
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      "Ticket",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40), // Espaciador para equilibrar
                  ],
                ),
              ),
            ),
            // Contenido desplazable
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none, // Permite que el Card sobresalga
                  children: [
                    // Contenedor blanco de detalles
                    Container(
                      margin: EdgeInsets.only(top: 160), // Empuja hacia abajo
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 100), // Espacio para el Card superior
                            Text(
                              "Pago de Pasaje",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            PaymentCard(
                              timeIni: tripsSelectSignal.value!.schedule.toString(),
                              timeFin: '10:30xxx',
                              price: tripsSelectSignal.value!.price.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Tarjeta flotante con detalles del ticket
                    Positioned(
                      top: 0, // Ajusta la posición de la tarjeta flotante
                      left: 35,
                      right: 35,
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Icon(Icons.location_on, color: Color(0xFF55698F)),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("ORIGEN", style: TextStyle(color: Colors.grey[600])),
                                        Text(
                                          tripsSelectSignal.value!.origin.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Divider(color: Colors.grey[400]),
                                        SizedBox(height: 4),
                                        Text("DESTINO", style: TextStyle(color: Colors.grey[600])),
                                        Text(
                                          tripsSelectSignal.value!.destination.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 15, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text(
                                    tripsSelectSignal.value!.schedule.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
                                  ),
                                  Text(
                                    tripsSelectSignal.value!.arrival.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(MdiIcons.bus, size: 15, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text('Bus: ', style: TextStyle(color: Colors.grey[600])),
                                  Text(
                                    tripsSelectSignal.value!.plate.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(MdiIcons.seatReclineExtra, size: 15, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text('Capacidad: ', style: TextStyle(color: Colors.grey[600])),
                                  Text(
                                    tripsSelectSignal.value!.seats.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
  
    );
  }
}























// import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
// import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTikecket.dart';
// import 'package:BusGo/ui/pages/HomePage/Ticket/widget/paymentCard.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class TicketPage extends StatefulWidget {
//   @override
//   State<TicketPage> createState() => _TicketPageState();
// }

// final utilsTicket = UtilsTicket();

// class _TicketPageState extends State<TicketPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[400],
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Encabezado fijo
//             Container(
//               height: 80,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.blue[400],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
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
//                     Text(
//                       "Ticket",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(width: 40), // Espaciador para equilibrar
//                   ],
//                 ),
//               ),
//             ),
//             // Contenido desplazable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Contenedor con información del ticket
//                     SizedBox(height: 20),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 35),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade400,
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   Icon(Icons.location_on, color: Colors.blue),
//                                   SizedBox(height: 5),
//                                   Container(
//                                     width: 1,
//                                     height: 40,
//                                     color: Colors.grey[400],
//                                   ),
//                                   SizedBox(height: 5),
//                                   Icon(Icons.location_on, color: Color(0xFF55698F)),
//                                 ],
//                               ),
//                               SizedBox(width: 20),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("ORIGEN", style: TextStyle(color: Colors.grey[600])),
//                                     Text(
//                                       tripsSelectSignal.value!.origin.toString(),
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Divider(color: Colors.grey[400]),
//                                     SizedBox(height: 4),
//                                     Text("DESTINO", style: TextStyle(color: Colors.grey[600])),
//                                     Text(
//                                       tripsSelectSignal.value!.destination.toString(),
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Icon(Icons.access_time, size: 15, color: Colors.black),
//                               SizedBox(width: 5),
//                               Text(
//                                 tripsSelectSignal.value!.schedule.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                                 child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
//                               ),
//                               Text(
//                                 tripsSelectSignal.value!.arrival.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 5),
//                           Row(
//                             children: [
//                               Icon(MdiIcons.bus, size: 15, color: Colors.black),
//                               SizedBox(width: 5),
//                               Text('Bus: ', style: TextStyle(color: Colors.grey[600])),
//                               Text(
//                                 tripsSelectSignal.value!.plate.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 5),
//                           Row(
//                             children: [
//                               Icon(MdiIcons.seatReclineExtra, size: 15, color: Colors.black),
//                               SizedBox(width: 5),
//                               Text('Capacidad: ', style: TextStyle(color: Colors.grey[600])),
//                               Text(
//                                 tripsSelectSignal.value!.seats.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // Card de detalles "From" y "To"
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             SizedBox(height: 20),
//                             Text(
//                               "Pago de Pasaje",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             PaymentCard(
//                               timeIni: tripsSelectSignal.value!.schedule.toString(),
//                               timeFin: '10:30xxx',
//                               price: tripsSelectSignal.value!.price.toString(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















// import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
// import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTikecket.dart';
// import 'package:BusGo/ui/pages/HomePage/Ticket/widget/paymentCard.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class TicketPage extends StatefulWidget {
//   @override
//   State<TicketPage> createState() => _TicketPageState();
// }
// final utilsTicket = UtilsTicket();

// class _TicketPageState extends State<TicketPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[400],
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 // Header con imagen y título
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.blue[400],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             GoRouter.of(context).pop();
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 8.0),
//                             child: Icon(Icons.arrow_back, color: Colors.white),
//                           ),
//                         ),
//                         Text(
//                           "Ticket",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "       ",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Card para detalles "From" y "To"
//                 Flexible(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 150,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Pago de Pasaje",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               PaymentCard(
//                                   timeIni: tripsSelectSignal.value!.schedule
//                                       .toString(),
//                                   timeFin: '10:30xxx',
//                                   price: tripsSelectSignal.value!.price
//                                       .toString()),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 80,
//               // left: (MediaQuery.of(context).size.width - 100) / 2, // Centra horizontalmente
//               left: 35, // Centra horizontalmente
//               right: 35,
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade400,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: [
//                               Icon(Icons.location_on, color: Colors.blue),
//                               SizedBox(height: 5),
//                               Container(
//                                 width: 1,
//                                 height: 40,
//                                 color: Colors.grey[400],
//                               ),
//                               SizedBox(height: 5),
//                               Icon(Icons.location_on,
//                                   color: const Color.fromARGB(255, 85, 105, 143)),
//                             ],
//                           ),
//                           SizedBox(width: 20),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "ORIGEN",
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                                 Text(
//                                   tripsSelectSignal.value!.origin.toString(),
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                   softWrap: true,
//                                   overflow: TextOverflow.visible,
//                                 ),
//                                 SizedBox(height: 4),
//                                 Divider(color: Colors.grey[400]),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "DESTINO",
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                                 Text(
//                                   tripsSelectSignal.value!.destination.toString(),
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                   softWrap: true,
//                                   overflow: TextOverflow.visible,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Icon(Icons.access_time, size: 15, color: Colors.black),
//                           SizedBox(width: 5),
//                           Text(
//                             tripsSelectSignal.value!.schedule.toString(),
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 5, right: 5),
//                             child: Icon(MdiIcons.rayStartArrow,
//                                 size: 24, color: Colors.black),
//                           ),
//                           Text(
//                             tripsSelectSignal.value!.arrival.toString(),
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Icon(MdiIcons.bus, size: 15, color: Colors.black),
//                           SizedBox(width: 5),
//                           Row(
//                             children: [
//                               Text(
//                                 'Bus: ',
//                                 style: TextStyle(color: Colors.grey[600]),
//                               ),
//                               Text(
//                                 tripsSelectSignal.value!.plate
//                                     .toString(), //tripsSelectSignal.value!.schedule.toString(),//chapa
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Icon(MdiIcons.seatReclineExtra,
//                               size: 15, color: Colors.black),
//                           SizedBox(width: 5),
//                           Row(
//                             children: [
//                               Text(
//                                 'Capacidad: ',
//                                 style: TextStyle(color: Colors.grey[600]),
//                               ),
//                               Text(
//                                 tripsSelectSignal.value!.seats.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
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

