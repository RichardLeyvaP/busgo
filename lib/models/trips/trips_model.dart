import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'trips_model.freezed.dart';
part 'trips_model.g.dart';

// Funciones para convertir entre JSON y objetos
Trips tripsFromJson(String str) => Trips.fromJson(json.decode(str));
String tripsToJson(Trips data) => json.encode(data.toJson());

@freezed
class Trips with _$Trips {
  const factory Trips({
    List<Trip>? trips,
  }) = _Trips;

  factory Trips.fromJson(Map<String, dynamic> json) => _$TripsFromJson(json);
}

@freezed
class Trip with _$Trip {
  const factory Trip({
    int? id,
    int? tripId,
    DateTime? date,
    String? schedule,
    String? arrival,
    int? seats,
    String? plate,
    String? imageVehicle,
    String? name,
    String? origin,
    String? price,
    String? originImage,
    String? destination,
    String? destinationImage,
    List<int>? reservedSeats,
    List<List<SeatMap>>? seatMap,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

@freezed
class SeatMap with _$SeatMap {
  const factory SeatMap({
    String? label,  // Hacerlo nullable
    bool? selected,  // Hacerlo nullable
    bool? disabled,  // Hacerlo nullable
  }) = _SeatMap;

  factory SeatMap.fromJson(Map<String, dynamic> json) => _$SeatMapFromJson(json);
}

