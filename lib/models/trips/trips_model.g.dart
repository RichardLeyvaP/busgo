// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripsImpl _$$TripsImplFromJson(Map<String, dynamic> json) => _$TripsImpl(
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TripsImplToJson(_$TripsImpl instance) =>
    <String, dynamic>{
      'trips': instance.trips,
    };

_$TripImpl _$$TripImplFromJson(Map<String, dynamic> json) => _$TripImpl(
      id: (json['id'] as num?)?.toInt(),
      tripId: (json['tripId'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      schedule: json['schedule'] as String?,
      arrival: json['arrival'] as String?,
      seats: (json['seats'] as num?)?.toInt(),
      plate: json['plate'] as String?,
      imageVehicle: json['imageVehicle'] as String?,
      name: json['name'] as String?,
      origin: json['origin'] as String?,
      price: json['price'] as String?,
      originImage: json['originImage'] as String?,
      destination: json['destination'] as String?,
      destinationImage: json['destinationImage'] as String?,
      reservedSeats: (json['reservedSeats'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      seatMap: (json['seatMap'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SeatMap.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$TripImplToJson(_$TripImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'date': instance.date?.toIso8601String(),
      'schedule': instance.schedule,
      'arrival': instance.arrival,
      'seats': instance.seats,
      'plate': instance.plate,
      'imageVehicle': instance.imageVehicle,
      'name': instance.name,
      'origin': instance.origin,
      'price': instance.price,
      'originImage': instance.originImage,
      'destination': instance.destination,
      'destinationImage': instance.destinationImage,
      'reservedSeats': instance.reservedSeats,
      'seatMap': instance.seatMap,
    };

_$SeatMapImpl _$$SeatMapImplFromJson(Map<String, dynamic> json) =>
    _$SeatMapImpl(
      label: json['label'] as String?,
      selected: json['selected'] as bool?,
      disabled: json['disabled'] as bool?,
    );

Map<String, dynamic> _$$SeatMapImplToJson(_$SeatMapImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'selected': instance.selected,
      'disabled': instance.disabled,
    };
