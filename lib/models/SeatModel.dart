class Seat {
  final int number;
  bool isOccupied;
  bool isSelected;

  Seat({
    required this.number,
    this.isOccupied = false,
    this.isSelected = false,
  });
}