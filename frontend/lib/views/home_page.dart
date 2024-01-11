import 'package:flutter/material.dart';
import 'package:ntuaflix/shared/api_client.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/movie.dart';

import '../shared/components/default_view.dart';
import '../shared/components/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Movie>> loadMovies() async {
    var response =
        await AppAPIClient().client.get("/movies/get-started-movies");
    return (response.data["data"] as List<dynamic>)
        .map((e) => Movie.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppDefaultView(
      canGoBack: false,
      body: FutureBuilder(
        future: loadMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: context.theme.appColors.primary,
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: snapshot.data
                            ?.map((e) => MovieTile(
                                  movie: e,
                                  index: snapshot.data!.indexOf(e),
                                ))
                            .toList() ??
                        [],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
