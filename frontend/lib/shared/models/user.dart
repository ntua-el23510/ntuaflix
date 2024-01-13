import 'package:ntuaflix/shared/models/movie.dart';

class User {
  User({
    required this.ID,
    required this.name,
    required this.email,
    required this.toWatchMovies,
    required this.viewedMovies,
  });
  final int ID;
  final String name;
  final String email;
  String? token;
  final List<Movie> toWatchMovies;
  final List<Movie> viewedMovies;

  set setToken(String newToken) {
    token = newToken;
  }

  /// Constructor that create [User] from JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        ID: json["id"],
        name: json["name"],
        email: json["email"],
        toWatchMovies: json["to_watch_movies"] != null
            ? List<Movie>.from((json["to_watch_movies"] as Iterable)
                .map((x) => Movie.fromMap(x)))
            : List<Movie>.empty(growable: true),
        viewedMovies: json["viewed_movies"] != null
            ? List<Movie>.from((json["viewed_movies"] as Iterable)
                .map((x) => Movie.fromMap(x)))
            : List<Movie>.empty(growable: true));
  }

  /// Function that converts object to JSON object
  Map<String, dynamic> toJson() => {
        'id': ID,
        'name': name,
        'email': email,
        'to_watch_movies': null,
        'viewed_movies': null,
        'token': token,
      };
}
