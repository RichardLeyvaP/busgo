// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report1_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Report1Impl _$$Report1ImplFromJson(Map<String, dynamic> json) =>
    _$Report1Impl(
      nombre: json['nombre'] as String?,
      fecha: json['fecha'] as String?,
      pasajesEmitidos: (json['pasajesEmitidos'] as num?)?.toInt(),
      reimpresiones: (json['reimpresiones'] as num?)?.toInt(),
      totalesPorMetodo: (json['totalesPorMetodo'] as List<dynamic>?)
          ?.map((e) => TotalesPorMetodo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totales: (json['totales'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$Report1ImplToJson(_$Report1Impl instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'fecha': instance.fecha,
      'pasajesEmitidos': instance.pasajesEmitidos,
      'reimpresiones': instance.reimpresiones,
      'totalesPorMetodo': instance.totalesPorMetodo,
      'totales': instance.totales,
    };

_$TotalesPorMetodoImpl _$$TotalesPorMetodoImplFromJson(
        Map<String, dynamic> json) =>
    _$TotalesPorMetodoImpl(
      metodo: json['metodo'] as String?,
      total: (json['total'] as num?)?.toInt(),
      cantidad: (json['cantidad'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TotalesPorMetodoImplToJson(
        _$TotalesPorMetodoImpl instance) =>
    <String, dynamic>{
      'metodo': instance.metodo,
      'total': instance.total,
      'cantidad': instance.cantidad,
    };
