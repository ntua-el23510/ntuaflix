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
  final List<dynamic> toWatchMovies;
  final List<dynamic> viewedMovies;

  set setToken(String newToken) {
    token = newToken;
  }

  /// Constructor that create [User] from JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        ID: json["id"],
        name: json["name"],
        email: json["email"],
        toWatchMovies: List.from(json["to_watch_movies"]),
        viewedMovies: List.from(json["viewed_movies"]));
  }

  /// Function that converts object to JSON object
  Map<String, dynamic> toJson() => {
        'id': ID,
        'name': name,
        'email': email,
        'to_watch_movies': toWatchMovies,
        'viewed_movies': viewedMovies,
        'token': token,
      };
}
