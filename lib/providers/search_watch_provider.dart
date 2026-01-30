import 'package:flutter/foundation.dart';
import '../models/movie_summary_model.dart';

class SearchWatchProvider extends ChangeNotifier {
  List<MovieSummaryModel> get filteredMovies => _filteredMovies;
  List<MovieSummaryModel> _filteredMovies = [];

  void searchMovies(String query, List<MovieSummaryModel> allMovies) {
    if (query.isEmpty) {
      _filteredMovies = allMovies;
    } else {
      _filteredMovies = allMovies
          .where(
            (element) =>
                element.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _filteredMovies = [];
    notifyListeners();
  }
}
