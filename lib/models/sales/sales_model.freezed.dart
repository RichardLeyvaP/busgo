// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sales _$SalesFromJson(Map<String, dynamic> json) {
  return _Sales.fromJson(json);
}

/// @nodoc
mixin _$Sales {
  List<Sale>? get sales => throw _privateConstructorUsedError;
  List<int>? get salesYear => throw _privateConstructorUsedError;
  List<Trip>? get trips => throw _privateConstructorUsedError;

  /// Serializes this Sales to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sales
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesCopyWith<Sales> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesCopyWith<$Res> {
  factory $SalesCopyWith(Sales value, $Res Function(Sales) then) =
      _$SalesCopyWithImpl<$Res, Sales>;
  @useResult
  $Res call({List<Sale>? sales, List<int>? salesYear, List<Trip>? trips});
}

/// @nodoc
class _$SalesCopyWithImpl<$Res, $Val extends Sales>
    implements $SalesCopyWith<$Res> {
  _$SalesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sales
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales = freezed,
    Object? salesYear = freezed,
    Object? trips = freezed,
  }) {
    return _then(_value.copyWith(
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
      salesYear: freezed == salesYear
          ? _value.salesYear
          : salesYear // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      trips: freezed == trips
          ? _value.trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<Trip>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesImplCopyWith<$Res> implements $SalesCopyWith<$Res> {
  factory _$$SalesImplCopyWith(
          _$SalesImpl value, $Res Function(_$SalesImpl) then) =
      __$$SalesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Sale>? sales, List<int>? salesYear, List<Trip>? trips});
}

/// @nodoc
class __$$SalesImplCopyWithImpl<$Res>
    extends _$SalesCopyWithImpl<$Res, _$SalesImpl>
    implements _$$SalesImplCopyWith<$Res> {
  __$$SalesImplCopyWithImpl(
      _$SalesImpl _value, $Res Function(_$SalesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sales
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales = freezed,
    Object? salesYear = freezed,
    Object? trips = freezed,
  }) {
    return _then(_$SalesImpl(
      sales: freezed == sales
          ? _value._sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
      salesYear: freezed == salesYear
          ? _value._salesYear
          : salesYear // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      trips: freezed == trips
          ? _value._trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<Trip>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesImpl implements _Sales {
  const _$SalesImpl(
      {final List<Sale>? sales,
      final List<int>? salesYear,
      final List<Trip>? trips})
      : _sales = sales,
        _salesYear = salesYear,
        _trips = trips;

  factory _$SalesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesImplFromJson(json);

  final List<Sale>? _sales;
  @override
  List<Sale>? get sales {
    final value = _sales;
    if (value == null) return null;
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<int>? _salesYear;
  @override
  List<int>? get salesYear {
    final value = _salesYear;
    if (value == null) return null;
    if (_salesYear is EqualUnmodifiableListView) return _salesYear;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Trip>? _trips;
  @override
  List<Trip>? get trips {
    final value = _trips;
    if (value == null) return null;
    if (_trips is EqualUnmodifiableListView) return _trips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Sales(sales: $sales, salesYear: $salesYear, trips: $trips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesImpl &&
            const DeepCollectionEquality().equals(other._sales, _sales) &&
            const DeepCollectionEquality()
                .equals(other._salesYear, _salesYear) &&
            const DeepCollectionEquality().equals(other._trips, _trips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sales),
      const DeepCollectionEquality().hash(_salesYear),
      const DeepCollectionEquality().hash(_trips));

  /// Create a copy of Sales
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesImplCopyWith<_$SalesImpl> get copyWith =>
      __$$SalesImplCopyWithImpl<_$SalesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesImplToJson(
      this,
    );
  }
}

abstract class _Sales implements Sales {
  const factory _Sales(
      {final List<Sale>? sales,
      final List<int>? salesYear,
      final List<Trip>? trips}) = _$SalesImpl;

  factory _Sales.fromJson(Map<String, dynamic> json) = _$SalesImpl.fromJson;

  @override
  List<Sale>? get sales;
  @override
  List<int>? get salesYear;
  @override
  List<Trip>? get trips;

  /// Create a copy of Sales
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesImplCopyWith<_$SalesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  String? get title => throw _privateConstructorUsedError;
  double? get value => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call({String? title, double? value, String? color, String? icon});
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? value = freezed,
    Object? color = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
          _$SaleImpl value, $Res Function(_$SaleImpl) then) =
      __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, double? value, String? color, String? icon});
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? value = freezed,
    Object? color = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$SaleImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl({this.title, this.value, this.color, this.icon});

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  final String? title;
  @override
  final double? value;
  @override
  final String? color;
  @override
  final String? icon;

  @override
  String toString() {
    return 'Sale(title: $title, value: $value, color: $color, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, value, color, icon);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(
      this,
    );
  }
}

abstract class _Sale implements Sale {
  const factory _Sale(
      {final String? title,
      final double? value,
      final String? color,
      final String? icon}) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  String? get title;
  @override
  double? get value;
  @override
  String? get color;
  @override
  String? get icon;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  int? get id => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get vehicleImage => throw _privateConstructorUsedError;
  String? get vehiclePlate => throw _privateConstructorUsedError;
  String? get route => throw _privateConstructorUsedError;
  String? get horario => throw _privateConstructorUsedError;
  int? get capacidad => throw _privateConstructorUsedError;
  int? get asientosVendidos => throw _privateConstructorUsedError;
  int? get dineroGenerado => throw _privateConstructorUsedError;

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call(
      {int? id,
      DateTime? date,
      String? vehicleImage,
      String? vehiclePlate,
      String? route,
      String? horario,
      int? capacidad,
      int? asientosVendidos,
      int? dineroGenerado});
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? vehicleImage = freezed,
    Object? vehiclePlate = freezed,
    Object? route = freezed,
    Object? horario = freezed,
    Object? capacidad = freezed,
    Object? asientosVendidos = freezed,
    Object? dineroGenerado = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      vehicleImage: freezed == vehicleImage
          ? _value.vehicleImage
          : vehicleImage // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      horario: freezed == horario
          ? _value.horario
          : horario // ignore: cast_nullable_to_non_nullable
              as String?,
      capacidad: freezed == capacidad
          ? _value.capacidad
          : capacidad // ignore: cast_nullable_to_non_nullable
              as int?,
      asientosVendidos: freezed == asientosVendidos
          ? _value.asientosVendidos
          : asientosVendidos // ignore: cast_nullable_to_non_nullable
              as int?,
      dineroGenerado: freezed == dineroGenerado
          ? _value.dineroGenerado
          : dineroGenerado // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
          _$TripImpl value, $Res Function(_$TripImpl) then) =
      __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime? date,
      String? vehicleImage,
      String? vehiclePlate,
      String? route,
      String? horario,
      int? capacidad,
      int? asientosVendidos,
      int? dineroGenerado});
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
      : super(_value, _then);

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? vehicleImage = freezed,
    Object? vehiclePlate = freezed,
    Object? route = freezed,
    Object? horario = freezed,
    Object? capacidad = freezed,
    Object? asientosVendidos = freezed,
    Object? dineroGenerado = freezed,
  }) {
    return _then(_$TripImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      vehicleImage: freezed == vehicleImage
          ? _value.vehicleImage
          : vehicleImage // ignore: cast_nullable_to_non_nullable
              as String?,
      vehiclePlate: freezed == vehiclePlate
          ? _value.vehiclePlate
          : vehiclePlate // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      horario: freezed == horario
          ? _value.horario
          : horario // ignore: cast_nullable_to_non_nullable
              as String?,
      capacidad: freezed == capacidad
          ? _value.capacidad
          : capacidad // ignore: cast_nullable_to_non_nullable
              as int?,
      asientosVendidos: freezed == asientosVendidos
          ? _value.asientosVendidos
          : asientosVendidos // ignore: cast_nullable_to_non_nullable
              as int?,
      dineroGenerado: freezed == dineroGenerado
          ? _value.dineroGenerado
          : dineroGenerado // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl(
      {this.id,
      this.date,
      this.vehicleImage,
      this.vehiclePlate,
      this.route,
      this.horario,
      this.capacidad,
      this.asientosVendidos,
      this.dineroGenerado});

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime? date;
  @override
  final String? vehicleImage;
  @override
  final String? vehiclePlate;
  @override
  final String? route;
  @override
  final String? horario;
  @override
  final int? capacidad;
  @override
  final int? asientosVendidos;
  @override
  final int? dineroGenerado;

  @override
  String toString() {
    return 'Trip(id: $id, date: $date, vehicleImage: $vehicleImage, vehiclePlate: $vehiclePlate, route: $route, horario: $horario, capacidad: $capacidad, asientosVendidos: $asientosVendidos, dineroGenerado: $dineroGenerado)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.vehicleImage, vehicleImage) ||
                other.vehicleImage == vehicleImage) &&
            (identical(other.vehiclePlate, vehiclePlate) ||
                other.vehiclePlate == vehiclePlate) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.horario, horario) || other.horario == horario) &&
            (identical(other.capacidad, capacidad) ||
                other.capacidad == capacidad) &&
            (identical(other.asientosVendidos, asientosVendidos) ||
                other.asientosVendidos == asientosVendidos) &&
            (identical(other.dineroGenerado, dineroGenerado) ||
                other.dineroGenerado == dineroGenerado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      vehicleImage,
      vehiclePlate,
      route,
      horario,
      capacidad,
      asientosVendidos,
      dineroGenerado);

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(
      this,
    );
  }
}

abstract class _Trip implements Trip {
  const factory _Trip(
      {final int? id,
      final DateTime? date,
      final String? vehicleImage,
      final String? vehiclePlate,
      final String? route,
      final String? horario,
      final int? capacidad,
      final int? asientosVendidos,
      final int? dineroGenerado}) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime? get date;
  @override
  String? get vehicleImage;
  @override
  String? get vehiclePlate;
  @override
  String? get route;
  @override
  String? get horario;
  @override
  int? get capacidad;
  @override
  int? get asientosVendidos;
  @override
  int? get dineroGenerado;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
