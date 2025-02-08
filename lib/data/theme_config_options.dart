import 'package:flutter/painting.dart';

class ThemeConfigOptions {
  final Color primaryColor;
  final Color secondaryColor;
  final Color iconColor;
  final Color lightBackgroundColor;
  final Color darkBackgroundColor;
  final List<Color> colorPalette;

  final double spacingSize;
  final double borderRadius;

  ThemeConfigOptions({
    this.primaryColor = const Color(0xFF09aeea),
    this.secondaryColor = const Color(0xFFC1DF1F),
    this.iconColor = const Color(0xFF09aeea),
    this.darkBackgroundColor = const Color(0xFF444444),
    this.lightBackgroundColor = const Color(0xFFf2f7f9),
    this.colorPalette = const [
      Color(0xFF09aeea),
      Color(0xFF0ba376),
      Color(0xFF9b5de5),
      Color(0xFFEE2E31),
      Color(0xFFf77f00),
    ],
    this.spacingSize = 20.0,
    this.borderRadius = 8.0,
  });
}
