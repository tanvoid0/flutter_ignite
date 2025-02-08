// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigModelImpl _$$ConfigModelImplFromJson(Map<String, dynamic> json) =>
    _$ConfigModelImpl(
      primaryColor: (json['primary_color'] as num?)?.toInt() ?? 0xFF09aeea,
      theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
          ThemeMode.system,
    );

Map<String, dynamic> _$$ConfigModelImplToJson(_$ConfigModelImpl instance) =>
    <String, dynamic>{
      'primary_color': instance.primaryColor,
      'theme': _$ThemeModeEnumMap[instance.theme]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
