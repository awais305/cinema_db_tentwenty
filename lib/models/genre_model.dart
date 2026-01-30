class GenreModel {
  final int id;
  final String name;
  final String? thumbnail;

  GenreModel({required this.id, required this.name, this.thumbnail});

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'],
      name: map['name'],
      thumbnail: map['thumbnail'],
    );
  }
}
