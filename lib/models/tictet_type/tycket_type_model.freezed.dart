// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tycket_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TicketType _$TicketTypeFromJson(Map<String, dynamic> json) {
  return _TicketType.fromJson(json);
}

/// @nodoc
mixin _$TicketType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this TicketType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketTypeCopyWith<TicketType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketTypeCopyWith<$Res> {
  factory $TicketTypeCopyWith(
          TicketType value, $Res Function(TicketType) then) =
      _$TicketTypeCopyWithImpl<$Res, TicketType>;
  @useResult
  $Res call({int id, String name, String description});
}

/// @nodoc
class _$TicketTypeCopyWithImpl<$Res, $Val extends TicketType>
    implements $TicketTypeCopyWith<$Res> {
  _$TicketTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketTypeImplCopyWith<$Res>
    implements $TicketTypeCopyWith<$Res> {
  factory _$$TicketTypeImplCopyWith(
          _$TicketTypeImpl value, $Res Function(_$TicketTypeImpl) then) =
      __$$TicketTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String description});
}

/// @nodoc
class __$$TicketTypeImplCopyWithImpl<$Res>
    extends _$TicketTypeCopyWithImpl<$Res, _$TicketTypeImpl>
    implements _$$TicketTypeImplCopyWith<$Res> {
  __$$TicketTypeImplCopyWithImpl(
      _$TicketTypeImpl _value, $Res Function(_$TicketTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TicketType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$TicketTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketTypeImpl implements _TicketType {
  const _$TicketTypeImpl(
      {required this.id, required this.name, required this.description});

  factory _$TicketTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;

  @override
  String toString() {
    return 'TicketType(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  /// Create a copy of TicketType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketTypeImplCopyWith<_$TicketTypeImpl> get copyWith =>
      __$$TicketTypeImplCopyWithImpl<_$TicketTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketTypeImplToJson(
      this,
    );
  }
}

abstract class _TicketType implements TicketType {
  const factory _TicketType(
      {required final int id,
      required final String name,
      required final String description}) = _$TicketTypeImpl;

  factory _TicketType.fromJson(Map<String, dynamic> json) =
      _$TicketTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;

  /// Create a copy of TicketType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketTypeImplCopyWith<_$TicketTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
