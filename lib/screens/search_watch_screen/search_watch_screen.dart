import 'package:cinema_db/providers/search_watch_provider.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:cinema_db/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme_data/fonts.dart';
import '../watch_list_screen/widgets/movie_genre_widget.dart';
import 'widgets/search_appbar_widget.dart';
import 'widgets/search_result_tile_widget.dart';

import 'package:flutter/services.dart';

class SearchWatchScreen extends StatefulWidget {
  const SearchWatchScreen({super.key});

  @override
  State<SearchWatchScreen> createState() => _SearchWatchScreenState();
}

class _SearchWatchScreenState extends State<SearchWatchScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Column(
        children: [
          SearchAppbarWidget(searchController: searchController),
          Expanded(
            child: Container(
              color: Palette.scaffoldBackgroundColor,
              child: Consumer<SearchWatchProvider>(
                builder: (context, searchWatchProvider, _) {
                  if (searchController.text.isEmpty) {
                    var genres = AppConstant.instance.genres();
                    genres.removeWhere((element) => element.thumbnail == null);

                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 163 / 100,
                      ),
                      itemCount: genres.length,
                      itemBuilder: (context, index) =>
                          MovieGenreWidget(genre: genres[index]),
                    );
                  }
                  if (searchWatchProvider.filteredMovies.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Top Results',
                            style: CustomFontStyle.mediumText.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Divider(height: 20, thickness: 1),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              itemCount:
                                  searchWatchProvider.filteredMovies.length,
                              itemBuilder: (context, index) =>
                                  SearchResultTileWidget(
                                    movie: searchWatchProvider
                                        .filteredMovies[index],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Results',
                        style: CustomFontStyle.mediumText.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
