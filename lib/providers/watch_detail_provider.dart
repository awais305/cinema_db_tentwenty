import 'package:flutter/foundation.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_trailer_model.dart';
import '../services/api_service.dart';

class WatchDetailProvider extends ChangeNotifier {
  MovieDetailModel? get movieDetail => _movieDetail;
  MovieDetailModel? _movieDetail;

  String get movieDetailFetchError => _movieDetailFetchError;
  String _movieDetailFetchError = "";

  bool get isMovieDetailLoading => _isMovieDetailLoading;
  bool _isMovieDetailLoading = false;

  Future<void> getMovieDetail(int id) async {
    _isMovieDetailLoading = true;
    _movieDetail = null;
    _movieDetailFetchError = "";
    notifyListeners();
    try {
      final movieDetail = await APIServices.instance.getMovieDetails(id);
      _movieDetail = movieDetail;
      notifyListeners();
    } catch (e) {
      _movieDetailFetchError = e.toString();
      notifyListeners();
    } finally {
      _isMovieDetailLoading = false;
      notifyListeners();
    }
  }

  MovieTrailerModel? get trailerData => _trailerData;
  MovieTrailerModel? _trailerData;

  String get trailerFetchError => _trailerFetchError;
  String _trailerFetchError = "";

  bool get isTrailerLoading => _isTrailerLoading;
  bool _isTrailerLoading = false;

  Future<void> getMovieTrailers(int movieId) async {
    _isTrailerLoading = true;
    _trailerData = null;
    _trailerFetchError = "";
    notifyListeners();
    try {
      final trailerData = await APIServices.instance.getMovieVideos(movieId);
      _trailerData = trailerData;
      notifyListeners();
    } catch (e) {
      _trailerFetchError = e.toString();
      notifyListeners();
    } finally {
      _isTrailerLoading = false;
      notifyListeners();
    }
  }
}
