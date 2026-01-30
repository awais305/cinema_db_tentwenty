import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_db/models/movie_summary_model.dart';
import 'package:cinema_db/providers/watch_detail_provider.dart';
import 'package:cinema_db/routes/app_routes.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:cinema_db/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchResultTileWidget extends StatelessWidget {
  final MovieSummaryModel movie;

  const SearchResultTileWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.heavyImpact();
        if (context.mounted) {
          context.push(AppRoutes.watchDetail);
        }

        if (context.mounted) {
          await context.read<WatchDetailProvider>().getMovieDetail(movie.id);
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 130,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: movie.posterPath.getMovieThumbnail(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 21),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: CustomFontStyle.mediumText.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.genreIds.getGenreName(),
                  style: CustomFontStyle.mediumText.copyWith(
                    fontSize: 12,
                    color: Palette.lightGreyColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 21),
          Image.asset(AssetsIcons.moreHoriz, width: 20),
        ],
      ),
    );
  }
}
