import 'package:flutter/material.dart';
import 'package:flutter_ignite/models/cache_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/models/config_model.freezed.dart';
part 'generated/models/config_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ConfigModel with _$ConfigModel implements Serializable<ConfigModel> {
  static const String cacheKey = "config";
  @override
  String get key => cacheKey;

  @override
  bool get isList => false;

  const ConfigModel._();

  factory ConfigModel({
    // Theme Configs
    @Default(0xFF09aeea) int primaryColor, // Figure out the value somehow
    @Default(ThemeMode.system) ThemeMode theme,
  }) = _ConfigModel;

  @override
  ConfigModel fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  factory ConfigModel.fromJson(final Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  @override
  ConfigModel defaultObject() => ConfigModel();
}
