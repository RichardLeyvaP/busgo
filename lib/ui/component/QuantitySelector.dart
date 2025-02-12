//selccionador de cantidades

import 'package:BusGo/domain/signals/tickets/tickets_signal.dart';
import 'package:BusGo/ui/component/showCustomSnackBar.dart';
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
                  if(widget.title == 'Menores 50% Valor' )
           {
            quantityMenoresSignal.value --;
            setState(() {
                    quantity--;
                  });
                  widget.onQuantityChanged(quantity); // Llamamos la función callback
            
           }
           else 
            if(widget.title == 'Mayores de edad  ' )
              { 
                quantitySignal.value --;
                setState(() {
                    quantity--;
                  });
                  widget.onQuantityChanged(quantity); // Llamamos la función callback
            
           }
           else{

             setState(() {
                    quantity--;
                  });
                  widget.onQuantityChanged(quantity); // Llamamos la función callback

           }



                 
                }
              : null,
        ),
        Text('$quantity', style: TextStyle(fontSize: 16)),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
           // increaseQuantity();
           if(widget.title == 'Menores 50% Valor' || widget.title == 'Mayores de edad  ')
           {
            if((quantityMenoresSignal.value + quantitySignal.value) >= availableSeatsSignal.value)
                      {
                        print('No puede seleccionar mas asientos');
                         showCustomSnackBar(
        context: context,
        title: 'No hay asientos disponibles', // Obligatorio
        titleColor: Colors.white, // Opcional
        icon: Icons.check_circle, // Opcional
        backgroundColor: Colors.red, // Opcional
        duration: Duration(seconds: 5), // Opcional
      );

                      }
                      else
                      {
                        setState(() {
              quantity++;
            });
            widget.onQuantityChanged(quantity); // Llamamos la función callback

                      }

           }
           else{
            setState(() {
              quantity++;
            });
            widget.onQuantityChanged(quantity); // Llamamos la función callback
           }
            
            
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