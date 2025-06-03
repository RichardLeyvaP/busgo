import 'package:freezed_annotation/freezed_annotation.dart';

import '../promotions/promotions_model.dart';
import '../tictet_type/tycket_type_model.dart';
import '../trips/trips_model.dart';

part 'trip_date_response.freezed.dart';
part 'trip_date_response.g.dart';

@freezed
class TripDateResponse with _$TripDateResponse {
  @JsonSerializable(explicitToJson: true)
  const factory TripDateResponse({
    required List<Trips> trips,
    required List<Promotion> promotions,
    required List<TicketType> tickettypes,
  }) = _TripDateResponse;


  factory TripDateResponse.fromJson(Map<String, dynamic> json) =>
      _$TripDateResponseFromJson(json);
}