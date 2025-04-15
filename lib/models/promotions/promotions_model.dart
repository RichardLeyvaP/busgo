// promotions_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotions_model.freezed.dart';
part 'promotions_model.g.dart';

@freezed
class Promotion with _$Promotion {
  factory Promotion({
     int? id,
     String? name,
     double? percentage,
     String? description,
  }) = _Promotion;

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
}
