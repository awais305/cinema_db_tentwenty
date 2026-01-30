import 'package:cinema_db/providers/watch_detail_provider.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../error_screen.dart';
import 'widgets/detail_body_content.dart';
import 'widgets/detail_header_content.dart';
import 'widgets/sliver_header_widget.dart';

class WatchDetailScreen extends StatelessWidget {
  const WatchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WatchDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isMovieDetailLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (provider.movieDetailFetchError.isNotEmpty) {
            return ErrorScreen(error: provider.movieDetailFetchError);
          }

          if (provider.movieDetail == null) {
            return ErrorScreen(error: 'No movie details available');
          } else {
            final isLandscape =
                MediaQuery.orientationOf(context) == Orientation.landscape;

            if (isLandscape) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        DetailHeaderContent(
                          isLandscape: true,
                          movieDetail: provider.movieDetail!,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: MediaQuery.paddingOf(context).top + 10,
                          left: 10,
                          child: IconButton(
                            onPressed: () => context.pop(),
                            icon: Image.asset(
                              AssetsIcons.arrowLeft,
                              color: Colors.white,
                              width: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom + 20,
                      ),
                      child: DetailBodyContent(
                        movieDetail: provider.movieDetail!,
                      ),
                    ),
                  ),
                ],
              );
            }

            return CustomScrollView(
              slivers: [
                SliverHeaderWidget(
                  isLandscape: false,
                  movieDetail: provider.movieDetail!,
                ),
                SliverToBoxAdapter(
                  child: DetailBodyContent(movieDetail: provider.movieDetail!),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
