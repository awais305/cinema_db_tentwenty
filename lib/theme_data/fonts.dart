import 'package:cinema_db/theme_data/palette.dart';
import 'package:flutter/material.dart';

class CustomFontStyle {
  static const boldText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
    color: Palette.textColor,
  );

  static const semiboldText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    color: Palette.textColor,
  );

  static const mediumText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
    color: Palette.textColor,
  );

  static const regularText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: Palette.textColor,
  );

  static const lightText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    fontFamily: 'Poppins',
    color: Palette.textColor,
  );
}
