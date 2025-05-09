import 'dart:convert';

class TvSeasonModel {
  String id;
  DateTime airDate;
  List<Episode> episodes;
  String name;
  String overview;
  int tvSeasonModelId;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  TvSeasonModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.tvSeasonModelId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  TvSeasonModel copyWith({
    String? id,
    DateTime? airDate,
    List<Episode>? episodes,
    String? name,
    String? overview,
    int? tvSeasonModelId,
    String? posterPath,
    int? seasonNumber,
    double? voteAverage,
  }) => TvSeasonModel(
    id: id ?? this.id,
    airDate: airDate ?? this.airDate,
    episodes: episodes ?? this.episodes,
    name: name ?? this.name,
    overview: overview ?? this.overview,
    tvSeasonModelId: tvSeasonModelId ?? this.tvSeasonModelId,
    posterPath: posterPath ?? this.posterPath,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    voteAverage: voteAverage ?? this.voteAverage,
  );

  factory TvSeasonModel.fromRawJson(String str) =>
      TvSeasonModel.fromJson(json.decode(str));

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
    id: json["_id"],
    airDate: DateTime.parse(json["air_date"]),
    episodes: List<Episode>.from(
      json["episodes"].map((x) => Episode.fromJson(x)),
    ),
    name: json["name"],
    overview: json["overview"],
    tvSeasonModelId: json["id"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    voteAverage: json["vote_average"]?.toDouble(),
  );

}

class Episode {
  DateTime airDate;
  int episodeNumber;
  String episodeType;
  int id;
  String name;
  String overview;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Episode copyWith({
    DateTime? airDate,
    int? episodeNumber,
    String? episodeType,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? runtime,
    int? seasonNumber,
    int? showId,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
  }) => Episode(
    airDate: airDate ?? this.airDate,
    episodeNumber: episodeNumber ?? this.episodeNumber,
    episodeType: episodeType ?? this.episodeType,
    id: id ?? this.id,
    name: name ?? this.name,
    overview: overview ?? this.overview,
    productionCode: productionCode ?? this.productionCode,
    runtime: runtime ?? this.runtime,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    showId: showId ?? this.showId,
    stillPath: stillPath ?? this.stillPath,
    voteAverage: voteAverage ?? this.voteAverage,
    voteCount: voteCount ?? this.voteCount,
  );

  factory Episode.fromRawJson(String str) => Episode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    airDate: DateTime.parse(json["air_date"]),
    episodeNumber: json["episode_number"],
    episodeType: json["episode_type"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    productionCode: json["production_code"],
    runtime: json["runtime"],
    seasonNumber: json["season_number"],
    showId: json["show_id"],
    stillPath: json["still_path"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "air_date":
        "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
    "episode_number": episodeNumber,
    "episode_type": episodeType,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "runtime": runtime,
    "season_number": seasonNumber,
    "show_id": showId,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
