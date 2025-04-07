import 'package:BusGo/domain/signals/tickets_signals/tickets_service.dart';
import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/CustomButton_component.dart';
import 'package:BusGo/ui/component/QuantitySelector_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/component/showJsonDialog_component.dart';
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
//TODO Arreglar el fornt de esto
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 3),
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
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        children: [
                          Icon(MdiIcons.currencyUsd,
                              size: 15, color: Colors.black),
                          const SizedBox(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  QuantitySelector(
                    title: 'Mayores de edad  ',
                    initialQuantity: quantitySignal.value, //cantidad de mayores
                    onQuantityChanged: (newQuantity) {
                      if ((quantityMenoresSignal.value +
                              quantitySignal.value) >=
                          availableSeatsSignal.value) {
                        print('No puede seleccionar mas asientos');
                      } else {
                        if ((quantitySignal.value +
                                quantityMenoresSignal.value) <=
                            tripsSelectSignal.value!.seats!) {}
                        quantitySignal.value = newQuantity;
                        // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
                        if ((newQuantity + quantityMenoresSignal.value) <
                            selectedSeatNumbersSN.value.length) {
                          selectedSeatNumbersSN.value =
                              selectedSeatNumbersSN.value.sublist(0,
                                  (newQuantity + quantityMenoresSignal.value));
                        }
                      }
                    },
                  ),
                  const SizedBox(
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
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "Seleccionar asiento",
                    onTap: () {
                      double total = ((double.parse(widget.price) / 2) *
                              quantityMenoresSignal.watch(context)) +
                          ((double.parse(widget.price)) *
                              quantitySignal.watch(context));
                      if (total > 0) {
                        final seats = utilsTicket.generateSeats(
                            29,
                            tripsSelectSignal
                                .value!.reservedSeats!); // Generar asientos
                        //  final seats = generateSeats(33, [5, 10]); // Generar asientos
                        final int maxPassengers =
                            quantitySignal.value + quantityMenoresSignal.value;
                        showSeatSelectionModal(context, seats, maxPassengers);
                      } else {
                        showCustomSnackBar(
                            context: context,
                            title:
                                'Seleccione la cantidad de asientos', // Obligatorio
                            backgroundColor: Colors.red);
                      }
                      //final seats = generateSeats(25, [5, 10]); // Generar asientos
                      // final seats = generateSeats(21, [5, 10]); // Generar asientos
                    },
                    color: ((double.parse(widget.price) / 2) *
                                    quantityMenoresSignal.watch(context)) +
                                ((double.parse(widget.price)) *
                                    quantitySignal.watch(context)) >
                            0
                        ? Colors.blue
                        : const Color.fromARGB(255, 167, 171, 173),
                    width: MediaQuery.of(context).devicePixelRatio * 121,
                  ),
                  const SizedBox(
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
          Container(
            width: 1000,
            height: 1,
            color: Colors.grey[400],
          ),
          Container(
            width: 1000,
            height: 1,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(MdiIcons.cash, size: 20, color: Colors.black),
              const SizedBox(
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

                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
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
          backgroundColor: Colors.red);
    } else //td bien
    {
      double total = ((double.parse(widget.price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(widget.price)) * quantitySignal.watch(context));

      Map<String, dynamic> jsonResponse = await handlePayment(
          total,
          -1, //cashback,
          48, //dteType,
          [], //customFields,
          0, //exemptAmount,
          null, //externalReferenceId,
          false, //flagAccountPayProvider,
          null, // idProviderAccount,
          0, // netAmount,
          "", // sourceName,
          "", // sourceVersion,
          "", // taxIdnValidation,
          -1, //installmentsQuantity,
          0, //method,
          false, //printVoucherOnApp,
          -1 //tip
          );
      showJsonDialog(
          context, jsonResponse); // Muestra el diálogo con el JSON recibido
    }
  }
}

//TODO: resololucion
void showSeatSelectionModal(
    BuildContext context, List<Seat> seats, int maxSelectable) {
  final selectedSeatNumbers1 = ValueNotifier<List<int>>([]);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 5,
          bottom: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      selectedSeatNumbers1.value = [];
                      selectedSeatNumbersSN.value = [];
                      for (var seat in seats) {
                        seat.isSelected = false;
                      }
                      (context as Element).markNeedsBuild();
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),

                  const SizedBox(width: 40), // Espaciador para equilibrar
                ],
              ),
            ),
            Text(
              "Selecciona tus asientos (máximo $maxSelectable)",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            const Text(
              'La posición de los asientos que se muestran en el plano es solamente de referencia, por tanto puede variar',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.65, // Altura del grid de asientos
              child: ValueListenableBuilder<List<int>>(
                valueListenable: selectedSeatNumbers1,
                builder: (context, selectedSeats, child) {
                  return buildSeatSelection(
                      seats, maxSelectable, selectedSeatNumbersSN);
                },
              ),
            ),
            // const SizedBox(height: 5),
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
                  width: 170,
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
      // mainAxisSpacing: 5,
      crossAxisSpacing: 15,
    ),
    itemCount: seats.length,
    itemBuilder: (context, index) {
      final seat = seats[index];

      if (seat.number == -1) {
        return const SizedBox.shrink(); // Espacio para el pasillo
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
              isSelected: isSelected,
              seatNumber: seat
                  .number, // Asegura que el icono refleje si el asiento está seleccionado
            ),
          ),
        ],
      );
    },
  );
}
