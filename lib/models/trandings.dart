// To parse this JSON data, do
//
//     final trending = trendingFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Trending trendingFromMap(String str) => Trending.fromMap(json.decode(str));

String trendingToMap(Trending data) => json.encode(data.toMap());

class Trending {
  Trending({
    @required this.page,
    @required this.results,
    @required this.totalPages,
    @required this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  factory Trending.fromMap(Map<String, dynamic> json) => Trending(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toMap() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  Result({
    @required this.id,
    @required this.overview,
    @required this.releaseDate,
    @required this.adult,
    @required this.backdropPath,
    @required this.voteCount,
    @required this.genreIds,
    @required this.voteAverage,
    @required this.originalLanguage,
    @required this.originalTitle,
    @required this.posterPath,
    @required this.video,
    @required this.title,
    @required this.popularity,
    @required this.mediaType,
    @required this.name,
    @required this.originCountry,
    @required this.firstAirDate,
    @required this.originalName,
  });

  final int id;
  final String overview;
  final DateTime releaseDate;
  final bool adult;
  final String backdropPath;
  final int voteCount;
  final List<int> genreIds;
  final double voteAverage;
  final OriginalLanguage originalLanguage;
  final String originalTitle;
  final String posterPath;
  final bool video;
  final String title;
  final double popularity;
  final MediaType mediaType;
  final String name;
  final List<String> originCountry;
  final DateTime firstAirDate;
  final String originalName;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    overview: json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    voteCount: json["vote_count"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    voteAverage: json["vote_average"].toDouble(),
    originalLanguage: originalLanguageValues.map[json["original_language"]],
    originalTitle: json["original_title"],
    posterPath: json["poster_path"],
    video: json["video"],
    title: json["title"],
    popularity: json["popularity"].toDouble(),
    mediaType: mediaTypeValues.map[json["media_type"]],
    name: json["name"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    originalName: json["original_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "overview": overview,
    "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "adult": adult,
    "backdrop_path": backdropPath,
    "vote_count": voteCount,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "vote_average": voteAverage,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "poster_path": posterPath,
    "video": video,
    "title": title,
    "popularity": popularity,
    "media_type": mediaTypeValues.reverse[mediaType],
    "name": name,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => x)),
    "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "original_name": originalName,
  };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
});

enum OriginalLanguage { EN, SV }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "sv": OriginalLanguage.SV
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
