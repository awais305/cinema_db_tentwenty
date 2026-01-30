import 'package:cinema_db/models/movie_detail_model.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:flutter/material.dart';

import 'genere_chip_widget.dart';

class DetailBodyContent extends StatelessWidget {
  final MovieDetailModel movieDetail;

  const DetailBodyContent({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Genres", style: CustomFontStyle.mediumText),
          const SizedBox(height: 14),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(movieDetail.genres.length, (index) {
              List<Color> colors = [];
              for (var i = 0; i < movieDetail.genres.length; i++) {
                colors.add(_colorsList[i % 5]);
              }

              return GenereChipWidget(
                color: colors[index],
                genere: movieDetail.genres[index].name,
              );
            }),
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: Palette.borderColor),
          const SizedBox(height: 15),
          Text("Overview", style: CustomFontStyle.mediumText),
          const SizedBox(height: 14),
          Text(
            movieDetail.overview,
            style: CustomFontStyle.regularText.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

List<Color> _colorsList = [
  Palette.cyanColor,
  Palette.pinkColor,
  Palette.purpleColor,
  Palette.goldYellowColor,
  Palette.primaryColor,
];
