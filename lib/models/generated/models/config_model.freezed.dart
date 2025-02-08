// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) {
  return _ConfigModel.fromJson(json);
}

/// @nodoc
mixin _$ConfigModel {
// Theme Configs
  int get primaryColor =>
      throw _privateConstructorUsedError; // Figure out the value somehow
  ThemeMode get theme => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigModelCopyWith<ConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigModelCopyWith<$Res> {
  factory $ConfigModelCopyWith(
          ConfigModel value, $Res Function(ConfigModel) then) =
      _$ConfigModelCopyWithImpl<$Res, ConfigModel>;
  @useResult
  $Res call({int primaryColor, ThemeMode theme});
}

/// @nodoc
class _$ConfigModelCopyWithImpl<$Res, $Val extends ConfigModel>
    implements $ConfigModelCopyWith<$Res> {
  _$ConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryColor = null,
    Object? theme = null,
  }) {
    return _then(_value.copyWith(
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigModelImplCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$ConfigModelImplCopyWith(
          _$ConfigModelImpl value, $Res Function(_$ConfigModelImpl) then) =
      __$$ConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int primaryColor, ThemeMode theme});
}

/// @nodoc
class __$$ConfigModelImplCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$ConfigModelImpl>
    implements _$$ConfigModelImplCopyWith<$Res> {
  __$$ConfigModelImplCopyWithImpl(
      _$ConfigModelImpl _value, $Res Function(_$ConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryColor = null,
    Object? theme = null,
  }) {
    return _then(_$ConfigModelImpl(
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as int,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigModelImpl extends _ConfigModel {
  _$ConfigModelImpl(
      {this.primaryColor = 0xFF09aeea, this.theme = ThemeMode.system})
      : super._();

  factory _$ConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigModelImplFromJson(json);

// Theme Configs
  @override
  @JsonKey()
  final int primaryColor;
// Figure out the value somehow
  @override
  @JsonKey()
  final ThemeMode theme;

  @override
  String toString() {
    return 'ConfigModel(primaryColor: $primaryColor, theme: $theme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigModelImpl &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.theme, theme) || other.theme == theme));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, primaryColor, theme);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      __$$ConfigModelImplCopyWithImpl<_$ConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigModelImplToJson(
      this,
    );
  }
}

abstract class _ConfigModel extends ConfigModel {
  factory _ConfigModel({final int primaryColor, final ThemeMode theme}) =
      _$ConfigModelImpl;
  _ConfigModel._() : super._();

  factory _ConfigModel.fromJson(Map<String, dynamic> json) =
      _$ConfigModelImpl.fromJson;

  @override // Theme Configs
  int get primaryColor;
  @override // Figure out the value somehow
  ThemeMode get theme;
  @override
  @JsonKey(ignore: true)
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
