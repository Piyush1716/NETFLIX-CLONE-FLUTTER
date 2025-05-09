import 'dart:convert';

class SearchModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  SearchModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  SearchModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) => SearchModel(
    page: page ?? this.page,
    results: results ?? this.results,
    totalPages: totalPages ?? this.totalPages,
    totalResults: totalResults ?? this.totalResults,
  );

  factory SearchModel.fromRawJson(String str) =>
      SearchModel.fromJson(json.decode(str));

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

class Result {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String title;
  double voteAverage;
  int voteCount;
  bool? video;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    this.video
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"] ?? json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    title: json["title"] ?? json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    video:  json["video"]
  );
}
