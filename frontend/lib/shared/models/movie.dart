import 'dart:convert';

import 'package:ntuaflix/shared/models/principal.dart';

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
  List<Principal>? principals;

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
    required this.principals,
  });

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        tconst: json["tconst"],
        titleType: json["titleType"],
        primaryTitle: json["primaryTitle"],
        originalTitle: json["originalTitle"],
        isAdult: json["isAdult"] == 1,
        startYear: json["startYear"],
        runtimeMinutes: json["runtimeMinutes"],
        genres: json["genres"],
        imgUrlAsset: json["img_url_asset"],
        principals: json['principals'] != null
            ? List<Principal>.from((json['principals'] as Iterable?)
                    ?.map((model) => Principal.fromMap(model)) ??
                List<Principal>.empty(growable: true))
            : null,
        rating:
            json["rating"] != null && json["rating"]["averageRating"] != null
                ? double.tryParse(json["rating"]["averageRating"])
                : null,
      );
}
