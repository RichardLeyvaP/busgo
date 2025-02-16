import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'sales_model.freezed.dart';
part 'sales_model.g.dart';

@freezed
class Sales with _$Sales {
    const factory Sales({
        List<Sale>? sales,
        List<int>? salesYear,
        List<Trip>? trips,
    }) = _Sales;

    factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);
}

@freezed
class Sale with _$Sale {
    const factory Sale({
        String? title,
        double? value,
        String? color,
        String? icon,
    }) = _Sale;

    factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}

@freezed
class Trip with _$Trip {
    const factory Trip({
        int? id,
        DateTime? date,
        String? vehicleImage,
        String? vehiclePlate,
        String? route,
        String? horario,
        int? capacidad,
        int? asientosVendidos,
        int? dineroGenerado,
    }) = _Trip;

    factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
