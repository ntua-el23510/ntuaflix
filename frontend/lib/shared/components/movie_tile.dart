import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/movie.dart';
import 'package:ntuaflix/views/movie_page.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final int index;
  final bool actionEnabled;
  const MovieTile(
      {super.key,
      required this.movie,
      required this.index,
      this.actionEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: actionEnabled ? 160 : 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 5 / 7,
                child: Hero(
                  tag: "movie:${movie.tconst}",
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 50,
                              spreadRadius: 10,
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
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/placeholder.png"))),
                    child: actionEnabled
                        ? TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.zero)),
                            onPressed: () {
                              context.goNamed(MoviePage.route,
                                  pathParameters: {'id': movie.tconst},
                                  extra: movie);
                            },
                            child: const SizedBox.shrink(),
                          )
                        : null,
                  ),
                ),
              ),
              if (actionEnabled) ...[
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
                Material(
                  type: MaterialType.transparency,
                  child: Text(
                    movie.originalTitle,
                    style: context.theme.appTypos.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                )
              ]
            ],
          ),
        ),
      ).animate().fadeIn(delay: 100.ms * index);
    });
  }
}
