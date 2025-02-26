// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Report2Impl _$$Report2ImplFromJson(Map<String, dynamic> json) =>
    _$Report2Impl(
      nombre: json['nombre'] as String?,
      fecha: json['fecha'] as String?,
      pasejesEmitidos: (json['pasejesEmitidos'] as num?)?.toInt(),
      reimpresiones: (json['reimpresiones'] as num?)?.toInt(),
      totalesPorMetodo: (json['totalesPorMetodo'] as List<dynamic>?)
          ?.map((e) => TotalesPorMetodo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totales: (json['totales'] as num?)?.toInt(),
      tramos: (json['tramos'] as List<dynamic>?)
          ?.map((e) => Tramo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Report2ImplToJson(_$Report2Impl instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'fecha': instance.fecha,
      'pasejesEmitidos': instance.pasejesEmitidos,
      'reimpresiones': instance.reimpresiones,
      'totalesPorMetodo': instance.totalesPorMetodo,
      'totales': instance.totales,
      'tramos': instance.tramos,
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

_$TramoImpl _$$TramoImplFromJson(Map<String, dynamic> json) => _$TramoImpl(
      nombre: json['nombre'] as String?,
      totalPasajes: (json['totalPasajes'] as num?)?.toInt(),
      totalTramo: (json['totalTramo'] as num?)?.toInt(),
      totalesPorMetodo: (json['totalesPorMetodo'] as List<dynamic>?)
          ?.map((e) => TotalesPorMetodo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TramoImplToJson(_$TramoImpl instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'totalPasajes': instance.totalPasajes,
      'totalTramo': instance.totalTramo,
      'totalesPorMetodo': instance.totalesPorMetodo,
    };
