import 'dart:convert';

import 'package:ntuaflix/shared/models/person.dart';

class Principal {
  final int id;
  final String tconst;
  final int ordering;
  final String nconst;
  final String category;
  final String? job;
  final String? characters;
  final String? imgUrlAsset;
  final Person? person;

  Principal({
    required this.id,
    required this.tconst,
    required this.ordering,
    required this.nconst,
    required this.category,
    required this.job,
    required this.characters,
    required this.imgUrlAsset,
    required this.person,
  });

  Principal copyWith({
    int? id,
    String? tconst,
    int? ordering,
    String? nconst,
    String? category,
    String? job,
    String? characters,
    String? imgUrlAsset,
    Person? person,
  }) =>
      Principal(
        id: id ?? this.id,
        tconst: tconst ?? this.tconst,
        ordering: ordering ?? this.ordering,
        nconst: nconst ?? this.nconst,
        category: category ?? this.category,
        job: job ?? this.job,
        characters: characters ?? this.characters,
        imgUrlAsset: imgUrlAsset ?? this.imgUrlAsset,
        person: person ?? this.person,
      );

  factory Principal.fromJson(String str) => Principal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Principal.fromMap(Map<String, dynamic> json) => Principal(
        id: json["id"],
        tconst: json["tconst"],
        ordering: json["ordering"],
        nconst: json["nconst"],
        category: json["category"],
        job: json["job"],
        characters: json["characters"],
        imgUrlAsset: json["img_url_asset"],
        person: json["person"] != null ? Person.fromMap(json["person"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tconst": tconst,
        "ordering": ordering,
        "nconst": nconst,
        "category": category,
        "job": job,
        "characters": characters,
        "img_url_asset": imgUrlAsset,
        "person": person?.toMap(),
      };
}
