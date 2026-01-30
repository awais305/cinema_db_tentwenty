import 'package:cinema_db/models/genre_model.dart';

class AppConstant {
  AppConstant._();

  static final instance = AppConstant._();
  final List<Map<String, dynamic>> _genres = [
    {
      "id": 28,
      // "thumbnail": '28',
      "name": "Action",
    },
    {
      "id": 12,
      // "thumbnail": '12',
      "name": "Adventure",
    },
    {
      "id": 16,
      // "thumbnail": '16',
      "name": "Animation",
    },
    {"id": 35, "thumbnail": '35', "name": "Comedy"},
    {"id": 80, "thumbnail": '80', "name": "Crime"},
    {"id": 99, "thumbnail": '99', "name": "Documentary"},
    {"id": 18, "thumbnail": '18', "name": "Drama"},
    {"id": 10751, "thumbnail": '10751', "name": "Family"},
    {"id": 14, "thumbnail": '14', "name": "Fantasy"},
    {"id": 36, "thumbnail": '36', "name": "History"},
    {"id": 27, "thumbnail": '27', "name": "Horror"},
    {
      "id": 10402,
      // "thumbnail": '10402',
      "name": "Music",
    },
    {
      "id": 9648,
      // "thumbnail": '9648',
      "name": "Mystery",
    },
    {
      "id": 10749,
      // "thumbnail": '10749',
      "name": "Romance",
    },
    {"id": 878, "thumbnail": '878', "name": "Sci-Fi"},
    {
      "id": 10770,
      // "thumbnail": '10770',
      "name": "TV Movie",
    },
    {"id": 53, "thumbnail": '53', "name": "Thriller"},
    {
      "id": 10752,
      // "thumbnail": '10752',
      "name": "War",
    },
    {
      "id": 37,
      // "thumbnail": '37',
      "name": "Western",
    },
  ];

  List<GenreModel> genres() {
    return _genres.map((e) => GenreModel.fromMap(e)).toList();
  }
}
