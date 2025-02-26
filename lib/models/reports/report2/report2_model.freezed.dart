// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report2_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Report2 _$Report2FromJson(Map<String, dynamic> json) {
  return _Report2.fromJson(json);
}

/// @nodoc
mixin _$Report2 {
  String? get nombre => throw _privateConstructorUsedError;
  String? get fecha => throw _privateConstructorUsedError;
  int? get pasejesEmitidos => throw _privateConstructorUsedError;
  int? get reimpresiones => throw _privateConstructorUsedError;
  List<TotalesPorMetodo>? get totalesPorMetodo =>
      throw _privateConstructorUsedError;
  int? get totales => throw _privateConstructorUsedError;
  List<Tramo>? get tramos => throw _privateConstructorUsedError;

  /// Serializes this Report2 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Report2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Report2CopyWith<Report2> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Report2CopyWith<$Res> {
  factory $Report2CopyWith(Report2 value, $Res Function(Report2) then) =
      _$Report2CopyWithImpl<$Res, Report2>;
  @useResult
  $Res call(
      {String? nombre,
      String? fecha,
      int? pasejesEmitidos,
      int? reimpresiones,
      List<TotalesPorMetodo>? totalesPorMetodo,
      int? totales,
      List<Tramo>? tramos});
}

/// @nodoc
class _$Report2CopyWithImpl<$Res, $Val extends Report2>
    implements $Report2CopyWith<$Res> {
  _$Report2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Report2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? fecha = freezed,
    Object? pasejesEmitidos = freezed,
    Object? reimpresiones = freezed,
    Object? totalesPorMetodo = freezed,
    Object? totales = freezed,
    Object? tramos = freezed,
  }) {
    return _then(_value.copyWith(
      nombre: freezed == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      fecha: freezed == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String?,
      pasejesEmitidos: freezed == pasejesEmitidos
          ? _value.pasejesEmitidos
          : pasejesEmitidos // ignore: cast_nullable_to_non_nullable
              as int?,
      reimpresiones: freezed == reimpresiones
          ? _value.reimpresiones
          : reimpresiones // ignore: cast_nullable_to_non_nullable
              as int?,
      totalesPorMetodo: freezed == totalesPorMetodo
          ? _value.totalesPorMetodo
          : totalesPorMetodo // ignore: cast_nullable_to_non_nullable
              as List<TotalesPorMetodo>?,
      totales: freezed == totales
          ? _value.totales
          : totales // ignore: cast_nullable_to_non_nullable
              as int?,
      tramos: freezed == tramos
          ? _value.tramos
          : tramos // ignore: cast_nullable_to_non_nullable
              as List<Tramo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Report2ImplCopyWith<$Res> implements $Report2CopyWith<$Res> {
  factory _$$Report2ImplCopyWith(
          _$Report2Impl value, $Res Function(_$Report2Impl) then) =
      __$$Report2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nombre,
      String? fecha,
      int? pasejesEmitidos,
      int? reimpresiones,
      List<TotalesPorMetodo>? totalesPorMetodo,
      int? totales,
      List<Tramo>? tramos});
}

/// @nodoc
class __$$Report2ImplCopyWithImpl<$Res>
    extends _$Report2CopyWithImpl<$Res, _$Report2Impl>
    implements _$$Report2ImplCopyWith<$Res> {
  __$$Report2ImplCopyWithImpl(
      _$Report2Impl _value, $Res Function(_$Report2Impl) _then)
      : super(_value, _then);

  /// Create a copy of Report2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? fecha = freezed,
    Object? pasejesEmitidos = freezed,
    Object? reimpresiones = freezed,
    Object? totalesPorMetodo = freezed,
    Object? totales = freezed,
    Object? tramos = freezed,
  }) {
    return _then(_$Report2Impl(
      nombre: freezed == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      fecha: freezed == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String?,
      pasejesEmitidos: freezed == pasejesEmitidos
          ? _value.pasejesEmitidos
          : pasejesEmitidos // ignore: cast_nullable_to_non_nullable
              as int?,
      reimpresiones: freezed == reimpresiones
          ? _value.reimpresiones
          : reimpresiones // ignore: cast_nullable_to_non_nullable
              as int?,
      totalesPorMetodo: freezed == totalesPorMetodo
          ? _value._totalesPorMetodo
          : totalesPorMetodo // ignore: cast_nullable_to_non_nullable
              as List<TotalesPorMetodo>?,
      totales: freezed == totales
          ? _value.totales
          : totales // ignore: cast_nullable_to_non_nullable
              as int?,
      tramos: freezed == tramos
          ? _value._tramos
          : tramos // ignore: cast_nullable_to_non_nullable
              as List<Tramo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Report2Impl implements _Report2 {
  const _$Report2Impl(
      {this.nombre,
      this.fecha,
      this.pasejesEmitidos,
      this.reimpresiones,
      final List<TotalesPorMetodo>? totalesPorMetodo,
      this.totales,
      final List<Tramo>? tramos})
      : _totalesPorMetodo = totalesPorMetodo,
        _tramos = tramos;

  factory _$Report2Impl.fromJson(Map<String, dynamic> json) =>
      _$$Report2ImplFromJson(json);

  @override
  final String? nombre;
  @override
  final String? fecha;
  @override
  final int? pasejesEmitidos;
  @override
  final int? reimpresiones;
  final List<TotalesPorMetodo>? _totalesPorMetodo;
  @override
  List<TotalesPorMetodo>? get totalesPorMetodo {
    final value = _totalesPorMetodo;
    if (value == null) return null;
    if (_totalesPorMetodo is EqualUnmodifiableListView)
      return _totalesPorMetodo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totales;
  final List<Tramo>? _tramos;
  @override
  List<Tramo>? get tramos {
    final value = _tramos;
    if (value == null) return null;
    if (_tramos is EqualUnmodifiableListView) return _tramos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Report2(nombre: $nombre, fecha: $fecha, pasejesEmitidos: $pasejesEmitidos, reimpresiones: $reimpresiones, totalesPorMetodo: $totalesPorMetodo, totales: $totales, tramos: $tramos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Report2Impl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.pasejesEmitidos, pasejesEmitidos) ||
                other.pasejesEmitidos == pasejesEmitidos) &&
            (identical(other.reimpresiones, reimpresiones) ||
                other.reimpresiones == reimpresiones) &&
            const DeepCollectionEquality()
                .equals(other._totalesPorMetodo, _totalesPorMetodo) &&
            (identical(other.totales, totales) || other.totales == totales) &&
            const DeepCollectionEquality().equals(other._tramos, _tramos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nombre,
      fecha,
      pasejesEmitidos,
      reimpresiones,
      const DeepCollectionEquality().hash(_totalesPorMetodo),
      totales,
      const DeepCollectionEquality().hash(_tramos));

  /// Create a copy of Report2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Report2ImplCopyWith<_$Report2Impl> get copyWith =>
      __$$Report2ImplCopyWithImpl<_$Report2Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Report2ImplToJson(
      this,
    );
  }
}

abstract class _Report2 implements Report2 {
  const factory _Report2(
      {final String? nombre,
      final String? fecha,
      final int? pasejesEmitidos,
      final int? reimpresiones,
      final List<TotalesPorMetodo>? totalesPorMetodo,
      final int? totales,
      final List<Tramo>? tramos}) = _$Report2Impl;

  factory _Report2.fromJson(Map<String, dynamic> json) = _$Report2Impl.fromJson;

  @override
  String? get nombre;
  @override
  String? get fecha;
  @override
  int? get pasejesEmitidos;
  @override
  int? get reimpresiones;
  @override
  List<TotalesPorMetodo>? get totalesPorMetodo;
  @override
  int? get totales;
  @override
  List<Tramo>? get tramos;

  /// Create a copy of Report2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Report2ImplCopyWith<_$Report2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

TotalesPorMetodo _$TotalesPorMetodoFromJson(Map<String, dynamic> json) {
  return _TotalesPorMetodo.fromJson(json);
}

/// @nodoc
mixin _$TotalesPorMetodo {
  String? get metodo => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  int? get cantidad => throw _privateConstructorUsedError;

  /// Serializes this TotalesPorMetodo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TotalesPorMetodo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TotalesPorMetodoCopyWith<TotalesPorMetodo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalesPorMetodoCopyWith<$Res> {
  factory $TotalesPorMetodoCopyWith(
          TotalesPorMetodo value, $Res Function(TotalesPorMetodo) then) =
      _$TotalesPorMetodoCopyWithImpl<$Res, TotalesPorMetodo>;
  @useResult
  $Res call({String? metodo, int? total, int? cantidad});
}

/// @nodoc
class _$TotalesPorMetodoCopyWithImpl<$Res, $Val extends TotalesPorMetodo>
    implements $TotalesPorMetodoCopyWith<$Res> {
  _$TotalesPorMetodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TotalesPorMetodo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metodo = freezed,
    Object? total = freezed,
    Object? cantidad = freezed,
  }) {
    return _then(_value.copyWith(
      metodo: freezed == metodo
          ? _value.metodo
          : metodo // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      cantidad: freezed == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TotalesPorMetodoImplCopyWith<$Res>
    implements $TotalesPorMetodoCopyWith<$Res> {
  factory _$$TotalesPorMetodoImplCopyWith(_$TotalesPorMetodoImpl value,
          $Res Function(_$TotalesPorMetodoImpl) then) =
      __$$TotalesPorMetodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? metodo, int? total, int? cantidad});
}

/// @nodoc
class __$$TotalesPorMetodoImplCopyWithImpl<$Res>
    extends _$TotalesPorMetodoCopyWithImpl<$Res, _$TotalesPorMetodoImpl>
    implements _$$TotalesPorMetodoImplCopyWith<$Res> {
  __$$TotalesPorMetodoImplCopyWithImpl(_$TotalesPorMetodoImpl _value,
      $Res Function(_$TotalesPorMetodoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TotalesPorMetodo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metodo = freezed,
    Object? total = freezed,
    Object? cantidad = freezed,
  }) {
    return _then(_$TotalesPorMetodoImpl(
      metodo: freezed == metodo
          ? _value.metodo
          : metodo // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      cantidad: freezed == cantidad
          ? _value.cantidad
          : cantidad // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TotalesPorMetodoImpl implements _TotalesPorMetodo {
  const _$TotalesPorMetodoImpl({this.metodo, this.total, this.cantidad});

  factory _$TotalesPorMetodoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TotalesPorMetodoImplFromJson(json);

  @override
  final String? metodo;
  @override
  final int? total;
  @override
  final int? cantidad;

  @override
  String toString() {
    return 'TotalesPorMetodo(metodo: $metodo, total: $total, cantidad: $cantidad)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TotalesPorMetodoImpl &&
            (identical(other.metodo, metodo) || other.metodo == metodo) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.cantidad, cantidad) ||
                other.cantidad == cantidad));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, metodo, total, cantidad);

  /// Create a copy of TotalesPorMetodo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TotalesPorMetodoImplCopyWith<_$TotalesPorMetodoImpl> get copyWith =>
      __$$TotalesPorMetodoImplCopyWithImpl<_$TotalesPorMetodoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TotalesPorMetodoImplToJson(
      this,
    );
  }
}

abstract class _TotalesPorMetodo implements TotalesPorMetodo {
  const factory _TotalesPorMetodo(
      {final String? metodo,
      final int? total,
      final int? cantidad}) = _$TotalesPorMetodoImpl;

  factory _TotalesPorMetodo.fromJson(Map<String, dynamic> json) =
      _$TotalesPorMetodoImpl.fromJson;

  @override
  String? get metodo;
  @override
  int? get total;
  @override
  int? get cantidad;

  /// Create a copy of TotalesPorMetodo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TotalesPorMetodoImplCopyWith<_$TotalesPorMetodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tramo _$TramoFromJson(Map<String, dynamic> json) {
  return _Tramo.fromJson(json);
}

/// @nodoc
mixin _$Tramo {
  String? get nombre => throw _privateConstructorUsedError;
  int? get totalPasajes => throw _privateConstructorUsedError;
  int? get totalTramo => throw _privateConstructorUsedError;
  List<TotalesPorMetodo>? get totalesPorMetodo =>
      throw _privateConstructorUsedError;

  /// Serializes this Tramo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tramo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TramoCopyWith<Tramo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TramoCopyWith<$Res> {
  factory $TramoCopyWith(Tramo value, $Res Function(Tramo) then) =
      _$TramoCopyWithImpl<$Res, Tramo>;
  @useResult
  $Res call(
      {String? nombre,
      int? totalPasajes,
      int? totalTramo,
      List<TotalesPorMetodo>? totalesPorMetodo});
}

/// @nodoc
class _$TramoCopyWithImpl<$Res, $Val extends Tramo>
    implements $TramoCopyWith<$Res> {
  _$TramoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tramo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? totalPasajes = freezed,
    Object? totalTramo = freezed,
    Object? totalesPorMetodo = freezed,
  }) {
    return _then(_value.copyWith(
      nombre: freezed == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPasajes: freezed == totalPasajes
          ? _value.totalPasajes
          : totalPasajes // ignore: cast_nullable_to_non_nullable
              as int?,
      totalTramo: freezed == totalTramo
          ? _value.totalTramo
          : totalTramo // ignore: cast_nullable_to_non_nullable
              as int?,
      totalesPorMetodo: freezed == totalesPorMetodo
          ? _value.totalesPorMetodo
          : totalesPorMetodo // ignore: cast_nullable_to_non_nullable
              as List<TotalesPorMetodo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TramoImplCopyWith<$Res> implements $TramoCopyWith<$Res> {
  factory _$$TramoImplCopyWith(
          _$TramoImpl value, $Res Function(_$TramoImpl) then) =
      __$$TramoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nombre,
      int? totalPasajes,
      int? totalTramo,
      List<TotalesPorMetodo>? totalesPorMetodo});
}

/// @nodoc
class __$$TramoImplCopyWithImpl<$Res>
    extends _$TramoCopyWithImpl<$Res, _$TramoImpl>
    implements _$$TramoImplCopyWith<$Res> {
  __$$TramoImplCopyWithImpl(
      _$TramoImpl _value, $Res Function(_$TramoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tramo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? totalPasajes = freezed,
    Object? totalTramo = freezed,
    Object? totalesPorMetodo = freezed,
  }) {
    return _then(_$TramoImpl(
      nombre: freezed == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPasajes: freezed == totalPasajes
          ? _value.totalPasajes
          : totalPasajes // ignore: cast_nullable_to_non_nullable
              as int?,
      totalTramo: freezed == totalTramo
          ? _value.totalTramo
          : totalTramo // ignore: cast_nullable_to_non_nullable
              as int?,
      totalesPorMetodo: freezed == totalesPorMetodo
          ? _value._totalesPorMetodo
          : totalesPorMetodo // ignore: cast_nullable_to_non_nullable
              as List<TotalesPorMetodo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TramoImpl implements _Tramo {
  const _$TramoImpl(
      {this.nombre,
      this.totalPasajes,
      this.totalTramo,
      final List<TotalesPorMetodo>? totalesPorMetodo})
      : _totalesPorMetodo = totalesPorMetodo;

  factory _$TramoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TramoImplFromJson(json);

  @override
  final String? nombre;
  @override
  final int? totalPasajes;
  @override
  final int? totalTramo;
  final List<TotalesPorMetodo>? _totalesPorMetodo;
  @override
  List<TotalesPorMetodo>? get totalesPorMetodo {
    final value = _totalesPorMetodo;
    if (value == null) return null;
    if (_totalesPorMetodo is EqualUnmodifiableListView)
      return _totalesPorMetodo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Tramo(nombre: $nombre, totalPasajes: $totalPasajes, totalTramo: $totalTramo, totalesPorMetodo: $totalesPorMetodo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TramoImpl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.totalPasajes, totalPasajes) ||
                other.totalPasajes == totalPasajes) &&
            (identical(other.totalTramo, totalTramo) ||
                other.totalTramo == totalTramo) &&
            const DeepCollectionEquality()
                .equals(other._totalesPorMetodo, _totalesPorMetodo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nombre, totalPasajes, totalTramo,
      const DeepCollectionEquality().hash(_totalesPorMetodo));

  /// Create a copy of Tramo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TramoImplCopyWith<_$TramoImpl> get copyWith =>
      __$$TramoImplCopyWithImpl<_$TramoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TramoImplToJson(
      this,
    );
  }
}

abstract class _Tramo implements Tramo {
  const factory _Tramo(
      {final String? nombre,
      final int? totalPasajes,
      final int? totalTramo,
      final List<TotalesPorMetodo>? totalesPorMetodo}) = _$TramoImpl;

  factory _Tramo.fromJson(Map<String, dynamic> json) = _$TramoImpl.fromJson;

  @override
  String? get nombre;
  @override
  int? get totalPasajes;
  @override
  int? get totalTramo;
  @override
  List<TotalesPorMetodo>? get totalesPorMetodo;

  /// Create a copy of Tramo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TramoImplCopyWith<_$TramoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
