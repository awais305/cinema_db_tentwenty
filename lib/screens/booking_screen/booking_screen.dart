import 'package:cinema_db/screens/booking_screen/widgets/bottom_section.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';

import '../../theme_data/fonts.dart';
import '../../theme_data/palette.dart';
import 'widgets/seat_widget.dart';

class BookingScreen extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  const BookingScreen({
    super.key,
    required this.movieName,
    required this.releaseDate,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Seat status: -1 = no seat (empty), 0 = available regular, 1 = available VIP, 2 = not available, 3 = selected
  // Total seats: 240 - 12 (missing from row 1) = 228
  // Layout: 3 columns (5 seats, 14 seats, 5 seats) with gaps between columns
  // Row 1: Missing 3 seats from start and end (6 total missing from row 1)
  // Rows 2,3,4: Missing 1 seat from start and end (2 missing per row)

  final List<List<List<int>>> seats = [
    // Row 1 - missing 3 from start and end of column 1 and 3
    [
      [-1, -1, -1, 0, 0], // Column 1: 2 seats (missing 3)
      [2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0], // Column 2: 14 seats
      [0, 0, -1, -1, -1], // Column 3: 2 seats (missing 3)
    ],
    // Row 2 - missing 1 from start and end
    [
      [-1, 2, 0, 2, 2], // Column 1: 4 seats (missing 1)
      [0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0], // Column 2: 14 seats
      [0, 2, 0, 0, -1], // Column 3: 4 seats (missing 1)
    ],
    // Row 3 - missing 1 from start and end
    [
      [-1, 0, 2, 2, 2], // Column 1: 4 seats
      [0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2], // Column 2: 14 seats
      [0, 0, 2, 2, -1], // Column 3: 4 seats
    ],
    // Row 4 - missing 1 from start and end
    [
      [-1, 0, 2, 2, 2], // Column 1: 4 seats
      [0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 0, 0, 2, -1], // Column 3: 4 seats
    ],
    // Row 5 - full 24 seats
    [
      [0, 0, 2, 2, 2], // Column 1: 5 seats
      [2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 0, 2, 2, 0], // Column 3: 5 seats
    ],
    // Row 6 - full 24 seats
    [
      [2, 0, 0, 2, 2], // Column 1: 5 seats
      [2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 0, 2, 2, 0], // Column 3: 5 seats
    ],
    // Row 7 - full 24 seats
    [
      [0, 0, 2, 2, 2], // Column 1: 5 seats
      [2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 0, 2, 2, 0], // Column 3: 5 seats
    ],
    // Row 8 - full 24 seats
    [
      [2, 0, 0, 2, 2], // Column 1: 5 seats
      [2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 2, 2, 2, 0], // Column 3: 5 seats
    ],
    // Row 9 - full 24 seats
    [
      [0, 0, 2, 2, 2], // Column 1: 5 seats
      [2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 2], // Column 2: 14 seats
      [2, 0, 2, 2, 0], // Column 3: 5 seats
    ],
    // Row 10 - VIP row, full 24 seats
    [
      [1, 1, 1, 1, 2], // Column 1: 5 seats (4 VIP, 1 unavailable)
      [
        2,
        1,
        1,
        1,
        2,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        2,
      ], // Column 2: 14 seats (12 VIP, 2 unavailable)
      [1, 1, 1, 1, 1], // Column 3: 5 seats (all VIP)
    ],
  ];

  // Store original seat types for deselection
  Map<String, int> originalSeatTypes = {};
  Set<String> selectedSeats = {};
  double zoomLevel = 0.6;
  final ScrollController horizontalScrollController = ScrollController();
  final ScrollController verticalScrollController = ScrollController();

  int get totalPrice {
    int total = 0;
    for (String seatKey in selectedSeats) {
      // final parts = seatKey.split('-');
      // final row = int.parse(parts[0]);
      // final col = int.parse(parts[1]);
      // final seatIndex = int.parse(parts[2]);
      final originalType = originalSeatTypes[seatKey] ?? 0;
      // VIP seats cost 150$, regular seats cost 50$
      total += originalType == 1 ? 150 : 50;
    }
    return total;
  }

  void zoomIn() {
    setState(() {
      if (zoomLevel < 2.0) {
        zoomLevel = (zoomLevel + 0.2).clamp(0.6, 2.0);
      }
    });
  }

  void zoomOut() {
    setState(() {
      if (zoomLevel > 0.6) {
        zoomLevel = (zoomLevel - 0.2).clamp(0.6, 2.0);
        // Auto-center after zoom out
        WidgetsBinding.instance.addPostFrameCallback((_) {
          centerSeats();
        });
      }
    });
  }

  void centerSeats() {
    if (horizontalScrollController.hasClients) {
      final maxScroll = horizontalScrollController.position.maxScrollExtent;
      final centerPosition = maxScroll / 2;
      horizontalScrollController.animateTo(
        centerPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    if (verticalScrollController.hasClients) {
      final maxScroll = verticalScrollController.position.maxScrollExtent;
      final centerPosition = maxScroll / 2;
      verticalScrollController.animateTo(
        centerPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    super.dispose();
  }

  void toggleSeat(int row, int col, int seatIndex) {
    final seatKey = '$row-$col-$seatIndex';
    final currentSeat = seats[row][col][seatIndex];

    // Can't select empty seats or unavailable seats
    if (currentSeat == -1 || currentSeat == 2) return;

    setState(() {
      if (currentSeat == 3) {
        // Deselect - restore original type
        seats[row][col][seatIndex] = originalSeatTypes[seatKey] ?? 0;
        selectedSeats.remove(seatKey);
        originalSeatTypes.remove(seatKey);
      } else if (currentSeat == 0 || currentSeat == 1) {
        // Select - store original type and mark as selected
        originalSeatTypes[seatKey] = currentSeat;
        seats[row][col][seatIndex] = 3;
        selectedSeats.add(seatKey);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Set initial selected seat (row 3, column 2 middle section, index 7)
    originalSeatTypes['2-1-7'] = 0;
    seats[2][1][7] = 3;
    selectedSeats.add('2-1-7');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 16,
        backgroundColor: Colors.white,
        title: Column(
          spacing: 6,
          children: [
            Text(
              widget.movieName,
              style: CustomFontStyle.mediumText.copyWith(fontSize: 17),
            ),
            Text(
              widget.releaseDate,
              style: CustomFontStyle.mediumText.copyWith(
                fontSize: 12,
                color: Palette.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Seats area
            Expanded(
              child: Container(
                color: Palette.scaffoldBackgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AssetImages.screen,
                            width: double.infinity,
                          ),
                          Text(
                            'SCREEN',
                            style: CustomFontStyle.mediumText.copyWith(
                              fontSize: 12,
                              color: Palette.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Seats grid - fully scrollable with 3 columns
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Scrollbar(
                            controller: horizontalScrollController,
                            thumbVisibility: true,
                            thickness: 4,
                            trackVisibility: true,
                            child: SingleChildScrollView(
                              controller: horizontalScrollController,
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                controller: verticalScrollController,
                                scrollDirection: Axis.vertical,
                                child: Row(
                                  children: [
                                    Column(
                                      children: List.generate(10, (rowIndex) {
                                        return Row(
                                          children: [
                                            // Row number - centered vertically
                                            Container(
                                              width: 20 * zoomLevel,
                                              margin: EdgeInsets.only(left: 10),
                                              height: 20 * zoomLevel,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${rowIndex + 1}',
                                                style: TextStyle(
                                                  fontSize: 12 * zoomLevel,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 20 * zoomLevel,
                                                right: 20 * zoomLevel,
                                                bottom: 20.0 * zoomLevel,
                                              ),
                                              child: Row(
                                                spacing: 20 * zoomLevel,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Column 1 (5 seats)
                                                  Row(
                                                    children: List.generate(
                                                      seats[rowIndex][0].length,
                                                      (seatIndex) {
                                                        final seatStatus =
                                                            seats[rowIndex][0][seatIndex];
                                                        return SeatWidget(
                                                          seatStatus:
                                                              seatStatus,
                                                          zoomLevel: zoomLevel,
                                                          onTap: () =>
                                                              toggleSeat(
                                                                rowIndex,
                                                                0,
                                                                seatIndex,
                                                              ),
                                                        );
                                                      },
                                                    ),
                                                  ),

                                                  // Column 2 (14 seats)
                                                  Row(
                                                    children: List.generate(
                                                      seats[rowIndex][1].length,
                                                      (seatIndex) {
                                                        final seatStatus =
                                                            seats[rowIndex][1][seatIndex];

                                                        return SeatWidget(
                                                          onTap: () =>
                                                              toggleSeat(
                                                                rowIndex,
                                                                1,
                                                                seatIndex,
                                                              ),
                                                          seatStatus:
                                                              seatStatus,

                                                          zoomLevel: zoomLevel,
                                                        );
                                                      },
                                                    ),
                                                  ),

                                                  // Column 3 (5 seats)
                                                  Row(
                                                    children: List.generate(
                                                      seats[rowIndex][2].length,
                                                      (seatIndex) {
                                                        final seatStatus =
                                                            seats[rowIndex][2][seatIndex];

                                                        return SeatWidget(
                                                          onTap: () =>
                                                              toggleSeat(
                                                                rowIndex,
                                                                2,
                                                                seatIndex,
                                                              ),
                                                          seatStatus:
                                                              seatStatus,
                                                          zoomLevel: zoomLevel,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Zoom controls
                          Positioned(
                            right: 10,
                            bottom: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: zoomIn,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: zoomLevel == 2.0
                                          ? Palette.borderColor
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Palette.borderColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '+',
                                        style: CustomFontStyle.mediumText,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: zoomOut,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: zoomLevel == 0.6
                                          ? Palette.borderColor
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Palette.borderColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '-',
                                        style: CustomFontStyle.mediumText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                  ],
                ),
              ),
            ),

            BottomSection(
              selectedSeats: selectedSeats,
              totalPrice: totalPrice.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
