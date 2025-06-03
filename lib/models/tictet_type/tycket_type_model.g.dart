// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tycket_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketTypeImpl _$$TicketTypeImplFromJson(Map<String, dynamic> json) =>
    _$TicketTypeImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$TicketTypeImplToJson(_$TicketTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
