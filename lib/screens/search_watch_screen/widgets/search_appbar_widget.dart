import 'package:cinema_db/components/text_field_component.dart';
import 'package:cinema_db/providers/watch_list_provider.dart';
import 'package:cinema_db/providers/search_watch_provider.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchAppbarWidget extends StatefulWidget {
  final TextEditingController searchController;

  const SearchAppbarWidget({super.key, required this.searchController});

  @override
  State<SearchAppbarWidget> createState() => _SearchAppbarWidgetState();
}

class _SearchAppbarWidgetState extends State<SearchAppbarWidget> {
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 20,
        left: 20,
        right: 20,
        bottom: 25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Palette.borderColor, width: 1),
        ),
      ),
      child: Consumer<SearchWatchProvider>(
        builder: (context, searchWatchProvider, _) {
          return AnimatedCrossFade(
            firstChild: TextFieldComponent(
              onChanged: (val) {
                final allMovies = context.read<WatchListProvider>().movies;
                searchWatchProvider.searchMovies(val, allMovies);
              },
              controller: widget.searchController,
              hint: 'TV shows, movies and more',
              onSubmitted: (value) => setState(() {
                isSubmitted = true;
              }),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  onPressed: () => context.pop(),
                  visualDensity: VisualDensity.compact,
                  icon: Image.asset(AssetsIcons.search, height: 21),
                ),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  widget.searchController.clear();
                  searchWatchProvider.clearSearch();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Image.asset(AssetsIcons.close),
                ),
              ),
            ),
            secondChild: InkWell(
              onTap: () => context.pop(),
              child: Row(
                spacing: 15,
                children: [
                  Image.asset(
                    AssetsIcons.arrowLeft,
                    color: Palette.textColor,
                    width: 30,
                  ),
                  Text(
                    "${searchWatchProvider.filteredMovies.length} Results Found",
                    style: CustomFontStyle.mediumText.copyWith(
                      color: Palette.textColor,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: isSubmitted
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          );
        },
      ),
    );
  }
}
