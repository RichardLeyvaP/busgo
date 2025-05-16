import 'package:flutter/material.dart';

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
      width: 55,
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Flexible(
            child: Icon(
              isSelected ? Icons.event_seat : Icons.event_seat_sharp,
              size: 60,
              color: isOccupied
                  ? Colors.black12
                  : isSelected
                      ? Colors.green
                      : Colors.blue,
            ),
          ),
          Padding(
            //TODO: cambiar el padding
            padding: const EdgeInsets.fromLTRB(5,0, 0, 10),
            child: Text(
              seatNumber.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
