import 'dart:math';

import 'package:flutter/material.dart';

import 'palette.dart';

ThemeData themeData() => ThemeData(
  scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
  inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xFFF2F2F6)),
  fontFamily: "Poppins",
  primaryColor: Palette.primaryColor,
  primarySwatch: _generateMaterialColor(Palette.primaryColor),
);

MaterialColor _generateMaterialColor(Color color) {
  return MaterialColor(color.toARGB32(), {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  });
}

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
  _tintValue((color.r * 255).round(), factor),
  _tintValue((color.g * 255).round(), factor),
  _tintValue((color.b * 255).round(), factor),
  1,
);

int _shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
  _shadeValue((color.r * 255).round(), factor),
  _shadeValue((color.g * 255).round(), factor),
  _shadeValue((color.b * 255).round(), factor),
  1,
);
