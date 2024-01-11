import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntuaflix/shared/api_client.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/movie.dart';

import '../shared/components/default_view.dart';

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

class MovieTile extends StatelessWidget {
  final Movie movie;
  final int index;
  const MovieTile({super.key, required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      bool hovered = false;
      return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 5 / 7,
                child: StatefulBuilder(builder: (context, setStateInner) {
                  return Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(5, 5))
                        ],
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: context.theme.appColors.primary, width: 2),
                        image: movie.imgUrlAsset != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(movie.imgUrlAsset!
                                    .replaceAll("{width_variable}", "w500")))
                            : null),
                    child: TextButton(
                      onHover: (value) {
                        setStateInner(
                          () {
                            hovered = value;
                          },
                        );
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          padding:
                              const MaterialStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () {},
                      child: const SizedBox.shrink(),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Icon(
                          Icons.star,
                          size: context.theme.appTypos.body.fontSize,
                          color: context.theme.appColors.primary,
                        ),
                      )),
                  TextSpan(
                      text: " ${movie.rating} / 10",
                      style: context.theme.appTypos.body
                          .copyWith(fontWeight: FontWeight.w200))
                ])),
              ),
              Text(
                movie.originalTitle,
                style: context.theme.appTypos.title,
                textAlign: TextAlign.center,
                maxLines: 2,
              )
            ],
          ),
        ),
      ).animate().fadeIn(delay: 100.ms * index);
    });
  }
}
