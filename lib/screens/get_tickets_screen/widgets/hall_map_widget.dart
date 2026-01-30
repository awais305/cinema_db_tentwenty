import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';

class HallMapWidget extends StatelessWidget {
  final bool isSelected;
  final Map<String, dynamic> slot;
  final VoidCallback onTap;

  const HallMapWidget({
    super.key,
    required this.isSelected,
    required this.slot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(
              slot['time'],
              style: CustomFontStyle.mediumText.copyWith(fontSize: 12),
            ),
            const SizedBox(width: 8),
            Text(
              slot['cinema'],
              style: CustomFontStyle.mediumText.copyWith(
                fontSize: 12,
                color: Color(0xFF8F8F8F),
              ),
            ),
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 249 / 145,
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(vertical: 16),
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF42B4E6)
                        : Palette.lightGreyColor,
                    width: 1,
                  ),
                  color: Palette.scaffoldBackgroundColor,
                  boxShadow: !isSelected
                      ? []
                      : [
                          BoxShadow(
                            color: Palette.lightGreyColor.withValues(
                              alpha: 0.7,
                            ),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                          ),
                        ],
                ),
                child: Image.asset(AssetImages.hallMap),
              ),
            ),
          ),
        ),
        SizedBox.shrink(),
        RichText(
          text: TextSpan(
            style: CustomFontStyle.mediumText.copyWith(
              fontSize: 12,
              color: Color(0xFF8F8F8F),
            ),
            children: [
              const TextSpan(text: 'From '),
              TextSpan(
                text: '${slot['price']}\$ ',
                style: CustomFontStyle.mediumText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: 'or '),
              TextSpan(
                text: '${slot['bonus']} bonus',
                style: CustomFontStyle.mediumText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
