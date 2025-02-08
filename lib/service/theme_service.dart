// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_ignite/data/theme_config.dart';
import 'package:flutter_ignite/data/theme_config_options.dart';
import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late final ConfigService _configService;
  late final ThemeConfig themeConfig;

  late final Rx<ThemeMode> themeMode;
  late final Rx<Color> primaryColor;
  late final Rx<ThemeData> lightTheme;
  late final Rx<ThemeData> darkTheme;
  final Rx<bool> colorPickerMode = false.obs;

  ThemeService(
      {required ConfigService configService,
      required ThemeConfigOptions config}) {
    _configService = configService;
    themeConfig = ThemeConfig(config: config);

    themeMode = Rx<ThemeMode>(configService.item.theme);
    primaryColor = Rx<Color>(config.primaryColor);

    lightTheme = Rx<ThemeData>(
        themeConfig.theme(isDark: false, color: config.primaryColor));
    darkTheme = Rx<ThemeData>(
        themeConfig.theme(isDark: true, color: config.primaryColor));
  }

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  loadTheme() {
    if (_configService.initialized) {
      Pen.write("Loading Theme");
      primaryColor(Color(_configService.item.primaryColor));
      switchColor(primaryColor());
      themeMode(_configService.item.theme);
    }
  }

  toggleTheme() {
    final theme = themeMode();
    if (theme == ThemeMode.dark) {
      setTheme(ThemeMode.light);
    } else {
      setTheme(ThemeMode.dark);
    }
  }

  toggleColorPickerMode() => colorPickerMode(!colorPickerMode());

  switchColor(final Color color, {bool persist = true}) {
    if (color == primaryColor()) return;
    Pen.success("Changing color from $primaryColor to $color");
    colorPickerMode(false);
    primaryColor(color);
    lightTheme(themeConfig.theme(isDark: false, color: color));
    darkTheme(themeConfig.theme(isDark: true, color: color));
    if (persist) {
      _configService
          .setConfig(_configService.item.copyWith(primaryColor: color.value));
    }
  }

  setTheme(final ThemeMode theme) {
    Pen.write("Setting theme");
    themeMode(theme);
    switchColor(primaryColor());
    _configService.setConfig(_configService.item.copyWith(theme: theme));
  }

  bool get isDark => themeMode() == ThemeMode.system
      ? Brightness.dark ==
          SchedulerBinding.instance.platformDispatcher.platformBrightness
      : themeMode() == ThemeMode.dark;

  Color getTextColor(dark) => dark
      ? darkTheme().textTheme.titleMedium!.color!
      : lightTheme().textTheme.titleMedium!.color!;

// TODO: might be unnecessary package complication... Use when needed
// Future<Color> getAdaptiveColorFromImage(
//     final ImageProvider imageProvider) async {
//   return (await PaletteGenerator.fromImageProvider(imageProvider))
//       .dominantColor!
//       .color;
// }
}
