import 'dart:convert';

import 'package:ntuaflix/shared/models/movie.dart';
import 'package:ntuaflix/shared/models/person.dart';

class SearchResults {
  final List<Movie> movies;
  final List<Person> people;
  final String searchText;

  SearchResults({
    required this.movies,
    required this.people,
    required this.searchText,
  });

  SearchResults copyWith({
    List<Movie>? movies,
    List<Person>? people,
  }) =>
      SearchResults(
        movies: movies ?? this.movies,
        people: people ?? this.people,
        searchText: searchText ?? this.searchText,
      );

  factory SearchResults.fromJson(String str, String searchText) =>
      SearchResults.fromMap(json.decode(str), searchText);

  factory SearchResults.fromMap(Map<String, dynamic> json, String searchText) =>
      SearchResults(
        searchText: searchText,
        movies: List<Movie>.from(
            (json["movies"] as Iterable).map((x) => Movie.fromMap(x))),
        people: List<Person>.from(
            (json["people"] as Iterable).map((x) => Person.fromMap(x))),
      );
}
