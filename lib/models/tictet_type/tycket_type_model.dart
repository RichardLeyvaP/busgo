import 'package:freezed_annotation/freezed_annotation.dart';

part 'tycket_type_model.freezed.dart';
part 'tycket_type_model.g.dart';

@freezed
class TicketType with _$TicketType {
  const factory TicketType({
    required int id,
    required String name,
    required String description,
  }) = _TicketType;

  factory TicketType.fromJson(Map<String, dynamic> json) => _$TicketTypeFromJson(json);
}