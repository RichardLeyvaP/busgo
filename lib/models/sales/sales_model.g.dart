// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesImpl _$$SalesImplFromJson(Map<String, dynamic> json) => _$SalesImpl(
      sales: (json['sales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList(),
      salesYear: (json['salesYear'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      trips: (json['trips'] as List<dynamic>?)
          ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesImplToJson(_$SalesImpl instance) =>
    <String, dynamic>{
      'sales': instance.sales,
      'salesYear': instance.salesYear,
      'trips': instance.trips,
    };

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
      title: json['title'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      color: json['color'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'color': instance.color,
      'icon': instance.icon,
    };

_$TripImpl _$$TripImplFromJson(Map<String, dynamic> json) => _$TripImpl(
      id: (json['id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      vehicleImage: json['vehicleImage'] as String?,
      vehiclePlate: json['vehiclePlate'] as String?,
      route: json['route'] as String?,
      horario: json['horario'] as String?,
      capacidad: (json['capacidad'] as num?)?.toInt(),
      asientosVendidos: (json['asientosVendidos'] as num?)?.toInt(),
      dineroGenerado: (json['dineroGenerado'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TripImplToJson(_$TripImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'vehicleImage': instance.vehicleImage,
      'vehiclePlate': instance.vehiclePlate,
      'route': instance.route,
      'horario': instance.horario,
      'capacidad': instance.capacidad,
      'asientosVendidos': instance.asientosVendidos,
      'dineroGenerado': instance.dineroGenerado,
    };
