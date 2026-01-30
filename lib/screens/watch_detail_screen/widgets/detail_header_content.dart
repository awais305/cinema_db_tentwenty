import 'package:cinema_db/components/button_component.dart';
import 'package:cinema_db/components/network_image_component.dart';
import 'package:cinema_db/models/movie_detail_model.dart';
import 'package:cinema_db/routes/app_routes.dart';
import 'package:cinema_db/screens/get_tickets_screen/get_tickets_screen.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DetailHeaderContent extends StatelessWidget {
  final bool isLandscape;
  final MovieDetailModel movieDetail;
  final double? height;
  final double? width;

  const DetailHeaderContent({
    super.key,
    required this.isLandscape,
    required this.movieDetail,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (movieDetail.backdropPath != null)
          NetworkImageComponent(
            imageUrl: movieDetail.backdropPath!.getMovieThumbnail(),
            height: height ?? MediaQuery.sizeOf(context).height * 0.55,
            width: width ?? MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
        Positioned.fill(child: Container(color: Colors.black12)),
        Positioned(
          left: 66,
          right: 66,
          bottom: 34,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "In theaters ${DateFormat("MMMM dd, yyyy").format(movieDetail.releaseDate)}",
                style: CustomFontStyle.mediumText.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  ButtonComponent(
                    text: 'Get Tickets',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return GetTicketsScreen(
                              movieName: movieDetail.title,
                              releaseDate:
                                  "In theaters ${DateFormat("MMMM dd, yyyy").format(movieDetail.releaseDate)}",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  ButtonComponent.outlined(
                    text: 'Watch Trailer',
                    icon: Icon(Icons.play_arrow, color: Colors.white),
                    onPressed: () {
                      GoRouter.of(
                        context,
                      ).push(AppRoutes.trailer, extra: movieDetail);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
