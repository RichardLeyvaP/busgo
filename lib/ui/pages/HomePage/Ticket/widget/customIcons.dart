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
      width: 65,
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Flexible(
            child: Icon(
              isSelected ? Icons.event_seat : Icons.event_seat_sharp,
              size: 70,
              color: isOccupied
                  ? Colors.black12
                  : isSelected
                      ? Colors.green
                      : Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
            child: Text(
              seatNumber.toString(),
              style: const TextStyle(
                fontSize: 22,
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
