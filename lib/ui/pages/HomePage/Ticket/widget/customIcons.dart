import 'package:flutter/material.dart';
import 'package:BusGo/models/SeatModel.dart';

class CustomSeatIcon extends StatelessWidget {
  final bool isOccupied;
  final bool isSelected;
  final int seatNumber; // Número del asiento

  const CustomSeatIcon({
    super.key,
    required this.isOccupied,
    required this.isSelected,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // Ancho ajustado
      height: 40, // Alto ajustado
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            isSelected
                ? Icons
                    .crop_square_rounded // Nuevo ícono cuando isSelected es true
                : Icons.square_rounded, // Ícono predeterminado
            size: 65,
            color: isOccupied
                ? Colors.black54 // Si está ocupado, color rojo
                : isSelected
                    ? Colors
                        .black54 // Color del borde cuando isSelected es true
                    : Colors.blue,
          ),
          if (isSelected) // Si está ocupado o seleccionado
            Positioned(
              top: 19,
              left: 19,
              child: Text(
                seatNumber.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ), // Número del asiento
              ),
            ),
        ],
      ),
    );
  }
}
