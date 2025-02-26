import 'package:freezed_annotation/freezed_annotation.dart';

part 'report1_model.freezed.dart';
part 'report1_model.g.dart';

@freezed
class Report1 with _$Report1 {
  const factory Report1({
    String? nombre,
    String? fecha,
    int? pasajesEmitidos,
    int? reimpresiones,
    List<TotalesPorMetodo>? totalesPorMetodo,
    int? totales,
  }) = _Report1;

  factory Report1.fromJson(Map<String, dynamic> json) => _$Report1FromJson(json);
}

@freezed
class TotalesPorMetodo with _$TotalesPorMetodo {
  const factory TotalesPorMetodo({
    String? metodo,
    int? total,
    int? cantidad,
  }) = _TotalesPorMetodo;

  factory TotalesPorMetodo.fromJson(Map<String, dynamic> json) => _$TotalesPorMetodoFromJson(json);
}
