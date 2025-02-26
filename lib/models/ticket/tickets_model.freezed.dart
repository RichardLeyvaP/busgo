// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tickets_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tickets _$TicketsFromJson(Map<String, dynamic> json) {
  return _Tickets.fromJson(json);
}

/// @nodoc
mixin _$Tickets {
  List<Ticket>? get tickets => throw _privateConstructorUsedError;

  /// Serializes this Tickets to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tickets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketsCopyWith<Tickets> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketsCopyWith<$Res> {
  factory $TicketsCopyWith(Tickets value, $Res Function(Tickets) then) =
      _$TicketsCopyWithImpl<$Res, Tickets>;
  @useResult
  $Res call({List<Ticket>? tickets});
}

/// @nodoc
class _$TicketsCopyWithImpl<$Res, $Val extends Tickets>
    implements $TicketsCopyWith<$Res> {
  _$TicketsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tickets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
  }) {
    return _then(_value.copyWith(
      tickets: freezed == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<Ticket>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketsImplCopyWith<$Res> implements $TicketsCopyWith<$Res> {
  factory _$$TicketsImplCopyWith(
          _$TicketsImpl value, $Res Function(_$TicketsImpl) then) =
      __$$TicketsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Ticket>? tickets});
}

/// @nodoc
class __$$TicketsImplCopyWithImpl<$Res>
    extends _$TicketsCopyWithImpl<$Res, _$TicketsImpl>
    implements _$$TicketsImplCopyWith<$Res> {
  __$$TicketsImplCopyWithImpl(
      _$TicketsImpl _value, $Res Function(_$TicketsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tickets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tickets = freezed,
  }) {
    return _then(_$TicketsImpl(
      tickets: freezed == tickets
          ? _value._tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<Ticket>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketsImpl implements _Tickets {
  const _$TicketsImpl({final List<Ticket>? tickets}) : _tickets = tickets;

  factory _$TicketsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketsImplFromJson(json);

  final List<Ticket>? _tickets;
  @override
  List<Ticket>? get tickets {
    final value = _tickets;
    if (value == null) return null;
    if (_tickets is EqualUnmodifiableListView) return _tickets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Tickets(tickets: $tickets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketsImpl &&
            const DeepCollectionEquality().equals(other._tickets, _tickets));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tickets));

  /// Create a copy of Tickets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketsImplCopyWith<_$TicketsImpl> get copyWith =>
      __$$TicketsImplCopyWithImpl<_$TicketsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketsImplToJson(
      this,
    );
  }
}

abstract class _Tickets implements Tickets {
  const factory _Tickets({final List<Ticket>? tickets}) = _$TicketsImpl;

  factory _Tickets.fromJson(Map<String, dynamic> json) = _$TicketsImpl.fromJson;

  @override
  List<Ticket>? get tickets;

  /// Create a copy of Tickets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketsImplCopyWith<_$TicketsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  int? get id => throw _privateConstructorUsedError;
  int? get branchId => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;
  int? get tripId => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get total => throw _privateConstructorUsedError;
  List<int>? get seats => throw _privateConstructorUsedError;
  int? get adults => throw _privateConstructorUsedError;
  int? get minors => throw _privateConstructorUsedError;
  String? get qr => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get branchName => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get tripName => throw _privateConstructorUsedError;
  String? get originImage => throw _privateConstructorUsedError;
  String? get tripOrigin => throw _privateConstructorUsedError;
  String? get destinationImage => throw _privateConstructorUsedError;
  String? get tripDestination => throw _privateConstructorUsedError;
  String? get schedule => throw _privateConstructorUsedError;
  int? get print => throw _privateConstructorUsedError;

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call(
      {int? id,
      int? branchId,
      int? userId,
      int? tripId,
      String? method,
      int? status,
      int? quantity,
      String? price,
      String? total,
      List<int>? seats,
      int? adults,
      int? minors,
      String? qr,
      String? barcode,
      String? date,
      String? branchName,
      String? userName,
      String? tripName,
      String? originImage,
      String? tripOrigin,
      String? destinationImage,
      String? tripDestination,
      String? schedule,
      int? print});
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? branchId = freezed,
    Object? userId = freezed,
    Object? tripId = freezed,
    Object? method = freezed,
    Object? status = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? total = freezed,
    Object? seats = freezed,
    Object? adults = freezed,
    Object? minors = freezed,
    Object? qr = freezed,
    Object? barcode = freezed,
    Object? date = freezed,
    Object? branchName = freezed,
    Object? userName = freezed,
    Object? tripName = freezed,
    Object? originImage = freezed,
    Object? tripOrigin = freezed,
    Object? destinationImage = freezed,
    Object? tripDestination = freezed,
    Object? schedule = freezed,
    Object? print = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      seats: freezed == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      adults: freezed == adults
          ? _value.adults
          : adults // ignore: cast_nullable_to_non_nullable
              as int?,
      minors: freezed == minors
          ? _value.minors
          : minors // ignore: cast_nullable_to_non_nullable
              as int?,
      qr: freezed == qr
          ? _value.qr
          : qr // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      tripName: freezed == tripName
          ? _value.tripName
          : tripName // ignore: cast_nullable_to_non_nullable
              as String?,
      originImage: freezed == originImage
          ? _value.originImage
          : originImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tripOrigin: freezed == tripOrigin
          ? _value.tripOrigin
          : tripOrigin // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationImage: freezed == destinationImage
          ? _value.destinationImage
          : destinationImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tripDestination: freezed == tripDestination
          ? _value.tripDestination
          : tripDestination // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
      print: freezed == print
          ? _value.print
          : print // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketImplCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$TicketImplCopyWith(
          _$TicketImpl value, $Res Function(_$TicketImpl) then) =
      __$$TicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? branchId,
      int? userId,
      int? tripId,
      String? method,
      int? status,
      int? quantity,
      String? price,
      String? total,
      List<int>? seats,
      int? adults,
      int? minors,
      String? qr,
      String? barcode,
      String? date,
      String? branchName,
      String? userName,
      String? tripName,
      String? originImage,
      String? tripOrigin,
      String? destinationImage,
      String? tripDestination,
      String? schedule,
      int? print});
}

/// @nodoc
class __$$TicketImplCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$TicketImpl>
    implements _$$TicketImplCopyWith<$Res> {
  __$$TicketImplCopyWithImpl(
      _$TicketImpl _value, $Res Function(_$TicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? branchId = freezed,
    Object? userId = freezed,
    Object? tripId = freezed,
    Object? method = freezed,
    Object? status = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? total = freezed,
    Object? seats = freezed,
    Object? adults = freezed,
    Object? minors = freezed,
    Object? qr = freezed,
    Object? barcode = freezed,
    Object? date = freezed,
    Object? branchName = freezed,
    Object? userName = freezed,
    Object? tripName = freezed,
    Object? originImage = freezed,
    Object? tripOrigin = freezed,
    Object? destinationImage = freezed,
    Object? tripDestination = freezed,
    Object? schedule = freezed,
    Object? print = freezed,
  }) {
    return _then(_$TicketImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      tripId: freezed == tripId
          ? _value.tripId
          : tripId // ignore: cast_nullable_to_non_nullable
              as int?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      seats: freezed == seats
          ? _value._seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      adults: freezed == adults
          ? _value.adults
          : adults // ignore: cast_nullable_to_non_nullable
              as int?,
      minors: freezed == minors
          ? _value.minors
          : minors // ignore: cast_nullable_to_non_nullable
              as int?,
      qr: freezed == qr
          ? _value.qr
          : qr // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      tripName: freezed == tripName
          ? _value.tripName
          : tripName // ignore: cast_nullable_to_non_nullable
              as String?,
      originImage: freezed == originImage
          ? _value.originImage
          : originImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tripOrigin: freezed == tripOrigin
          ? _value.tripOrigin
          : tripOrigin // ignore: cast_nullable_to_non_nullable
              as String?,
      destinationImage: freezed == destinationImage
          ? _value.destinationImage
          : destinationImage // ignore: cast_nullable_to_non_nullable
              as String?,
      tripDestination: freezed == tripDestination
          ? _value.tripDestination
          : tripDestination // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
      print: freezed == print
          ? _value.print
          : print // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketImpl implements _Ticket {
  const _$TicketImpl(
      {this.id,
      this.branchId,
      this.userId,
      this.tripId,
      this.method,
      this.status,
      this.quantity,
      this.price,
      this.total,
      final List<int>? seats,
      this.adults,
      this.minors,
      this.qr,
      this.barcode,
      this.date,
      this.branchName,
      this.userName,
      this.tripName,
      this.originImage,
      this.tripOrigin,
      this.destinationImage,
      this.tripDestination,
      this.schedule,
      this.print})
      : _seats = seats;

  factory _$TicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketImplFromJson(json);

  @override
  final int? id;
  @override
  final int? branchId;
  @override
  final int? userId;
  @override
  final int? tripId;
  @override
  final String? method;
  @override
  final int? status;
  @override
  final int? quantity;
  @override
  final String? price;
  @override
  final String? total;
  final List<int>? _seats;
  @override
  List<int>? get seats {
    final value = _seats;
    if (value == null) return null;
    if (_seats is EqualUnmodifiableListView) return _seats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? adults;
  @override
  final int? minors;
  @override
  final String? qr;
  @override
  final String? barcode;
  @override
  final String? date;
  @override
  final String? branchName;
  @override
  final String? userName;
  @override
  final String? tripName;
  @override
  final String? originImage;
  @override
  final String? tripOrigin;
  @override
  final String? destinationImage;
  @override
  final String? tripDestination;
  @override
  final String? schedule;
  @override
  final int? print;

  @override
  String toString() {
    return 'Ticket(id: $id, branchId: $branchId, userId: $userId, tripId: $tripId, method: $method, status: $status, quantity: $quantity, price: $price, total: $total, seats: $seats, adults: $adults, minors: $minors, qr: $qr, barcode: $barcode, date: $date, branchName: $branchName, userName: $userName, tripName: $tripName, originImage: $originImage, tripOrigin: $tripOrigin, destinationImage: $destinationImage, tripDestination: $tripDestination, schedule: $schedule, print: $print)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._seats, _seats) &&
            (identical(other.adults, adults) || other.adults == adults) &&
            (identical(other.minors, minors) || other.minors == minors) &&
            (identical(other.qr, qr) || other.qr == qr) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.tripName, tripName) ||
                other.tripName == tripName) &&
            (identical(other.originImage, originImage) ||
                other.originImage == originImage) &&
            (identical(other.tripOrigin, tripOrigin) ||
                other.tripOrigin == tripOrigin) &&
            (identical(other.destinationImage, destinationImage) ||
                other.destinationImage == destinationImage) &&
            (identical(other.tripDestination, tripDestination) ||
                other.tripDestination == tripDestination) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.print, print) || other.print == print));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        branchId,
        userId,
        tripId,
        method,
        status,
        quantity,
        price,
        total,
        const DeepCollectionEquality().hash(_seats),
        adults,
        minors,
        qr,
        barcode,
        date,
        branchName,
        userName,
        tripName,
        originImage,
        tripOrigin,
        destinationImage,
        tripDestination,
        schedule,
        print
      ]);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      __$$TicketImplCopyWithImpl<_$TicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketImplToJson(
      this,
    );
  }
}

abstract class _Ticket implements Ticket {
  const factory _Ticket(
      {final int? id,
      final int? branchId,
      final int? userId,
      final int? tripId,
      final String? method,
      final int? status,
      final int? quantity,
      final String? price,
      final String? total,
      final List<int>? seats,
      final int? adults,
      final int? minors,
      final String? qr,
      final String? barcode,
      final String? date,
      final String? branchName,
      final String? userName,
      final String? tripName,
      final String? originImage,
      final String? tripOrigin,
      final String? destinationImage,
      final String? tripDestination,
      final String? schedule,
      final int? print}) = _$TicketImpl;

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$TicketImpl.fromJson;

  @override
  int? get id;
  @override
  int? get branchId;
  @override
  int? get userId;
  @override
  int? get tripId;
  @override
  String? get method;
  @override
  int? get status;
  @override
  int? get quantity;
  @override
  String? get price;
  @override
  String? get total;
  @override
  List<int>? get seats;
  @override
  int? get adults;
  @override
  int? get minors;
  @override
  String? get qr;
  @override
  String? get barcode;
  @override
  String? get date;
  @override
  String? get branchName;
  @override
  String? get userName;
  @override
  String? get tripName;
  @override
  String? get originImage;
  @override
  String? get tripOrigin;
  @override
  String? get destinationImage;
  @override
  String? get tripDestination;
  @override
  String? get schedule;
  @override
  int? get print;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
