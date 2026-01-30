import 'package:cinema_db/models/genre_model.dart';

import 'constants.dart';

extension GetMovieThumbnail on String {
  String getMovieThumbnail() {
    final String path = "https://image.tmdb.org/t/p/w500/";
    return path + this;
  }
}

extension GetGenreName on List<int> {
  String getGenreName() {
    final List<GenreModel> genres = AppConstant.instance.genres();
    final List<String> genreNames = genres
        .where((e) => contains(e.id))
        .map((e) => e.name)
        .toList();

    return genreNames.join(", ");
  }
}
