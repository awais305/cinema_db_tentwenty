import 'package:cinema_db/models/genre_model.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/fonts.dart';

class MovieGenreWidget extends StatelessWidget {
  final GenreModel genre;
  const MovieGenreWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/${genre.thumbnail}.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Container(color: Colors.black.withValues(alpha: 0.35)),
          Positioned(
            left: 10,
            bottom: 20,
            child: Text(
              genre.name,
              style: CustomFontStyle.mediumText.copyWith(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
