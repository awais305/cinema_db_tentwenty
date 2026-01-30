import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final int seatStatus;
  final double zoomLevel;
  final Function() onTap;

  const SeatWidget({
    super.key,
    required this.seatStatus,
    required this.zoomLevel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (seatStatus == -1) {
      return Container(
        width: 15 * zoomLevel,
        // height: 6.6 * zoomLevel,
        margin: EdgeInsets.only(right: 10 * zoomLevel),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 15 * zoomLevel,
        // height: 6.6 * zoomLevel,
        margin: EdgeInsets.only(right: 10 * zoomLevel),
        child: Image.asset(_getSeat(seatStatus)),
      ),
    );
  }
}

String _getSeat(int status) {
  switch (status) {
    case -1:
      return ''; // No seat
    case 0:
      return AssetsIcons.regularSeat; // Regular available (light blue)
    case 1:
      return AssetsIcons.vipSeat; // VIP available (purple)
    case 2:
      return AssetsIcons.notAvailableSeat; // Not available (gray)
    case 3:
      return AssetsIcons.selectedSeat; // Selected (orange/gold)
    default:
      return AssetsIcons.notAvailableSeat;
  }
}
