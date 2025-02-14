import 'package:flutter/material.dart';

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
                    ? Colors
                        .blue // Si está seleccionado por el usuario, color azul
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
