import 'package:cinema_db/providers/watch_list_provider.dart';
import 'package:cinema_db/routes/app_routes.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'widgets/watch_movie_widget.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: false,
          title: Text(' Watch', style: CustomFontStyle.mediumText),
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsets.symmetric(horizontal: 24),
          actions: [
            InkWell(
              onTap: () {
                // context.read<SearchProvider>().clearSearch();
                context.push('${AppRoutes.watch}/${AppRoutes.searchWatch}');
              },
              child: Image.asset(AssetsIcons.search, height: 21),
            ),
          ],
        ),
        Expanded(
          child: Consumer<WatchListProvider>(
            builder: (context, watchListProvider, child) {
              if (watchListProvider.isLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (watchListProvider.movies.isEmpty) {
                return Center(
                  child: Text(
                    'No movies in watch list',
                    style: CustomFontStyle.mediumText,
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: watchListProvider.movies.length,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemBuilder: (context, index) =>
                      WatchMovieWidget(movie: watchListProvider.movies[index]),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
