class Ticket {
  final int? id;
  final int branchId;
  final int tripId;
  final String method;
  final int status;
  final int quantity;
  final double price;
  final List<int> seats;
  final String date;
  final int adults;
  final int minors;
  final double total;
  final String? transactionStatus;
  final String? sequenceNumber;
  final double? transactionTip;
  final double? transactionCashback;
  final DateTime? printedAt;

  Ticket({
    this.id,
    required this.branchId,
    required this.tripId,
    required this.method,
    required this.status,
    required this.quantity,
    required this.price,
    required this.seats,
    required this.date,
    required this.adults,
    required this.minors,
    required this.total,
    this.printedAt,
    this.transactionStatus,
    this.sequenceNumber,
    this.transactionTip,
    this.transactionCashback,
  });

  // Convertir a Map para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branchId': branchId,
      'tripId': tripId,
      'method': method,
      'status': status,
      'quantity': quantity,
      'price': price,
      'seats': seats,
      'date': date,
      'adults': adults,
      'minors': minors,
      'total': total,
      'transactionStatus': transactionStatus,
      'sequenceNumber': sequenceNumber,
      'transactionTip': transactionTip,
      'transactionCashback': transactionCashback,
      'printedAt': printedAt,
    };
  }

  // Crear un ticket desde un Map
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      branchId: map['branchId'],
      tripId: map['tripId'],
      method: map['method'],
      status: map['status'],
      quantity: map['quantity'],
      price: map['price'],
      seats: map['seats'],
      date: map['date'],
      adults: map['adults'],
      minors: map['minors'],
      total: map['total'],
      transactionStatus: map['transactionStatus'],
      sequenceNumber: map['sequenceNumber'],
      transactionTip: map['transactionTip'],
      transactionCashback: map['transactionCashback'],
      printedAt: map['printedAt']
    );
  }
}
