// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketsImpl _$$TicketsImplFromJson(Map<String, dynamic> json) =>
    _$TicketsImpl(
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TicketsImplToJson(_$TicketsImpl instance) =>
    <String, dynamic>{
      'tickets': instance.tickets,
    };

_$TicketImpl _$$TicketImplFromJson(Map<String, dynamic> json) => _$TicketImpl(
      id: (json['id'] as num?)?.toInt(),
      branchId: (json['branchId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      tripId: (json['tripId'] as num?)?.toInt(),
      method: json['method'] as String?,
      status: (json['status'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      price: json['price'] as String?,
      total: json['total'] as String?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      adults: (json['adults'] as num?)?.toInt(),
      minors: (json['minors'] as num?)?.toInt(),
      qr: json['qr'] as String?,
      barcode: json['barcode'] as String?,
      date: json['date'] as String?,
      branchName: json['branchName'] as String?,
      userName: json['userName'] as String?,
      tripName: json['tripName'] as String?,
      originImage: json['originImage'] as String?,
      tripOrigin: json['tripOrigin'] as String?,
      destinationImage: json['destinationImage'] as String?,
      tripDestination: json['tripDestination'] as String?,
      schedule: json['schedule'] as String?,
      print: (json['print'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TicketImplToJson(_$TicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'userId': instance.userId,
      'tripId': instance.tripId,
      'method': instance.method,
      'status': instance.status,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
      'seats': instance.seats,
      'adults': instance.adults,
      'minors': instance.minors,
      'qr': instance.qr,
      'barcode': instance.barcode,
      'date': instance.date,
      'branchName': instance.branchName,
      'userName': instance.userName,
      'tripName': instance.tripName,
      'originImage': instance.originImage,
      'tripOrigin': instance.tripOrigin,
      'destinationImage': instance.destinationImage,
      'tripDestination': instance.tripDestination,
      'schedule': instance.schedule,
      'print': instance.print,
    };
