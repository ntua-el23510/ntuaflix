import 'dart:convert';

class Movie {
  String tconst;
  String titleType;
  String primaryTitle;
  String originalTitle;
  bool isAdult;
  int startYear;
  int? runtimeMinutes;
  String? genres;
  String? imgUrlAsset;
  double? rating;

  Movie({
    required this.tconst,
    required this.titleType,
    required this.primaryTitle,
    required this.originalTitle,
    required this.isAdult,
    required this.startYear,
    required this.runtimeMinutes,
    required this.genres,
    required this.imgUrlAsset,
    required this.rating,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        tconst: json["tconst"],
        titleType: json["titleType"],
        primaryTitle: json["primaryTitle"],
        originalTitle: json["originalTitle"],
        isAdult: json["isAdult"] == 1,
        startYear: json["startYear"],
        runtimeMinutes: json["runtimeMinutes"],
        genres: json["genres"],
        imgUrlAsset: json["img_url_asset"],
        rating: double.tryParse(json["rating"]["averageRating"]),
      );
}
