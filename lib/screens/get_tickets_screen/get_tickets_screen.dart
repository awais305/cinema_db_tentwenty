import 'package:cinema_db/components/button_component.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../booking_screen/booking_screen.dart';
import 'widgets/date_chip_widget.dart';
import 'widgets/hall_map_widget.dart';

class GetTicketsScreen extends StatefulWidget {
  final String movieName;
  final String releaseDate;

  const GetTicketsScreen({
    super.key,
    required this.movieName,
    required this.releaseDate,
  });

  @override
  State<GetTicketsScreen> createState() => _GetTicketsScreenState();
}

class _GetTicketsScreenState extends State<GetTicketsScreen> {
  int selectedDateIndex = 0;
  int selectedTimeSlotIndex = 0;

  late List<Map<String, String>> dates;

  @override
  void initState() {
    dates = _generateNext7Days();

    super.initState();
  }

  List<Map<String, String>> _generateNext7Days() {
    final List<Map<String, String>> daysList = [];
    final DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final DateTime date = now.add(Duration(days: i));
      daysList.add({
        'day': DateFormat('d').format(date),
        'month': DateFormat('MMM').format(date),
      });
    }

    return daysList;
  }

  final List<Map<String, dynamic>> timeSlots = [
    {
      'time': '12:30',
      'cinema': 'Cinetech + Hall 1',
      'price': '50',
      'bonus': '2500',
    },
    {'time': '13:30', 'cinema': 'Cinetech', 'price': '75', 'bonus': '3000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(height: 94),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Date',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 62,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final isSelected = selectedDateIndex == index;
                return DateChipWidget(
                  isSelected: isSelected,
                  date: '${dates[index]['day']} ${dates[index]['month']}',
                  onTap: () => setState(() => selectedDateIndex = index),
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 190,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                final slot = timeSlots[index];
                final isSelected = selectedTimeSlotIndex == index;

                return HallMapWidget(
                  isSelected: isSelected,
                  slot: slot,
                  onTap: () => setState(() => selectedTimeSlotIndex = index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ButtonComponent(
          text: 'Select Seats',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(
                  movieName: widget.movieName,
                  releaseDate: widget.releaseDate,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
