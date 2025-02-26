// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report1_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Report1 _$Report1FromJson(Map<String, dynamic> json) {
  return _Report1.fromJson(json);
}

/// @nodoc
mixin _$Report1 {
  String? get nombre => throw _privateConstructorUsedError;
  String? get fecha => throw _privateConstructorUsedError;
  int? get pasajesEmitidos => throw _privateConstructorUsedError;
  int? get reimpresiones => throw _privateConstructorUsedError;
  List<TotalesPorMetodo>? get totalesPorMetodo =>
      throw _privateConstructorUsedError;
  int? get totales => throw _privateConstructorUsedError;

  /// Serializes this Report1 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Report1
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Report1CopyWith<Report1> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Report1CopyWith<$Res> {
  factory $Report1CopyWith(Report1 value, $Res Function(Report1) then) =
      _$Report1CopyWithImpl<$Res, Report1>;
  @useResult
  $Res call(
      {String? nombre,
      String? fecha,
      int? pasajesEmitidos,
      int? reimpresiones,
      List<TotalesPorMetodo>? totalesPorMetodo,
      int? totales});
}

/// @nodoc
class _$Report1CopyWithImpl<$Res, $Val extends Report1>
    implements $Report1CopyWith<$Res> {
  _$Report1CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Report1
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? fecha = freezed,
    Object? pasajesEmitidos = freezed,
    Object? reimpresiones = freezed,
    Object? totalesPorMetodo = freezed,
    Object? totales = freezed,
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
      pasajesEmitidos: freezed == pasajesEmitidos
          ? _value.pasajesEmitidos
          : pasajesEmitidos // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Report1ImplCopyWith<$Res> implements $Report1CopyWith<$Res> {
  factory _$$Report1ImplCopyWith(
          _$Report1Impl value, $Res Function(_$Report1Impl) then) =
      __$$Report1ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nombre,
      String? fecha,
      int? pasajesEmitidos,
      int? reimpresiones,
      List<TotalesPorMetodo>? totalesPorMetodo,
      int? totales});
}

/// @nodoc
class __$$Report1ImplCopyWithImpl<$Res>
    extends _$Report1CopyWithImpl<$Res, _$Report1Impl>
    implements _$$Report1ImplCopyWith<$Res> {
  __$$Report1ImplCopyWithImpl(
      _$Report1Impl _value, $Res Function(_$Report1Impl) _then)
      : super(_value, _then);

  /// Create a copy of Report1
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = freezed,
    Object? fecha = freezed,
    Object? pasajesEmitidos = freezed,
    Object? reimpresiones = freezed,
    Object? totalesPorMetodo = freezed,
    Object? totales = freezed,
  }) {
    return _then(_$Report1Impl(
      nombre: freezed == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      fecha: freezed == fecha
          ? _value.fecha
          : fecha // ignore: cast_nullable_to_non_nullable
              as String?,
      pasajesEmitidos: freezed == pasajesEmitidos
          ? _value.pasajesEmitidos
          : pasajesEmitidos // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Report1Impl implements _Report1 {
  const _$Report1Impl(
      {this.nombre,
      this.fecha,
      this.pasajesEmitidos,
      this.reimpresiones,
      final List<TotalesPorMetodo>? totalesPorMetodo,
      this.totales})
      : _totalesPorMetodo = totalesPorMetodo;

  factory _$Report1Impl.fromJson(Map<String, dynamic> json) =>
      _$$Report1ImplFromJson(json);

  @override
  final String? nombre;
  @override
  final String? fecha;
  @override
  final int? pasajesEmitidos;
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

  @override
  String toString() {
    return 'Report1(nombre: $nombre, fecha: $fecha, pasajesEmitidos: $pasajesEmitidos, reimpresiones: $reimpresiones, totalesPorMetodo: $totalesPorMetodo, totales: $totales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Report1Impl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.fecha, fecha) || other.fecha == fecha) &&
            (identical(other.pasajesEmitidos, pasajesEmitidos) ||
                other.pasajesEmitidos == pasajesEmitidos) &&
            (identical(other.reimpresiones, reimpresiones) ||
                other.reimpresiones == reimpresiones) &&
            const DeepCollectionEquality()
                .equals(other._totalesPorMetodo, _totalesPorMetodo) &&
            (identical(other.totales, totales) || other.totales == totales));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      nombre,
      fecha,
      pasajesEmitidos,
      reimpresiones,
      const DeepCollectionEquality().hash(_totalesPorMetodo),
      totales);

  /// Create a copy of Report1
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Report1ImplCopyWith<_$Report1Impl> get copyWith =>
      __$$Report1ImplCopyWithImpl<_$Report1Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Report1ImplToJson(
      this,
    );
  }
}

abstract class _Report1 implements Report1 {
  const factory _Report1(
      {final String? nombre,
      final String? fecha,
      final int? pasajesEmitidos,
      final int? reimpresiones,
      final List<TotalesPorMetodo>? totalesPorMetodo,
      final int? totales}) = _$Report1Impl;

  factory _Report1.fromJson(Map<String, dynamic> json) = _$Report1Impl.fromJson;

  @override
  String? get nombre;
  @override
  String? get fecha;
  @override
  int? get pasajesEmitidos;
  @override
  int? get reimpresiones;
  @override
  List<TotalesPorMetodo>? get totalesPorMetodo;
  @override
  int? get totales;

  /// Create a copy of Report1
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Report1ImplCopyWith<_$Report1Impl> get copyWith =>
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
