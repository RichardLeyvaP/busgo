import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotions_model.freezed.dart';
part 'promotions_model.g.dart';

@freezed
class Promotion with _$Promotion {
  @JsonSerializable(explicitToJson: true)
  factory Promotion({
    required int id,
    required String name,
    String? description,
    required int percentage,
    @Default(true) bool active,
  }) = _Promotion;
  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
  double applyDiscount(double price) {
    return price * (1 - (percentage / 100));
  }
}
