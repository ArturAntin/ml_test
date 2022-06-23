// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exercise_cg.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExerciseTearOff {
  const _$ExerciseTearOff();

  _Exercise call(
      {required String displayName,
      required String image,
      required String gif,
      required List<String> descriptionTexts,
      required ExerciseHandler handler}) {
    return _Exercise(
      displayName: displayName,
      image: image,
      gif: gif,
      descriptionTexts: descriptionTexts,
      handler: handler,
    );
  }
}

/// @nodoc
const $Exercise = _$ExerciseTearOff();

/// @nodoc
mixin _$Exercise {
  String get displayName => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get gif => throw _privateConstructorUsedError;
  List<String> get descriptionTexts => throw _privateConstructorUsedError;
  ExerciseHandler get handler => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res>;
  $Res call(
      {String displayName,
      String image,
      String gif,
      List<String> descriptionTexts,
      ExerciseHandler handler});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res> implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  final Exercise _value;
  // ignore: unused_field
  final $Res Function(Exercise) _then;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? image = freezed,
    Object? gif = freezed,
    Object? descriptionTexts = freezed,
    Object? handler = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      gif: gif == freezed
          ? _value.gif
          : gif // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTexts: descriptionTexts == freezed
          ? _value.descriptionTexts
          : descriptionTexts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      handler: handler == freezed
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as ExerciseHandler,
    ));
  }
}

/// @nodoc
abstract class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) then) =
      __$ExerciseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String displayName,
      String image,
      String gif,
      List<String> descriptionTexts,
      ExerciseHandler handler});
}

/// @nodoc
class __$ExerciseCopyWithImpl<$Res> extends _$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(_Exercise _value, $Res Function(_Exercise) _then)
      : super(_value, (v) => _then(v as _Exercise));

  @override
  _Exercise get _value => super._value as _Exercise;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? image = freezed,
    Object? gif = freezed,
    Object? descriptionTexts = freezed,
    Object? handler = freezed,
  }) {
    return _then(_Exercise(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      gif: gif == freezed
          ? _value.gif
          : gif // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionTexts: descriptionTexts == freezed
          ? _value.descriptionTexts
          : descriptionTexts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      handler: handler == freezed
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as ExerciseHandler,
    ));
  }
}

/// @nodoc

class _$_Exercise extends _Exercise {
  const _$_Exercise(
      {required this.displayName,
      required this.image,
      required this.gif,
      required this.descriptionTexts,
      required this.handler})
      : super._();

  @override
  final String displayName;
  @override
  final String image;
  @override
  final String gif;
  @override
  final List<String> descriptionTexts;
  @override
  final ExerciseHandler handler;

  @override
  String toString() {
    return 'Exercise(displayName: $displayName, image: $image, gif: $gif, descriptionTexts: $descriptionTexts, handler: $handler)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Exercise &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.gif, gif) &&
            const DeepCollectionEquality()
                .equals(other.descriptionTexts, descriptionTexts) &&
            const DeepCollectionEquality().equals(other.handler, handler));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(gif),
      const DeepCollectionEquality().hash(descriptionTexts),
      const DeepCollectionEquality().hash(handler));

  @JsonKey(ignore: true)
  @override
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);
}

abstract class _Exercise extends Exercise {
  const factory _Exercise(
      {required String displayName,
      required String image,
      required String gif,
      required List<String> descriptionTexts,
      required ExerciseHandler handler}) = _$_Exercise;
  const _Exercise._() : super._();

  @override
  String get displayName;
  @override
  String get image;
  @override
  String get gif;
  @override
  List<String> get descriptionTexts;
  @override
  ExerciseHandler get handler;
  @override
  @JsonKey(ignore: true)
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}
