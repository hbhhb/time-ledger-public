// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LogEntity {
  String get id => throw _privateConstructorUsedError;
  DateTime get targetDate => throw _privateConstructorUsedError;
  String? get categoryId =>
      throw _privateConstructorUsedError; // Nullable for unlinked logs
  int get duration => throw _privateConstructorUsedError; // Minutes
  String get snapshotName => throw _privateConstructorUsedError;
  String get snapshotIcon =>
      throw _privateConstructorUsedError; // Added for history persistence
  TimeValue get snapshotValue => throw _privateConstructorUsedError;
  String? get categoryIcon =>
      throw _privateConstructorUsedError; // Joined field
  String? get categoryName =>
      throw _privateConstructorUsedError; // Joined field from Category table
  String? get memo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of LogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogEntityCopyWith<LogEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogEntityCopyWith<$Res> {
  factory $LogEntityCopyWith(LogEntity value, $Res Function(LogEntity) then) =
      _$LogEntityCopyWithImpl<$Res, LogEntity>;
  @useResult
  $Res call(
      {String id,
      DateTime targetDate,
      String? categoryId,
      int duration,
      String snapshotName,
      String snapshotIcon,
      TimeValue snapshotValue,
      String? categoryIcon,
      String? categoryName,
      String? memo,
      DateTime createdAt});
}

/// @nodoc
class _$LogEntityCopyWithImpl<$Res, $Val extends LogEntity>
    implements $LogEntityCopyWith<$Res> {
  _$LogEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetDate = null,
    Object? categoryId = freezed,
    Object? duration = null,
    Object? snapshotName = null,
    Object? snapshotIcon = null,
    Object? snapshotValue = null,
    Object? categoryIcon = freezed,
    Object? categoryName = freezed,
    Object? memo = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      snapshotName: null == snapshotName
          ? _value.snapshotName
          : snapshotName // ignore: cast_nullable_to_non_nullable
              as String,
      snapshotIcon: null == snapshotIcon
          ? _value.snapshotIcon
          : snapshotIcon // ignore: cast_nullable_to_non_nullable
              as String,
      snapshotValue: null == snapshotValue
          ? _value.snapshotValue
          : snapshotValue // ignore: cast_nullable_to_non_nullable
              as TimeValue,
      categoryIcon: freezed == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogEntityImplCopyWith<$Res>
    implements $LogEntityCopyWith<$Res> {
  factory _$$LogEntityImplCopyWith(
          _$LogEntityImpl value, $Res Function(_$LogEntityImpl) then) =
      __$$LogEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime targetDate,
      String? categoryId,
      int duration,
      String snapshotName,
      String snapshotIcon,
      TimeValue snapshotValue,
      String? categoryIcon,
      String? categoryName,
      String? memo,
      DateTime createdAt});
}

/// @nodoc
class __$$LogEntityImplCopyWithImpl<$Res>
    extends _$LogEntityCopyWithImpl<$Res, _$LogEntityImpl>
    implements _$$LogEntityImplCopyWith<$Res> {
  __$$LogEntityImplCopyWithImpl(
      _$LogEntityImpl _value, $Res Function(_$LogEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of LogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetDate = null,
    Object? categoryId = freezed,
    Object? duration = null,
    Object? snapshotName = null,
    Object? snapshotIcon = null,
    Object? snapshotValue = null,
    Object? categoryIcon = freezed,
    Object? categoryName = freezed,
    Object? memo = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$LogEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      snapshotName: null == snapshotName
          ? _value.snapshotName
          : snapshotName // ignore: cast_nullable_to_non_nullable
              as String,
      snapshotIcon: null == snapshotIcon
          ? _value.snapshotIcon
          : snapshotIcon // ignore: cast_nullable_to_non_nullable
              as String,
      snapshotValue: null == snapshotValue
          ? _value.snapshotValue
          : snapshotValue // ignore: cast_nullable_to_non_nullable
              as TimeValue,
      categoryIcon: freezed == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$LogEntityImpl implements _LogEntity {
  const _$LogEntityImpl(
      {required this.id,
      required this.targetDate,
      required this.categoryId,
      required this.duration,
      required this.snapshotName,
      required this.snapshotIcon,
      required this.snapshotValue,
      this.categoryIcon,
      this.categoryName,
      this.memo,
      required this.createdAt});

  @override
  final String id;
  @override
  final DateTime targetDate;
  @override
  final String? categoryId;
// Nullable for unlinked logs
  @override
  final int duration;
// Minutes
  @override
  final String snapshotName;
  @override
  final String snapshotIcon;
// Added for history persistence
  @override
  final TimeValue snapshotValue;
  @override
  final String? categoryIcon;
// Joined field
  @override
  final String? categoryName;
// Joined field from Category table
  @override
  final String? memo;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'LogEntity(id: $id, targetDate: $targetDate, categoryId: $categoryId, duration: $duration, snapshotName: $snapshotName, snapshotIcon: $snapshotIcon, snapshotValue: $snapshotValue, categoryIcon: $categoryIcon, categoryName: $categoryName, memo: $memo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.snapshotName, snapshotName) ||
                other.snapshotName == snapshotName) &&
            (identical(other.snapshotIcon, snapshotIcon) ||
                other.snapshotIcon == snapshotIcon) &&
            (identical(other.snapshotValue, snapshotValue) ||
                other.snapshotValue == snapshotValue) &&
            (identical(other.categoryIcon, categoryIcon) ||
                other.categoryIcon == categoryIcon) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      targetDate,
      categoryId,
      duration,
      snapshotName,
      snapshotIcon,
      snapshotValue,
      categoryIcon,
      categoryName,
      memo,
      createdAt);

  /// Create a copy of LogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogEntityImplCopyWith<_$LogEntityImpl> get copyWith =>
      __$$LogEntityImplCopyWithImpl<_$LogEntityImpl>(this, _$identity);
}

abstract class _LogEntity implements LogEntity {
  const factory _LogEntity(
      {required final String id,
      required final DateTime targetDate,
      required final String? categoryId,
      required final int duration,
      required final String snapshotName,
      required final String snapshotIcon,
      required final TimeValue snapshotValue,
      final String? categoryIcon,
      final String? categoryName,
      final String? memo,
      required final DateTime createdAt}) = _$LogEntityImpl;

  @override
  String get id;
  @override
  DateTime get targetDate;
  @override
  String? get categoryId; // Nullable for unlinked logs
  @override
  int get duration; // Minutes
  @override
  String get snapshotName;
  @override
  String get snapshotIcon; // Added for history persistence
  @override
  TimeValue get snapshotValue;
  @override
  String? get categoryIcon; // Joined field
  @override
  String? get categoryName; // Joined field from Category table
  @override
  String? get memo;
  @override
  DateTime get createdAt;

  /// Create a copy of LogEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogEntityImplCopyWith<_$LogEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
