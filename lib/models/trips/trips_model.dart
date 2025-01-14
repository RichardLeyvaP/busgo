// To parse this JSON data, do
//
//     final trips = tripsFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';



part 'trips_model.freezed.dart'; // Asegúrate de incluir esta línea
part 'trips_model.g.dart';       // Para la generación de JSON (si no está ya incluida)


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
        int?  seats,
        String?  name,
        String? origin,
        String? price,
        String? originImage,
        String? destination,
        String? destinationImage,
        List<int>? reservedSeats,
    }) = _Trip;

    factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
