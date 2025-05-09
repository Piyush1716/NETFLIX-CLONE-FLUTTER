import 'dart:convert';

class TvSeriesModel {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    TvSeriesModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    TvSeriesModel copyWith({
        int? page,
        List<Result>? results,
        int? totalPages,
        int? totalResults,
    }) => 
        TvSeriesModel(
            page: page ?? this.page,
            results: results ?? this.results,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory TvSeriesModel.fromRawJson(String str) => TvSeriesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
      return  TvSeriesModel(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );}

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Result {
    bool adult;
    String backdropPath;
    int id;
    String originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String posterPath;
    String name;
    double voteAverage;
    int voteCount;

    Result({
        required this.adult,
        required this.backdropPath,
        required this.id,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.name,
        required this.voteAverage,
        required this.voteCount,
    });

    Result copyWith({
        bool? adult,
        String? backdropPath,
        int? id,
        String? originalLanguage,
        String? originalName,
        String? overview,
        double? popularity,
        String? posterPath,
        String? name,
        double? voteAverage,
        int? voteCount,
    }) => 
        Result(
            adult: adult ?? this.adult,
            backdropPath: backdropPath ?? this.backdropPath,
            id: id ?? this.id,
            originalLanguage: originalLanguage ?? this.originalLanguage,
            originalName: originalName ?? this.originalName,
            overview: overview ?? this.overview,
            popularity: popularity ?? this.popularity,
            posterPath: posterPath ?? this.posterPath,
            name: name ?? this.name,
            voteAverage: voteAverage ?? this.voteAverage,
            voteCount: voteCount ?? this.voteCount,
        );

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) {
      return 
      Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );}

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}