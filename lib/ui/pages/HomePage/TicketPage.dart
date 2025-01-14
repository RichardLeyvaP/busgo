import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/CustomButton.dart';
import 'package:BusGo/ui/component/QuantitySelector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';


class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Stack(
          children: [
             
            Column(
              children: [
                // Header con imagen y título
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                  ),
                  child:  Padding(
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
                             child: Icon(Icons.arrow_back, color:  Colors.white),
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
                       
                        Text(
                          "       ", ),
                      ],
                    ),
                  ),
                ),
                // Card para detalles "From" y "To"
                Expanded(
                  child: Container(
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
                          SizedBox(height: 120,),
                         
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pago de Pasaje",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              PaymentCard(timeIni: "10:00",timeFin: '10:30', price: "5.0",place: '001',amount: 550,),
                              
                             
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        Positioned(
  top: 80,
  // left: (MediaQuery.of(context).size.width - 100) / 2, // Centra horizontalmente
   left: 35, // Centra horizontalmente
   right: 35,
  child:   Container(
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
                                    SizedBox(width: 20,),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                  "ORIGEN",
                                  style: TextStyle(color: Colors.grey[600]),
                                                           ),Text(
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
                                                           ),Text(
                                  "Terminanl de buses Puerto Montt",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                           ),
                                 
                                  ],
                                 ),
                                 
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                children: [
                  Icon(Icons.access_time,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Text(
                    "10:00",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: Icon(MdiIcons.rayStartArrow, size: 24, color: Colors.black),
                  ),
                  Text(
                    '10:30',
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
                        '001',
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
                        '46',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                 
                ],
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

class PaymentCard extends StatelessWidget {
  final String timeIni;
  final String timeFin;
  final String price;
  final String place;
  final int amount;

  PaymentCard({required this.timeIni, required this.price, required this.timeFin, required this.place, required this.amount});

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
                  Column(
                    children: [
                      
                      SizedBox(width: 5,),
                      Row(
                children: [
                  Icon(MdiIcons.currencyUsd,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Precio: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        amount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
                      
                    ],
                  ),
                 
                  SizedBox(height: 10),
                 QuantitySelector(
                      initialQuantity: quantitySignal.value,
                      onQuantityChanged: (newQuantity) {                        
quantitySignal.value = newQuantity;
 // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
    if (newQuantity < selectedSeatNumbersSN.value.length) {
      selectedSeatNumbersSN.value = selectedSeatNumbersSN.value.sublist(0, newQuantity);
    }
                        // context.read<CategoriesPrioritiesBloc>().add(QuantityProductEvent(newQuantity));
                      },
                    ),
                     SizedBox(height: 10,),
                  CustomButton(
            title: "Seleccionar asiento",
            onTap: () {
    //final seats = generateSeats(25, [5, 10]); // Generar asientos
   // final seats = generateSeats(21, [5, 10]); // Generar asientos
    final seats = generateSeats(29, [5, 10]); // Generar asientos
  //  final seats = generateSeats(33, [5, 10]); // Generar asientos
    final int maxPassengers = quantitySignal.value;
    showSeatSelectionModal(context, seats, maxPassengers);
  },
            color: Colors.blue,
            width: 170,
          ),
                 SizedBox(height: 10,), 
                 Row(
                    children: [
                      Text(
                        'Asientos seleccionados: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        selectedSeatNumbersSN.watch(context).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                 SizedBox(height: 10),
                  
                ],
              ),
              
              
              
            ],
          ),
        
          Container(
                                          width: 1000,
                                          height: 1,
                                          color: Colors.grey[400],
                                        ),
                 
      SizedBox(height: 15),
      Row(
                children: [
                  Icon(MdiIcons.receiptOutline,size: 15, color: Colors.black),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Text(
                        'Total a Pagar: ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        (amount*quantitySignal.watch(context)).toString(),
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
       
       CustomButton(
            title: "Comprar Ticket",
            onTap: () {
              print("Botón presionado");
              //GoRouter.of(context).push('/TicketPage');
              // Aquí puedes implementar la lógica deseada
            },
            color: Colors.blue,
            width: 250,
          ),
       
  
        ],
      ),
    );
  }
}

void showSeatSelectionModal(BuildContext context, List<Seat> seats, int maxSelectable) {
  final selectedSeatNumbers1 = ValueNotifier<List<int>>([]);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Selecciona tus asientos (máximo $maxSelectable)",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300, // Altura del grid de asientos
              child: ValueListenableBuilder<List<int>>(
                valueListenable: selectedSeatNumbers1,
                builder: (context, selectedSeats, child) {
                  return buildSeatSelection(seats, maxSelectable, selectedSeatNumbersSN);
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: "Limpiar Selección",
                  onTap: () {
                    selectedSeatNumbers1.value = [];
                    selectedSeatNumbersSN.value = [];
                    for (var seat in seats) {
                      seat.isSelected = false;
                    }
                    (context as Element).markNeedsBuild();
                  },
                  color: Colors.red,
                  width: 160,
                ),
                CustomButton(
                  title: "Confirmar",
                  onTap: () {
                    
                   // selectedSeatNumbersSN.value = selectedSeatNumbers1.value;
                    print("Asientos seleccionados: ${selectedSeatNumbersSN.value}");
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


Widget buildSeatSelection(
    List<Seat> seats, int maxSelectable, Signal<List<int>> selectedSeatNumbersSN) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5, // 5 columnas en total
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1, // Hace los asientos más cuadrados
    ),
    itemCount: seats.length,
    itemBuilder: (context, index) {
      final seat = seats[index];

      if (seat.number == -1) {
        return SizedBox.shrink(); // Espacio para el pasillo
      }

      // Verifica si el asiento está seleccionado
      bool isSelected = selectedSeatNumbersSN.value.contains(seat.number);

      return Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
        children: [
          GestureDetector(
            onTap: seat.isOccupied || (isSelected == false && selectedSeatNumbersSN.value.length >= maxSelectable)
                ? null // Si está ocupado o ya se ha alcanzado el máximo de selecciones, no se puede seleccionar
                : () {
                    // Si el asiento está seleccionado, desmarcarlo
                    if (isSelected) {
                      selectedSeatNumbersSN.value =
                          selectedSeatNumbersSN.value.where((n) => n != seat.number).toList();
                    } 
                    // Si el asiento no está seleccionado, marcarlo
                    else if (selectedSeatNumbersSN.value.length < maxSelectable) {
                      selectedSeatNumbersSN.value = [...selectedSeatNumbersSN.value, seat.number];
                    }
                    (context as Element).markNeedsBuild(); // Forzar actualización visual
                  },
            child: CustomSeatIcon(
              isOccupied: seat.isOccupied,
              isSelected: isSelected, // Asegura que el icono refleje si el asiento está seleccionado
            ),
          ),
          Text(
            seat.number.toString(),
            style: const TextStyle(fontSize: 10), // Número del asiento
          ),
        ],
      );
    },
  );
}

class CustomSeatIcon extends StatelessWidget {
  final bool isOccupied;
  final bool isSelected;

  CustomSeatIcon({required this.isOccupied, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Ancho ajustado
      height: 40, // Alto ajustado
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.event_seat,
            size: 30,
            color: isOccupied
                ? Colors.red // Si está ocupado, color rojo
                : isSelected
                    ? Colors.blue // Si está seleccionado por el usuario, color azul
                    : Colors.green, // Si está disponible, color verde
          ),
          if (isOccupied || isSelected) // Si está ocupado o seleccionado
            Positioned(
              top: 0,
              child: Icon(
                Icons.person,
                size: 15, // Tamaño ajustado para evitar desbordamiento
                color: Colors.blueGrey,
              ),
            ),
        ],
      ),
    );
  }
}



// Widget buildSeatSelection(List<Seat> seats, int maxSelectable, ValueNotifier<List<int>> selectedSeatNumbers) {
//   return GridView.builder(
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 5, // 5 columnas en total (incluido espacio del pasillo)
//       mainAxisSpacing: 15,
//       crossAxisSpacing: 15,
//     ),
//     itemCount: seats.length + (seats.length ~/ 4), // Ajuste para los espacios de pasillo
//     itemBuilder: (context, index) {
//       // Calcular si estamos en la última fila (sin pasillo)
//       final isFinalRow = index >= (seats.length + (seats.length ~/ 4)) - 5;

//       // Índice real en la lista de asientos
//       final rowIndex = index ~/ 5; // Fila actual
//       final seatIndex = isFinalRow
//           ? index - (seats.length ~/ 4) // Última fila sin pasillo
//           : index - rowIndex; // Ajuste por pasillo

//       if (!isFinalRow && (index % 5 == 2)) {
//         // Espacio del pasillo (columna central)
//         return SizedBox.shrink();
//       }

//       if (seatIndex >= seats.length) {
//         return SizedBox.shrink(); // Evitar índices fuera de rango
//       }

//       final seat = seats[seatIndex];

//       return GestureDetector(
//         onTap: seat.isOccupied || (seat.isSelected == false && selectedSeatNumbers.value.length >= maxSelectable)
//             ? null
//             : () {
//                 // Cambiar estado del asiento
//                 seat.isSelected = !seat.isSelected;

//                 if (seat.isSelected) {
//                   selectedSeatNumbers.value = [...selectedSeatNumbers.value, seat.number];
//                 } else {
//                   selectedSeatNumbers.value = selectedSeatNumbers.value.where((n) => n != seat.number).toList();
//                 }

//                 (context as Element).markNeedsBuild(); // Forzar actualización visual
//               },
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: seat.isOccupied
//                 ? Colors.grey // Ocupado
//                 : seat.isSelected
//                     ? Colors.green // Seleccionado
//                     : Colors.blue, // Disponible
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             seat.number.toString(),
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//     },
//   );
// }



// List<Seat> generateSeats(int totalSeats, List<int> occupiedSeats) {
//   return List.generate(
//     totalSeats,
//     (index) {
//       return Seat(
//       number: index + 1,
//       isOccupied: occupiedSeats.contains(index + 1),
//     );
//     },
//   );
// }



            List<Seat> generateSeatsCASICASI(int totalSeats, List<int> occupiedSeats) {
  List<Seat> seats = [];

  // Asientos hasta la penúltima fila (con pasillo en el medio)
  for (int i = 1; i <= totalSeats - 6; i += 4) {
    seats.add(Seat(number: i, isOccupied: occupiedSeats.contains(i)));
    seats.add(Seat(number: i + 1, isOccupied: occupiedSeats.contains(i + 1)));
    seats.add(Seat(number: -1, isOccupied: false)); // Representa el pasillo
    seats.add(Seat(number: i + 2, isOccupied: occupiedSeats.contains(i + 2)));
    seats.add(Seat(number: i + 3, isOccupied: occupiedSeats.contains(i + 3)));
  }

  // Última fila sin pasillo, con los asientos completos
  if (totalSeats >= 21) {
    seats.add(Seat(number: totalSeats - 4, isOccupied: occupiedSeats.contains(totalSeats - 4)));
    seats.add(Seat(number: totalSeats - 3, isOccupied: occupiedSeats.contains(totalSeats - 3)));
    seats.add(Seat(number: totalSeats - 2, isOccupied: occupiedSeats.contains(totalSeats - 2)));
    seats.add(Seat(number: totalSeats - 1, isOccupied: occupiedSeats.contains(totalSeats - 1)));
  }

  return seats;
}
List<Seat> generateSeats(int totalSeats, List<int> occupiedSeats) {
  List<Seat> seats = [];

  // Asientos hasta la penúltima fila (con pasillo en el medio)
  for (int i = 1; i <= totalSeats - 5; i += 4) {
    seats.add(Seat(number: i, isOccupied: occupiedSeats.contains(i)));
    seats.add(Seat(number: i + 1, isOccupied: occupiedSeats.contains(i + 1)));
    seats.add(Seat(number: -1, isOccupied: false)); // Representa el pasillo
    seats.add(Seat(number: i + 2, isOccupied: occupiedSeats.contains(i + 2)));
    seats.add(Seat(number: i + 3, isOccupied: occupiedSeats.contains(i + 3)));
  }

  // Última fila sin pasillo, con los asientos completos
  if (totalSeats > 20) {
    for (int i = totalSeats - 5 + 1; i <= totalSeats; i++) {  // Ajuste aquí para empezar en 21
      seats.add(Seat(number: i, isOccupied: occupiedSeats.contains(i)));
    }
  }

  return seats;
}





