import 'package:flutter/foundation.dart';
import '../models/movie_summary_model.dart';
import '../services/api_service.dart';

class WatchListProvider extends ChangeNotifier {
  WatchListProvider() {
    fetchMovies();
  }

  String get fetchError => _fetchError;
  String _fetchError = "";

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  List<MovieSummaryModel> get movies => _movies;
  List<MovieSummaryModel> _movies = [];

  Future<void> fetchMovies() async {
    _isLoading = true;
    _fetchError = "";
    notifyListeners();
    try {
      final movies = await APIServices.instance.getUpcomingMovies();
      _movies = movies;
      notifyListeners();
    } catch (e) {
      _fetchError = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
