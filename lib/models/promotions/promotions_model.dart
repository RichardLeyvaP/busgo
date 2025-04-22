// promotions_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotions_model.freezed.dart';
part 'promotions_model.g.dart';

@freezed
class Promotion with _$Promotion {
  factory Promotion({
    required int id,           // <-- Cambiado a required (siempre viene del API)
    required String name,      // <-- required (el API siempre lo envía)
    String? description,       // <-- Permite nulos (si el API lo permite)
    required int percentage,   // <-- Cambiado a int (coincide con el API)
    @Default(true) bool active,
  }) = _Promotion;

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  double applyDiscount(double price) {
    return price * (1 - (percentage / 100));
  }
}
