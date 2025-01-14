// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trips_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Trips _$TripsFromJson(Map<String, dynamic> json) {
  return _Trips.fromJson(json);
}

/// @nodoc
mixin _$Trips {
  List<Trip>? get trips => throw _privateConstructorUsedError;

  /// Serializes this Trips to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trips
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripsCopyWith<Trips> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripsCopyWith<$Res> {
  factory $TripsCopyWith(Trips value, $Res Function(Trips) then) =
      _$TripsCopyWithImpl<$Res, Trips>;
  @useResult
  $Res call({List<Trip>? trips});
}

/// @nodoc
class _$TripsCopyWithImpl<$Res, $Val extends Trips>
    implements $TripsCopyWith<$Res> {
  _$TripsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trips
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trips = freezed,
  }) {
    return _then(_value.copyWith(
      trips: freezed == trips
          ? _value.trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<Trip>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripsImplCopyWith<$Res> implements $TripsCopyWith<$Res> {
  factory _$$TripsImplCopyWith(
          _$TripsImpl value, $Res Function(_$TripsImpl) then) =
      __$$TripsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Trip>? trips});
}

/// @nodoc
class __$$TripsImplCopyWithImpl<$Res>
    extends _$TripsCopyWithImpl<$Res, _$TripsImpl>
    implements _$$TripsImplCopyWith<$Res> {
  __$$TripsImplCopyWithImpl(
      _$TripsImpl _value, $Res Function(_$TripsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Trips
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trips = freezed,
  }) {
    return _then(_$TripsImpl(
      trips: freezed == trips
          ? _value._trips
          : trips // ignore: cast_nullable_to_non_nullable
              as List<Trip>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripsImpl implements _Trips {
  const _$TripsImpl({final List<Trip>? trips}) : _trips = trips;

  factory _$TripsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripsImplFromJson(json);

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
    return 'Trips(trips: $trips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripsImpl &&
            const DeepCollectionEquality().equals(other._trips, _trips));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_trips));

  /// Create a copy of Trips
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripsImplCopyWith<_$TripsImpl> get copyWith =>
      __$$TripsImplCopyWithImpl<_$TripsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripsImplToJson(
      this,
    );
  }
}

abstract class _Trips implements Trips {
  const factory _Trips({final List<Trip>? trips}) = _$TripsImpl;

  factory _Trips.fromJson(Map<String, dynamic> json) = _$TripsImpl.fromJson;

  @override
  List<Trip>? get trips;

  /// Create a copy of Trips
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripsImplCopyWith<_$TripsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  int? get id => throw _privateConstructorUsedError;
  int? get tripId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get schedule => throw _privateConstructorUsedError;
  int? get seats => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get origin => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get originImage => throw _privateConstructorUsedError;
  String? get destination => throw _privateConstructorUsedError;
  String? get destinationImage => throw _privateConstructorUsedError;
  List<int>? get reservedSeats => throw _privateConstructorUsedError;

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
      int? tripId,
      DateTime? date,
      String? schedule,
      int? seats,
      String? name,
      String? origin,
      String? price,
      String? originImage,
      String? destination,
      String? destinationImage,
      List<int>? reservedSeats});
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
    Object? tripId = freezed,
    Object? date = freezed,
    Object? schedule = freezed,
    Object? seats = freezed,
    Object? name = freezed,
    Object? origin = freezed,
    Object? price = freezed,
    Object? originImage = freezed,
    Object? destination = freezed,
    Object? destinationImage = freezed,
    Object? reservedSeats = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
      seats: freezed == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      originImage: freezed == originImage
          ? _value.originImage
          : originImage // ignore: cast_nullable_to_non_nullable
              as String?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationImage: freezed == destinationImage
          ? _value.destinationImage
          : destinationImage // ignore: cast_nullable_to_non_nullable
              as String?,
      reservedSeats: freezed == reservedSeats
          ? _value.reservedSeats
          : reservedSeats // ignore: cast_nullable_to_non_nullable
              as List<int>?,
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
      int? tripId,
      DateTime? date,
      String? schedule,
      int? seats,
      String? name,
      String? origin,
      String? price,
      String? originImage,
      String? destination,
      String? destinationImage,
      List<int>? reservedSeats});
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
    Object? tripId = freezed,
    Object? date = freezed,
    Object? schedule = freezed,
    Object? seats = freezed,
    Object? name = freezed,
    Object? origin = freezed,
    Object? price = freezed,
    Object? originImage = freezed,
    Object? destination = freezed,
    Object? destinationImage = freezed,
    Object? reservedSeats = freezed,
  }) {
    return _then(_$TripImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
      seats: freezed == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      origin: freezed == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      originImage: freezed == originImage
          ? _value.originImage
          : originImage // ignore: cast_nullable_to_non_nullable
              as String?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationImage: freezed == destinationImage
          ? _value.destinationImage
          : destinationImage // ignore: cast_nullable_to_non_nullable
              as String?,
      reservedSeats: freezed == reservedSeats
          ? _value._reservedSeats
          : reservedSeats // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl(
      {this.id,
      this.tripId,
      this.date,
      this.schedule,
      this.seats,
      this.name,
      this.origin,
      this.price,
      this.originImage,
      this.destination,
      this.destinationImage,
      final List<int>? reservedSeats})
      : _reservedSeats = reservedSeats;

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  final int? id;
  @override
  final int? tripId;
  @override
  final DateTime? date;
  @override
  final String? schedule;
  @override
  final int? seats;
  @override
  final String? name;
  @override
  final String? origin;
  @override
  final String? price;
  @override
  final String? originImage;
  @override
  final String? destination;
  @override
  final String? destinationImage;
  final List<int>? _reservedSeats;
  @override
  List<int>? get reservedSeats {
    final value = _reservedSeats;
    if (value == null) return null;
    if (_reservedSeats is EqualUnmodifiableListView) return _reservedSeats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Trip(id: $id, tripId: $tripId, date: $date, schedule: $schedule, seats: $seats, name: $name, origin: $origin, price: $price, originImage: $originImage, destination: $destination, destinationImage: $destinationImage, reservedSeats: $reservedSeats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.seats, seats) || other.seats == seats) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.originImage, originImage) ||
                other.originImage == originImage) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.destinationImage, destinationImage) ||
                other.destinationImage == destinationImage) &&
            const DeepCollectionEquality()
                .equals(other._reservedSeats, _reservedSeats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tripId,
      date,
      schedule,
      seats,
      name,
      origin,
      price,
      originImage,
      destination,
      destinationImage,
      const DeepCollectionEquality().hash(_reservedSeats));

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
      final int? tripId,
      final DateTime? date,
      final String? schedule,
      final int? seats,
      final String? name,
      final String? origin,
      final String? price,
      final String? originImage,
      final String? destination,
      final String? destinationImage,
      final List<int>? reservedSeats}) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  int? get id;
  @override
  int? get tripId;
  @override
  DateTime? get date;
  @override
  String? get schedule;
  @override
  int? get seats;
  @override
  String? get name;
  @override
  String? get origin;
  @override
  String? get price;
  @override
  String? get originImage;
  @override
  String? get destination;
  @override
  String? get destinationImage;
  @override
  List<int>? get reservedSeats;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
