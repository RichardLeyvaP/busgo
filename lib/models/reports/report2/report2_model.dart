import 'package:freezed_annotation/freezed_annotation.dart';

part 'report2_model.freezed.dart';
part 'report2_model.g.dart';

@freezed
class Report2 with _$Report2 {
  const factory Report2({
    String? nombre,
    String? fecha,
    int? pasejesEmitidos,
    int? reimpresiones,
    List<TotalesPorMetodo>? totalesPorMetodo,
    int? totales,
    List<Tramo>? tramos,
  }) = _Report2;

  factory Report2.fromJson(Map<String, dynamic> json) => _$Report2FromJson(json);
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

@freezed
class Tramo with _$Tramo {
  const factory Tramo({
    String? nombre,
    int? totalPasajes,
    int? totalTramo,
    List<TotalesPorMetodo>? totalesPorMetodo,
  }) = _Tramo;

  factory Tramo.fromJson(Map<String, dynamic> json) => _$TramoFromJson(json);
}
