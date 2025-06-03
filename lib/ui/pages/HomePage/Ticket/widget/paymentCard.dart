import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/models/SeatModel.dart';
import 'package:BusGo/ui/component/CustomButton_component.dart';
import 'package:BusGo/ui/component/QuantitySelector_component.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:BusGo/ui/component/showJsonDialog_component.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/classUtilsTicket.dart';
import 'package:BusGo/ui/pages/HomePage/Ticket/widget/customIcons.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:signals/signals_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../models/promotions/promotions_model.dart';

class PaymentCard extends StatefulWidget {
  final String timeIni;
  final String timeFin;
  final String price;

  const PaymentCard(
      {super.key, required this.timeIni, required this.price, required this.timeFin});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final Map<String, Promotion?> _selectedPromotions = {
    'Pasaje Normal': null,
    'Menores de Edad': null,
    'Adultos Mayores': null,

  };


  @override
  void initState() {
    super.initState();
  }

  String formatoChilenoSinSimbolo(int valor) {
    final formatter = NumberFormat('####', 'es_CL');
    return formatter.format(valor);
  }
  @override
  Widget build(BuildContext context) {
    final double precioBase = double.parse(widget.price);

    String value=(((_getPriceWithDiscount('Pasaje Normal', precioBase) *
        quantitySignal.watch(context)) +
        (_getPriceWithDiscount(
            'Menores de Edad', precioBase) *
            quantityMenoresSignal.watch(context)) +
        (_getPriceWithDiscount(
            'Adultos Mayores', precioBase) *
            quantityAdultsSignal.watch(context))))
        .toStringAsFixed(2);
    int valorInt = double.tryParse(value)?.toInt() ?? 0;  // Si falla, usa 0
    String valorFormateado = formatoChilenoSinSimbolo(valorInt);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 5),
                  QuantitySelector(
                    title: 'Pasaje   Normal   ',
                    initialQuantity: quantitySignal.value, //cantidad de mayores
                    onQuantityChanged: (newQuantity) {
                      if ((quantityMenoresSignal.value +
                              quantitySignal.value) >=
                          availableSeatsSignal.value) {
                        print('No puede seleccionar mas asientos');
                      } else {
                        if ((quantitySignal.value +
                                quantityMenoresSignal.value +
                                quantityAdultsSignal.value) <=
                            tripsSelectSignal.value!.seats!) {}
                        quantitySignal.value = newQuantity;
                        // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
                        if ((newQuantity +
                                quantityMenoresSignal.value +
                                quantityAdultsSignal.value) <
                            selectedSeatNumbersSN.value.length) {
                          selectedSeatNumbersSN.value =
                              selectedSeatNumbersSN.value.sublist(
                                  0,
                                  (newQuantity +
                                      quantityMenoresSignal.value +
                                      quantityAdultsSignal.value));
                        }
                        // context.read<CategoriesPrioritiesBloc>().add(QuantityProductEvent(newQuantity));
                      }
                    },
                    onPromotionApplied: (promo) {
                      // <-- Agregar esto
                      setState(
                          () => _selectedPromotions['Pasaje Normal'] = promo);
                    },
                  ),
                  QuantitySelector(
                    title: 'Menores de Edad',
                    initialQuantity: quantityMenoresSignal.value,
                    onQuantityChanged: (newQuantity) {
                      quantityMenoresSignal.value = newQuantity;
                      // Si la nueva cantidad es menor que la cantidad de asientos seleccionados, eliminamos los asientos extra
                      if ((newQuantity +
                              quantitySignal.value +
                              quantityAdultsSignal.value) <
                          selectedSeatNumbersSN.value.length) {
                        selectedSeatNumbersSN.value =
                            selectedSeatNumbersSN.value.sublist(
                                0,
                                (newQuantity +
                                    quantitySignal.value +
                                    quantityAdultsSignal.value));
                      }
                      // context.read<CategoriesPrioritiesBloc>().add(QuantityProductEvent(newQuantity));
                    },
                    onPromotionApplied: (promo) {
                      // <-- Agregar esto
                      setState(
                          () => _selectedPromotions['Menores de Edad'] = promo);
                    },
                  ),
                  QuantitySelector(
                    title: 'Adultos Mayores ',
                    initialQuantity: quantityAdultsSignal.value,
                    onQuantityChanged: (newQuantity) {
                      quantityAdultsSignal.value = newQuantity;
                      if ((newQuantity +
                              quantitySignal.value +
                              quantityMenoresSignal.value) <
                          selectedSeatNumbersSN.value.length) {
                        selectedSeatNumbersSN.value =
                            selectedSeatNumbersSN.value.sublist(
                                0,
                                (newQuantity +
                                    quantitySignal.value +
                                    quantityMenoresSignal.value));
                      }
                    },
                    onPromotionApplied: (promo) {
                      // <-- Agregar esto
                      setState(
                          () => _selectedPromotions['Adultos Mayores'] = promo);
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    title: "Seleccionar asiento",
                    onTap: () {
                      final seats = generateSeatsFromTrip(tripsSelectSignal.value!);
                      final int maxPassengers = quantitySignal.value +
                          quantityMenoresSignal.value +
                          quantityAdultsSignal.value;
                      showSeatSelectionModal(context, seats, maxPassengers);

                    },
                    color: ((double.parse(widget.price) / 2) *
                                    quantityMenoresSignal.watch(context)) +
                                ((double.parse(widget.price)) *
                                    quantitySignal.watch(context)) +
                                ((double.parse(widget.price)) *
                                    quantityAdultsSignal.watch(context)) >
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
                      valorFormateado,
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

  double _getPriceWithDiscount(String ticketType, double basePrice) {
    final promo = _selectedPromotions[ticketType];
    if (promo != null) {
      return basePrice * (1 - promo.percentage / 100);
    }
    return basePrice;
  }

  Future<void> verifyPurchaseTicket(context) async {
    if (selectedSeatNumbersSN.value.isEmpty) //no hay asientos seleccionados
    {
      showCustomSnackBar(
          context: context,
          title: 'No hay asientos seleccionados', // Obligatorio
          backgroundColor: Colors.red);
    } else //td bien
    {
      double total = ((double.parse(widget.price) / 2) *
              quantityMenoresSignal.watch(context)) +
          ((double.parse(widget.price)) * quantitySignal.watch(context)) +
          ((double.parse(widget.price)) * quantityAdultsSignal.watch(context));

      totalToPaySignal.value = total.sign;

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

void showSeatSelectionModal(
    BuildContext context,
    List<Seat> seats,
    int maxSelectable
    ) {
  final selectedSeatNumbers1 = ValueNotifier<List<int>>([]);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            height: MediaQuery.of(context).size.height * 0.70,
            child: Watch.builder(                         // :contentReference[oaicite:1]{index=1}
              builder: (ctx) {
                final selectedSeats = selectedSeatNumbersSN.value;
                return LayoutBuilder(
                  builder: (c, cons) {
                    final w = cons.maxWidth;
                    const minW = 60.0;
                    final cols = (w / minW).floor().clamp(2, 6);
                    final cell = w / cols;
                    return GridView.builder(
                     padding: const EdgeInsets.all(8),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: seats.length,
                      itemBuilder: (c2, i) {
                        final seat = seats[i];
                        if (seat.number == -1) return const SizedBox.shrink();
                        final isSel = selectedSeats.contains(seat.number);
                        return GestureDetector(
                          onTap: seat.isOccupied ||
                              (!isSel &&
                                  selectedSeats.length >= maxSelectable)
                              ? null
                              : () {
                            if (isSel) {
                              selectedSeatNumbersSN.value =
                                  selectedSeatNumbersSN.value
                                      .where((n) => n != seat.number)
                                      .toList();
                            } else {
                              selectedSeatNumbersSN.value = [
                                ...selectedSeatNumbersSN.value,
                                seat.number
                              ];
                            }
                          },
                          child: CustomSeatIcon(
                            isOccupied: seat.isOccupied,
                            isSelected: isSel,
                            seatNumber: seat.number,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
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
    ),
  );
}

Widget buildSeatSelection(
    List<Seat> seats,
    int maxSelectable,
    Signal<List<int>> selectedSeatNumbersSN,
    ) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
    ),
    itemCount: seats.length,
    itemBuilder: (context, index) {
      final seat = seats[index];

      bool isSelected = selectedSeatNumbersSN.value.contains(seat.number);

      return GestureDetector(
        onTap: seat.isOccupied ||
            (!isSelected && selectedSeatNumbersSN.value.length >= maxSelectable)
            ? null
            : () {
          if (isSelected) {
            selectedSeatNumbersSN.value =
                selectedSeatNumbersSN.value.where((n) => n != seat.number).toList();
          } else {
            selectedSeatNumbersSN.value = [
              ...selectedSeatNumbersSN.value,
              seat.number,
            ];
          }
          (context as Element).markNeedsBuild();
        },
        child: CustomSeatIcon(
          isOccupied: seat.isOccupied,
          isSelected: isSelected,
          seatNumber: seat.number,
        ),
      );
    },
  );
}

