// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionImpl _$$PromotionImplFromJson(Map<String, dynamic> json) =>
    _$PromotionImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PromotionImplToJson(_$PromotionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentage': instance.percentage,
      'description': instance.description,
    };
