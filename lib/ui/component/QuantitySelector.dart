//selccionador de cantidades

import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
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

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${widget.title}: ', style: TextStyle(fontSize: 14)),
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: quantity > 0
              ? () {
                 // decreaseQuantity();
                  setState(() {
                    quantity--;
                  });
                  widget.onQuantityChanged(quantity); // Llamamos la función callback
                }
              : null,
        ),
        Text('$quantity', style: TextStyle(fontSize: 16)),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
           // increaseQuantity();
            setState(() {
              quantity++;
            });
            widget.onQuantityChanged(quantity); // Llamamos la función callback
          },
        ),
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