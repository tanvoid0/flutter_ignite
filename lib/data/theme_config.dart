import 'package:flutter/material.dart';
import 'package:flutter_ignite/utils/pen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_config_options.dart';

class ThemeConfig {
  static const defaultColor = Color(0xFF09aeea);

  static SizedBox get spacingH =>
      SizedBox(height: ThemeConfig.config.spacingSize);

  static SizedBox get spacingW =>
      SizedBox(width: ThemeConfig.config.spacingSize);

  static const screenSettings = ResponsiveScreenSettings(
    tabletChangePoint: 600,
    desktopChangePoint: 800,
  );

  static BorderRadius get borderRadius =>
      BorderRadius.circular(ThemeConfig.config.spacingSize);

  static ThemeConfigOptions config = ThemeConfigOptions();
  static ThemeConfig? _instance;
  static bool _init = false;

  // static ThemeConfig get instance => _instance!;

  ThemeConfig({required ThemeConfigOptions config}) {
    if (_instance != null || _init) return;
    _init = true;
    _instance = ThemeConfig(config: config);
    // ignore: prefer_initializing_formals
    ThemeConfig.config = config;
  }

  ThemeData theme({isDark = false, required Color color}) {
    final backgroundColor = ThemeConfig.scaffoldBackgroundColor(isDark);
    return ThemeData(
      // color setup
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: color,
      colorScheme:
          (isDark ? const ColorScheme.dark() : const ColorScheme.light())
              .copyWith(secondary: ThemeConfig.config.secondaryColor),

      // icon theme
      iconTheme: iconStyle(ThemeConfig.config.iconColor),
      floatingActionButtonTheme: floatingActionButtonTheme(
          ThemeConfig.config.iconColor, backgroundColor),

      // appbar styles
      appBarTheme: appBarStyle(),

      // card styles
      cardTheme: cardStyle(isDark),

      // button styles
      elevatedButtonTheme: elevatedButtonStyle(isDark, color),
      textButtonTheme: textButtonStyle(color),

      // text styles
      textTheme: textStyle(isDark),

      // input styles
      inputDecorationTheme: inputStyle(color, isDark),
      textSelectionTheme: const TextSelectionThemeData().copyWith(
        cursorColor: color,
      ),

      // bottom navigation styles
      bottomNavigationBarTheme: bottomNavStyle(isDark, color),
      navigationRailTheme: navigationRailStyle(isDark, color),
    );
  }

  // Padding const
  static const padding = 20.0;
  static const paddingX = EdgeInsets.symmetric(horizontal: padding);
  static const paddingY = EdgeInsets.symmetric(vertical: padding);
  static const paddingXY = EdgeInsets.all(padding);
  static const paddingInsets = EdgeInsets.all(padding);

  // Margin const
  static const marginX = SizedBox(width: padding);
  static const marginY = SizedBox(height: padding);

  static scaffoldBackgroundColor(bool dark) => dark
      ? ThemeConfig.config.darkBackgroundColor
      : ThemeConfig.config.lightBackgroundColor;

  static IconThemeData iconStyle(color, {opacity = 0.8}) =>
      IconThemeData(color: color, opacity: opacity);

  static FloatingActionButtonThemeData floatingActionButtonTheme(
          backgroundColor, color) =>
      FloatingActionButtonThemeData(
          backgroundColor: backgroundColor, foregroundColor: color);

  static Color textColor(bool isDark) => isDark
      ? ThemeConfig.config.lightBackgroundColor
      : ThemeConfig.config.darkBackgroundColor;

  static TextTheme textStyle(bool dark) {
    final color = textColor(dark);
    Pen.write("Dark: $dark. Font color: ${color.value}");
    return GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: TextStyle(color: color),
      displayMedium: TextStyle(color: color),
      displaySmall: TextStyle(color: color),
      headlineLarge: TextStyle(color: color),
      headlineMedium: TextStyle(color: color),
      headlineSmall: TextStyle(color: color),
      titleLarge: TextStyle(color: color),
      titleMedium: TextStyle(color: color),
      titleSmall: TextStyle(color: color),
      bodyLarge: TextStyle(color: color),
      bodyMedium: TextStyle(color: color),
      bodySmall: TextStyle(color: color),
      labelLarge: TextStyle(color: color),
      labelMedium: TextStyle(color: color),
      labelSmall: TextStyle(color: color),
    );
  }

  static inputStyle(Color color, bool isDark) {
    return const InputDecorationTheme().copyWith(
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 1,
            color: color,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelStyle: TextStyle(
          color: textColor(isDark),
          fontSize: 12,
        ),
        hintStyle: TextStyle(color: textColor(isDark)));
  }

  // Appbar style
  static appBarStyle() => const AppBarTheme(centerTitle: false, elevation: 0);

  // Navigation rail style
  static navigationRailStyle(bool dark, pColor) => NavigationRailThemeData(
        indicatorColor: pColor,
        unselectedIconTheme: iconStyle(pColor, opacity: .32),
        selectedIconTheme:
            iconStyle((scaffoldBackgroundColor(dark)).withOpacity(0.7)),
      );

  // Bottom Nav style
  static bottomNavStyle(bool dark, pColor) => BottomNavigationBarThemeData(
        backgroundColor: pColor,
        unselectedIconTheme: iconStyle(pColor, opacity: .32),
        selectedItemColor: pColor,
        selectedIconTheme:
            iconStyle((scaffoldBackgroundColor(dark)).withOpacity(0.7)),
      );

  static textButtonStyle(Color color) => TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(color),
      ));

  static elevatedButtonStyle(isDark, Color color) => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: color,
              ),
            ),
          ),
          foregroundColor:
              WidgetStateProperty.all<Color>(scaffoldBackgroundColor(isDark)),
        ),
      );

  // Card theme
  static cardStyle(bool dark) => const CardTheme().copyWith(
        color: scaffoldBackgroundColor(dark),
        surfaceTintColor: scaffoldBackgroundColor(dark),
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  static Container getBorderedContainer({
    String? title,
    required Widget child,
    Color? color,
  }) {
    color ??= ThemeConfig.config.primaryColor;
    return Container(
      margin: const EdgeInsets.all(ThemeConfig.padding),
      padding: const EdgeInsets.all(ThemeConfig.padding),
      decoration: BoxDecoration(
        borderRadius: ThemeConfig.borderRadius,
        border: Border.all(color: color, width: 2.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: color,
              ),
            ),
          child,
        ],
      ),
    );
  }
}

enum TextFontSize { large, medium, small }

class TextFont {
  static TextFontSize large = TextFontSize.large;
  static TextFontSize medium = TextFontSize.medium;
  static TextFontSize small = TextFontSize.small;

  /// Display Texts
  static TextStyle display(BuildContext context, TextFontSize size) {
    final theme = Theme.of(context).textTheme;
    switch (size) {
      case TextFontSize.large:
        return theme.displayLarge!;
      case TextFontSize.medium:
        return theme.displayMedium!;
      case TextFontSize.small:
        return theme.displaySmall!;
    }
  }

  /// Headline Texts
  static TextStyle headline(BuildContext context, TextFontSize size) {
    final theme = Theme.of(context).textTheme;
    switch (size) {
      case TextFontSize.large:
        return theme.headlineLarge!;
      case TextFontSize.medium:
        return theme.headlineMedium!;
      case TextFontSize.small:
        return theme.headlineSmall!;
    }
  }

  /// Title Text
  static TextStyle title(BuildContext context, TextFontSize size) {
    final theme = Theme.of(context).textTheme;
    switch (size) {
      case TextFontSize.large:
        return theme.titleLarge!;
      case TextFontSize.medium:
        return theme.titleMedium!;
      case TextFontSize.small:
        return theme.titleSmall!;
    }
  }

  /// Body Text
  static TextStyle body(BuildContext context, TextFontSize size) {
    final theme = Theme.of(context).textTheme;
    switch (size) {
      case TextFontSize.large:
        return theme.bodyLarge!;
      case TextFontSize.medium:
        return theme.bodyMedium!;
      case TextFontSize.small:
        return theme.bodySmall!;
    }
  }
}
