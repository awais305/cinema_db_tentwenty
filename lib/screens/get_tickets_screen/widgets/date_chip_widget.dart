import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:flutter/material.dart';

class DateChipWidget extends StatelessWidget {
  final bool isSelected;
  final String date;
  final VoidCallback onTap;

  const DateChipWidget({
    super.key,
    required this.isSelected,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Palette.primaryColor : Palette.borderColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: !isSelected
              ? []
              : [
                  BoxShadow(
                    color: Palette.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 8,
                    spreadRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            date,
            style: CustomFontStyle.mediumText.copyWith(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
