import 'dart:convert';

import 'package:ntuaflix/shared/models/principal.dart';

class Person {
  final String nconst;
  final String primaryName;
  final int? birthYear;
  final int? deathYear;
  final String primaryProfession;
  final String knownForTitles;
  final String? imgUrlAsset;
  List<Principal>? principals;

  Person({
    required this.nconst,
    required this.primaryName,
    required this.birthYear,
    required this.deathYear,
    required this.primaryProfession,
    required this.knownForTitles,
    required this.imgUrlAsset,
    required this.principals,
  });

  Person copyWith({
    String? nconst,
    String? primaryName,
    int? birthYear,
    int? deathYear,
    String? primaryProfession,
    String? knownForTitles,
    String? imgUrlAsset,
    List<Principal>? principals,
  }) =>
      Person(
        nconst: nconst ?? this.nconst,
        primaryName: primaryName ?? this.primaryName,
        birthYear: birthYear ?? this.birthYear,
        deathYear: deathYear ?? this.deathYear,
        primaryProfession: primaryProfession ?? this.primaryProfession,
        knownForTitles: knownForTitles ?? this.knownForTitles,
        imgUrlAsset: imgUrlAsset ?? this.imgUrlAsset,
        principals: principals ?? this.principals,
      );

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        nconst: json["nconst"],
        primaryName: json["primaryName"],
        birthYear: json["birthYear"],
        deathYear: json["deathYear"],
        primaryProfession: json["primaryProfession"],
        knownForTitles: json["knownForTitles"],
        principals: json['principals'] != null
            ? List<Principal>.from((json['principals'] as Iterable?)
                    ?.map((model) => Principal.fromMap(model)) ??
                List<Principal>.empty(growable: true))
            : null,
        imgUrlAsset: (json["img_url_asset"] as String?)?.isNotEmpty ?? false
            ? json["img_url_asset"]
            : null,
      );

  Map<String, dynamic> toMap() => {
        "nconst": nconst,
        "primaryName": primaryName,
        "birthYear": birthYear,
        "deathYear": deathYear,
        "primaryProfession": primaryProfession,
        "knownForTitles": knownForTitles,
        "img_url_asset": imgUrlAsset,
      };
}
