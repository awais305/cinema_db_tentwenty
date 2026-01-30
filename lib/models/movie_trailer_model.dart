class MovieTrailerModel {
  final int id;
  final List<VideoDataModel> results;
  MovieTrailerModel({required this.id, required this.results});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieTrailerModel.fromMap(Map<String, dynamic> map) {
    return MovieTrailerModel(
      id: map['id'] as int,
      results: List<VideoDataModel>.from(
        (map['results']).map<VideoDataModel>(
          (x) => VideoDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class VideoDataModel {
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String key;
  final String site;
  final int? size;
  final String? type;
  final bool official;
  final DateTime? publishedAt;
  final String? id;
  VideoDataModel({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iso6391': iso6391,
      'iso31661': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'publishedAt': publishedAt?.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory VideoDataModel.fromMap(Map<String, dynamic> map) {
    return VideoDataModel(
      iso6391: map['iso6391'] as String?,
      iso31661: map['iso31661'] as String?,
      name: map['name'] as String?,
      key: map['key'] as String,
      site: map['site'] as String,
      size: map['size'] as int?,
      type: map['type'] as String?,
      official: map['official'] as bool,
      publishedAt: map['publishedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['publishedAt'])
          : null,
      id: map['id'] as String?,
    );
  }
}
