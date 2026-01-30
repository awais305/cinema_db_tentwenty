import 'package:cinema_db/models/movie_detail_model.dart';
import 'package:cinema_db/screens/watch_detail_screen/widgets/detail_header_content.dart';
import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SliverHeaderWidget extends StatelessWidget {
  final bool isLandscape;
  final MovieDetailModel movieDetail;

  const SliverHeaderWidget({
    super.key,
    required this.isLandscape,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: MediaQuery.paddingOf(context).top + 50,
      primary: false,
      expandedHeight: MediaQuery.sizeOf(context).height * 0.55,
      pinned: true,
      centerTitle: false,
      leadingWidth: 135,
      leading: Column(
        mainAxisAlignment: .end,
        children: [
          TextButton.icon(
            onPressed: () => context.pop(),
            label: Text(
              "Watch",
              style: CustomFontStyle.mediumText.copyWith(color: Colors.white),
            ),
            icon: Image.asset(
              AssetsIcons.arrowLeft,
              color: Colors.white,
              width: 30,
            ),
          ),
        ],
      ),
      stretch: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground],
        background: DetailHeaderContent(
          movieDetail: movieDetail,
          isLandscape: isLandscape,
        ),
      ),
    );
  }
}
