import 'package:cinema_db/components/network_image_component.dart';
import 'package:cinema_db/models/movie_summary_model.dart';
import 'package:cinema_db/providers/watch_detail_provider.dart';
import 'package:cinema_db/routes/app_routes.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WatchMovieWidget extends StatelessWidget {
  final MovieSummaryModel movie;

  const WatchMovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<WatchDetailProvider>(
          context,
          listen: false,
        ).getMovieDetail(movie.id);
        context.push(AppRoutes.watchDetail);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 335 / 180,
          child: Stack(
            children: [
              NetworkImageComponent(
                imageUrl: movie.posterPath.getMovieThumbnail(),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 22,
                right: 22,
                bottom: 20,
                child: Text(
                  movie.title,
                  style: CustomFontStyle.mediumText.copyWith(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
