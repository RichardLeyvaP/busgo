
import 'package:BusGo/domain/signals/tickets/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/CustomButton.dart';
import 'package:BusGo/ui/component/QuantitySelector.dart';
import 'package:BusGo/ui/component/showCustomSnackBar.dart';
import 'package:BusGo/ui/component/showJsonDialog.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/TicketPage.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/customIcons.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';

class PaymentCard extends StatefulWidget {
  final String timeIni;
  final String timeFin;
  final String price;

  PaymentCard(
      {required this.timeIni, required this.price, required this.timeFin});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  


  @override
  void initState() {
    super.initState();
   
  }

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
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(MdiIcons.currencyUsd,
                              size: 15, color: Colors.black),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Precio: ',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                widget.price.toString(),
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
                    title: 'Mayores de edad  ',
                    initialQuantity: quantitySignal.value,//cantidad de mayores
                    onQuantityChanged: (newQuantity) {

                      if((quantityMenoresSignal.value + quantitySignal.value) >= availableSeatsSignal.value)
                      {
                        print('No puede seleccionar mas asientos');
                        

                      }
                      else{
                        if ((quantitySignal.value +
                              quantityMenoresSignal.value) <=
                          tripsSelectSignal.value!.seats!) {}
                      quantitySignal.value = newQuantity;
                      // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
                      if ((newQuantity + quantityMenoresSignal.value) <
                          selectedSeatNumbersSN.value.length) {
                        selectedSeatNumbersSN.value =
                            selectedSeatNumbersSN.value.sublist(
                                0, (newQuantity + quantityMenoresSignal.value));
                      }
                      // context.read<CategoriesPrioritiesBloc>().add(QuantityProductEvent(newQuantity));

                      }
                

                      
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  QuantitySelector(
                    title: 'Menores 50% Valor',
                    initialQuantity: quantityMenoresSignal.value,
                    onQuantityChanged: (newQuantity) {
                      quantityMenoresSignal.value = newQuantity;
                      // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
                      if ((newQuantity + quantitySignal.value) <
                          selectedSeatNumbersSN.value.length) {
                        selectedSeatNumbersSN.value = selectedSeatNumbersSN
                            .value
                            .sublist(0, (newQuantity + quantitySignal.value));
                      }
                      // context.read<CategoriesPrioritiesBloc>().add(QuantityProductEvent(newQuantity));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    
                    title: "Seleccionar asiento",
                    onTap: () {
                      double total = ((double.parse(widget.price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(widget.price)) * quantitySignal.watch(context));
                      if(total > 0   ){
                         final seats = utilsTicket.generateSeats(
                          29,
                          tripsSelectSignal
                              .value!.reservedSeats!); // Generar asientos
                      //  final seats = generateSeats(33, [5, 10]); // Generar asientos
                      final int maxPassengers =
                          quantitySignal.value + quantityMenoresSignal.value;
                      showSeatSelectionModal(context, seats, maxPassengers);

                      }
                      else{
                        showCustomSnackBar(
        context: context,
        title: 'Seleccione la cantidad de asientos', // Obligatorio
        backgroundColor: Colors.red
      );
                      }
                      //final seats = generateSeats(25, [5, 10]); // Generar asientos
                      // final seats = generateSeats(21, [5, 10]); // Generar asientos
                      
                     
                    },
                    color: ((double.parse(widget.price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(widget.price)) * quantitySignal.watch(context)) >0 ?Colors.blue :
          const Color.fromARGB(255, 167, 171, 173),
                    width: 170,
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
          // SizedBox(height: 15),
          // AdditionalDataWidget(
          //   onDataChanged: (newDevice, newDescription, newDteType, newContact) {
          //     device = newDevice;
          //     description = newDescription;
          //     dteType = newDteType;
          //     contact = newContact;
          //   },
          // ),
          // SizedBox(height: 15),
          Container(
            width: 1000,
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(MdiIcons.cash, size: 20, color: Colors.black),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Text(
                    'Total a Pagar: ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    //(double.parse(price) * quantitySignal.watch(context)) +
                    (((double.parse(widget.price) / 2) *
                                quantityMenoresSignal.watch(context)) +
                            ((double.parse(widget.price)) *
                                quantitySignal.watch(context)))
                        .toStringAsFixed(2),

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
             
              
            ],
          ),
         
          // SizedBox(height: 25),
          // CustomButton(
          //   title: "Comprar Ticket ",
          //   onTap: () async {
          //     await verifyPurchaseTicket(context);
          //   },
          //   color: Colors.blue,
          //   width: 250,
          // ),
           Container(
                height: 300,
              )
        ],
      ),
    );
  }

  Future<void> verifyPurchaseTicket(context) async {
    if (selectedSeatNumbersSN.value.length <= 0) //no hay asientos seleccionados
    {
      showCustomSnackBar(
        context: context,
        title: 'No hay asientos seleccionados', // Obligatorio
        backgroundColor: Colors.red
      );
    } else //td bien
    {
      double total = ((double.parse(widget.price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(widget.price)) * quantitySignal.watch(context));
      
     Map<String, dynamic> jsonResponse =  await handlePayment(
      total,
      -1,//cashback,
      48,//dteType,
      [],//customFields,
      0,//exemptAmount,
      null,//externalReferenceId,
      false,//flagAccountPayProvider,
     null,// idProviderAccount,
     0,// netAmount,
     "",// sourceName,
     "",// sourceVersion,
     "",// taxIdnValidation,
      -1,//installmentsQuantity,
      0,//method,
      false,//printVoucherOnApp,
      -1//tip
      );
      showJsonDialog(context, jsonResponse); // Muestra el diálogo con el JSON recibido
    }
  }
}

void showSeatSelectionModal(
    BuildContext context, List<Seat> seats, int maxSelectable) {
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
                  return buildSeatSelection(
                      seats, maxSelectable, selectedSeatNumbersSN);
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
                    print(
                        "Asientos seleccionados: ${selectedSeatNumbersSN.value}");
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

Widget buildSeatSelection(List<Seat> seats, int maxSelectable,
    Signal<List<int>> selectedSeatNumbersSN) {
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
            onTap: seat.isOccupied ||
                    (isSelected == false &&
                        selectedSeatNumbersSN.value.length >= maxSelectable)
                ? null // Si está ocupado o ya se ha alcanzado el máximo de selecciones, no se puede seleccionar
                : () {
                    // Si el asiento está seleccionado, desmarcarlo
                    if (isSelected) {
                      selectedSeatNumbersSN.value = selectedSeatNumbersSN.value
                          .where((n) => n != seat.number)
                          .toList();
                    }
                    // Si el asiento no está seleccionado, marcarlo
                    else if (selectedSeatNumbersSN.value.length <
                        maxSelectable) {
                      selectedSeatNumbersSN.value = [
                        ...selectedSeatNumbersSN.value,
                        seat.number
                      ];
                    }
                    (context as Element)
                        .markNeedsBuild(); // Forzar actualización visual
                  },
            child: CustomSeatIcon(
              isOccupied: seat.isOccupied,
              isSelected:
                  isSelected, // Asegura que el icono refleje si el asiento está seleccionado
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
