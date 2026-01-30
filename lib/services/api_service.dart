import 'package:cinema_db/models/movie_summary_model.dart';
import 'package:dio/dio.dart';

import '../models/movie_detail_model.dart';
import '../models/movie_trailer_model.dart';

class APIServices {
  APIServices._();

  static final instance = APIServices._();

  static String baseURL = "https://api.themoviedb.org/3/";
  static String apiKey = "346004c17c6ee60e4a85975c03a81744";

  final Dio dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 30),
      queryParameters: {"api_key": apiKey},
    );

  Future<List<MovieSummaryModel>> getUpcomingMovies() async {
    final response = await dio.get("movie/upcoming");
    List<MovieSummaryModel> movies = List<MovieSummaryModel>.from(
      response.data["results"].map((x) => MovieSummaryModel.fromMap(x)),
    );
    return movies;
  }

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final response = await dio.get("movie/$movieId");
    return MovieDetailModel.fromJson(response.data);
  }

  Future<MovieTrailerModel> getMovieVideos(int movieId) async {
    final response = await dio.get(
      "movie/$movieId/videos",
      queryParameters: {"language": "en-US"},
    );
    return MovieTrailerModel.fromMap(response.data);
  }
}
