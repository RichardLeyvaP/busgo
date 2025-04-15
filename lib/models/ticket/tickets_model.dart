import 'package:freezed_annotation/freezed_annotation.dart';

part 'tickets_model.freezed.dart';
part 'tickets_model.g.dart';

@freezed
class Tickets with _$Tickets {
  const factory Tickets({
    List<Ticket>? tickets,
  }) = _Tickets;

  factory Tickets.fromJson(Map<String, dynamic> json) => _$TicketsFromJson(json);
}

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    int? id,
    int? branchId,
    int? userId,
    int? tripId,
    String? method,
    int? status,
    int? quantity,
    String? price,
    String? total,
    List<int>? seats,
    int? adults,
    int? minors,
    String? qr,
    String? barcode,
    String? date,
    String? branchName,
    String? userName,
    String? tripName,
    String? originImage,
    String? tripOrigin,
    String? destinationImage,
    String? tripDestination,
    String? schedule,
    int? print,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
