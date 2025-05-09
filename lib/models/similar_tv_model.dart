import 'dart:convert';

class SimilarTvModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  SimilarTvModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  SimilarTvModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) => SimilarTvModel(
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  factory SimilarTvModel.fromRawJson(String str) =>
      SimilarTvModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SimilarTvModel.fromJson(Map<String, dynamic> json) => SimilarTvModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  String backdropPath;
  int id;
  String name;
  String originalName;
  String overview;
  String posterPath;
  String mediaType;
  bool adult;
  String originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime firstAirDate;
  double voteAverage;
  int voteCount;
  List<String> originCountry;

  Result({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  Result copyWith({
    String? backdropPath,
    int? id,
    String? name,
    String? originalName,
    String? overview,
    String? posterPath,
    String? mediaType,
    bool? adult,
    String? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
  }) => Result(
    backdropPath: backdropPath ?? this.backdropPath,
    id: id ?? this.id,
    name: name ?? this.name,
    originalName: originalName ?? this.originalName,
    overview: overview ?? this.overview,
    posterPath: posterPath ?? this.posterPath,
    mediaType: mediaType ?? this.mediaType,
    adult: adult ?? this.adult,
    originalLanguage: originalLanguage ?? this.originalLanguage,
    genreIds: genreIds ?? this.genreIds,
    popularity: popularity ?? this.popularity,
    firstAirDate: firstAirDate ?? this.firstAirDate,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
    originCountry: originCountry ?? this.originCountry,
  );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"],
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"],
    adult: json["adult"],
    originalLanguage: json["original_language"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    firstAirDate: DateTime.parse(json["first_air_date"]),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "id": id,
    "name": name,
    "original_name": originalName,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaType,
    "adult": adult,
    "original_language": originalLanguage,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "first_air_date":
        "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
  };
}
