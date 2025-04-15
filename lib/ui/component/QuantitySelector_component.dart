//selccionador de cantidades

import 'package:BusGo/domain/signals/tickets_signals/tickets_signal.dart';
import 'package:BusGo/ui/component/showCustomSnackBar_component.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final String title;
  final ValueChanged<int> onQuantityChanged; // Función callback

  const QuantitySelector({
    Key? key,
    required this.title,
    required this.initialQuantity,
    required this.onQuantityChanged, // Recibimos la función callback
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;
  void _showPromotionDialog() {
    final List<String> promociones = [
      'Promoción de 10%',
      'Promoción de 20%',
      'Promoción de 50%',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Variable local para almacenar la promoción seleccionada.
        String? selectedPromotion;
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Aplicar Promoción',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Contenedor con tamaño limitado para el listado.
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        itemCount: promociones.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, thickness: 1),
                        itemBuilder: (context, index) {
                          String promo = promociones[index];
                          bool isSelected = promo == selectedPromotion;
                          return ListTile(
                            title: Text(
                              promo,
                              style: TextStyle(
                                color: isSelected ? Colors.blue : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle,
                                    color: Colors.blue)
                                : null,
                            selected: isSelected,
                            selectedTileColor: Colors.blue.withOpacity(0.1),
                            onTap: () {
                              setState(() {
                                selectedPromotion = promo;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // minimumSize: const Size(double.infinity, 40),
                      ),
                      onPressed: () {
                        if (selectedPromotion != null) {
                          Navigator.of(context).pop(selectedPromotion);
                          print('Promoción aplicada: $selectedPromotion');
                          // Aquí puedes agregar la lógica adicional para aplicar la promoción.
                        } else {
                          // Opcional: Notificar al usuario que debe seleccionar una promoción.
                          print('Seleccione una promoción antes de aplicar.');
                        }
                      },
                      child: const Text('Aplicar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.title}: ', style: const TextStyle(fontSize: 12)),
        IconButton(
          icon: const Icon(
            Icons.remove_circle_outline,
            size: 18,
          ),
          onPressed: quantity > 0
              ? () {
                  // decreaseQuantity();
                  if (widget.title == 'Menores de Edad') {
                    quantityMenoresSignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(
                        quantity); // Llamamos la función callback
                  } else if (widget.title == 'Pasaje Normal') {
                    quantitySignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(
                        quantity); // Llamamos la función callback
                  } else if (widget.title == 'Adultos Mayores') {
                    quantityAdultsSignal.value--;
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(quantity);
                  } else {
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(quantity);
                    _showPromotionDialog();
                    // Llamamos la función callback
                  }
                }
              : null,
        ),
        Text('$quantity', style: const TextStyle(fontSize: 14)),
        IconButton(
          icon: const Icon(
            Icons.add_circle_outline,
            size: 18,
          ),
          onPressed: () {
            // increaseQuantity();
            if (widget.title == 'Menores de Edad' ||
                widget.title == 'Pasaje Normal' ||
                widget.title == 'Adultos Mayores') {
              if ((quantityMenoresSignal.value +
                      quantitySignal.value +
                      quantityAdultsSignal.value) >=
                  availableSeatsSignal.value) {
                print('No puede seleccionar mas asientos');
                showCustomSnackBar(
                  context: context,
                  title: 'No hay asientos disponibles', // Obligatorio
                  titleColor: Colors.white, // Opcional
                  icon: Icons.check_circle, // Opcional
                  backgroundColor: Colors.red, // Opcional
                  duration: const Duration(seconds: 3), // Opcional
                );
              } else {
                setState(() {
                  quantity++;
                });
                widget.onQuantityChanged(
                    quantity); // Llamamos la función callback
              }
            } else {
              setState(() {
                quantity++;
              });
              widget.onQuantityChanged(quantity);
              // Llamamos la función callback
            }
          },
        ),
        IconButton(
            onPressed: () {
              _showPromotionDialog();
            },
            icon: const Icon(
              Icons.local_offer,
              color: Colors.black26,
            ),
            tooltip: 'asasas',
        ),
        const Text('Promo',
        style: TextStyle(
          fontSize: 10,
          color: Colors.black26
        ),
        )
      ],
    );
  }
}

// Métodos para aumentar o disminuir la cantidad
// void increaseQuantity() {
//   quantitySignal.value += 1;
// }

// void decreaseQuantity() {
//   if (quantitySignal.value > 0) {
//     quantitySignal.value -= 1;
//   }
// }
//******************* */
//selccionador de cantidades
