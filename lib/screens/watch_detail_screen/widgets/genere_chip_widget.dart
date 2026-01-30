import 'package:cinema_db/theme_data/fonts.dart';
import 'package:flutter/material.dart';

class GenereChipWidget extends StatelessWidget {
  final Color color;
  final String genere;

  const GenereChipWidget({
    super.key,
    required this.color,
    required this.genere,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: color,
      ),
      child: Text(
        genere,
        style: CustomFontStyle.mediumText.copyWith(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
