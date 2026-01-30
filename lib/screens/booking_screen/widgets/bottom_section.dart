import 'package:cinema_db/components/button_component.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  final Set<String> selectedSeats;
  final String totalPrice;

  const BottomSection({
    super.key,
    required this.selectedSeats,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 26),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegendItem('Selected', AssetsIcons.selectedSeat),
                    _buildLegendItem(
                      'Not available',
                      AssetsIcons.notAvailableSeat,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegendItem('VIP (150\$)', AssetsIcons.vipSeat),
                    _buildLegendItem(
                      'Regular (50 \$)',
                      AssetsIcons.regularSeat,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            decoration: BoxDecoration(
              color: Palette.borderColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: .min,
              children: [
                Text(
                  '${selectedSeats.length} / ',
                  style: CustomFontStyle.mediumText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '3 row',
                  style: CustomFontStyle.regularText.copyWith(fontSize: 12),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.close, size: 20),
              ],
            ),
          ),

          // Bottom bar with price and button
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              34,
              24,
              MediaQuery.paddingOf(context).bottom + 24,
            ),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 25,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Palette.borderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Total Price',
                          style: CustomFontStyle.regularText.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$ $totalPrice',
                          style: CustomFontStyle.semiboldText.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: ButtonComponent(
                    height: 50,
                    text: 'Proceed to pay',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLegendItem(String label, String image) {
  return Expanded(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 16.16,
          width: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: CustomFontStyle.mediumText.copyWith(
            fontSize: 12,
            color: Color(0xFF8F8F8F),
          ),
        ),
      ],
    ),
  );
}
