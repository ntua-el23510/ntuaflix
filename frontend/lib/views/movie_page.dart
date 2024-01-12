import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ntuaflix/shared/api_client.dart';
import 'package:ntuaflix/shared/blocs/auth/auth_bloc.dart';
import 'package:ntuaflix/shared/components/default_view.dart';
import 'package:ntuaflix/shared/components/movie_tile.dart';
import 'package:ntuaflix/shared/components/person_tile.dart';
import 'package:ntuaflix/shared/models/user.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/movie.dart';

import '../shared/components/category_divider.dart';
import 'table.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
    this.movie,
    required this.movieId,
  });
  static const String route = "movie/:id";
  final String movieId;
  final Movie? movie;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future<Movie> loadMovie() async {
    if (_detailedMovie != null) return _detailedMovie!;
    var response = await AppAPIClient().client.get("/movies/${widget.movieId}");
    Movie movie = Movie.fromMap((response.data["data"] as dynamic));
    _detailedMovie = movie;
    return movie;
  }

  // Calculate dominant color from ImageProvider
  Future<Color?> getImagePalette(ImageProvider? imageProvider) async {
    if (imageProvider == null) return context.theme.appColors.secondary;
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    var vibrant = paletteGenerator.vibrantColor?.color;
    var dominant = paletteGenerator.dominantColor?.color;
    if (vibrant != null && dominant != null) {
      if (vibrant.computeLuminance() > dominant.computeLuminance()) {
        return vibrant;
      } else {
        return dominant;
      }
    }
    return vibrant ?? dominant;
  }

  Movie? _detailedMovie;

  @override
  Widget build(BuildContext context) {
    return AppDefaultView(
        body: FutureBuilder(
      future: loadMovie(),
      builder: (context, snapshot) {
        var movie = (_detailedMovie ?? widget.movie ?? snapshot.data);
        if (movie == null) {
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
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getImagePalette(movie.imgUrlAsset != null
                            ? NetworkImage(movie.imgUrlAsset!
                                .replaceAll("{width_variable}", "w500"))
                            : null),
                        builder: (context, color) {
                          if (color.data == null) {
                            return const SizedBox(
                              height: 100,
                            );
                          }
                          return Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 200,
                                      blurRadius: 200,
                                      color: color.data!,
                                      offset: const Offset(0, -80))
                                ],
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(300),
                                    bottomRight: Radius.circular(300))),
                          )
                              .animate()
                              .slideY(begin: -2, duration: 2000.ms)
                              .fadeIn(duration: 3000.ms, curve: Curves.easeOut);
                        }),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MovieTile(
                          movie: widget.movie ?? snapshot.data!,
                          index: 0,
                          actionEnabled: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.originalTitle,
                                  style: context.theme.appTypos.title.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                )
                                    .animate()
                                    .fadeIn(duration: 500.ms, delay: 100.ms)
                                    .slideY(
                                        delay: 100.ms,
                                        begin: -5,
                                        duration: 400.ms,
                                        curve: Curves.easeOutBack),
                                Builder(builder: (context) {
                                  var rating = movie.rating ?? 0.0;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Transform.translate(
                                          offset: const Offset(0, 1),
                                          child: Text(
                                            rating.toStringAsFixed(1),
                                            style: context.theme.appTypos.body,
                                          )
                                              .animate()
                                              .fadeIn(
                                                  duration: 500.ms,
                                                  delay: 200.ms)
                                              .slideY(
                                                  delay: 200.ms,
                                                  begin: 2,
                                                  duration: 500.ms,
                                                  curve: Curves.easeOutBack),
                                        ),
                                      ),
                                      Flexible(
                                        child: RatingBarIndicator(
                                            rating: rating,
                                            itemSize: 30,
                                            unratedColor: context
                                                .theme.appColors.primary
                                                .withOpacity(0.3),
                                            itemCount: 10,
                                            itemBuilder: (context, index) =>
                                                Wrap(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: context.theme
                                                          .appColors.primary,
                                                    )
                                                        .animate()
                                                        .fadeIn(
                                                            duration: 500.ms,
                                                            delay: (200 +
                                                                    index * 50)
                                                                .ms)
                                                        .slideY(
                                                            delay: (200 +
                                                                    index * 50)
                                                                .ms,
                                                            begin: 2,
                                                            duration: 500.ms,
                                                            curve: Curves
                                                                .easeOutBack),
                                                  ],
                                                )),
                                      ),
                                    ],
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Table(
                                    columnWidths: const {
                                      0: IntrinsicColumnWidth(),
                                      1: IntrinsicColumnWidth(),
                                    },
                                    children: [
                                      TableRow(children: [
                                        const TableTitle(
                                          title: "Genres",
                                          index: 0,
                                        ),
                                        TableBody(
                                          text: (movie.genres ?? "-")
                                              .replaceAll(",", ", "),
                                          index: 0,
                                        )
                                      ]),
                                      TableRow(children: [
                                        const TableTitle(
                                          title: "Year",
                                          index: 1,
                                        ),
                                        TableBody(
                                          text: movie.startYear.toString(),
                                          index: 1,
                                        )
                                      ]),
                                      TableRow(children: [
                                        const TableTitle(
                                          title: "Duration",
                                          index: 2,
                                        ),
                                        TableBody(
                                          text: movie.runtimeMinutes != null
                                              ? "${movie.runtimeMinutes} min"
                                              : "-",
                                          index: 2,
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is Authorized) {
                                      bool watched = state.user?.viewedMovies
                                              .map((e) => e.tconst)
                                              .contains(movie.tconst) ??
                                          false;
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: 300),
                                          child: TextButton(
                                              onPressed: () async {
                                                var response = await AppAPIClient()
                                                    .client
                                                    .put(
                                                        "/user/assign-movie-status",
                                                        data: {
                                                      "movie_id": movie.tconst,
                                                      "status": watched
                                                          ? "to_watch"
                                                          : "viewed"
                                                    });

                                                context.read<AuthBloc>().add(
                                                    UpdateUser(
                                                        user: User.fromJson(
                                                            response.data[
                                                                "data"])));
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    watched
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_outline,
                                                    color: context.theme
                                                        .appColors.primary,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    watched
                                                        ? "Remove from favorites"
                                                        : "Add to favorites",
                                                    style: context
                                                        .theme.appTypos.body,
                                                  )
                                                ],
                                              )),
                                        ),
                                      )
                                          .animate()
                                          .fadeIn(
                                              duration: 500.ms, delay: 200.ms)
                                          .slideY(
                                              delay: 200.ms,
                                              begin: 2,
                                              duration: 400.ms,
                                              curve: Curves.easeOutBack);
                                    }
                                    return const SizedBox.shrink();
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const CategoryDivider(text: "Description")
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 500.ms),
                    Text(
                      descriptions[Random().nextInt(descriptions.length)],
                      textAlign: TextAlign.justify,
                    ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
                    const CategoryDivider(text: "Starring")
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 900.ms),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: movie.principals
                              ?.map((e) => PersonTile(
                                    person: e.person!,
                                    index: movie.principals!.indexOf(e),
                                  ))
                              .toList() ??
                          [],
                    ).animate().fadeIn(duration: 500.ms, delay: 1100.ms)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}

List<String> descriptions = [
  "In a world where night lasts forever, a group of dedicated scientists embarks on an unprecedented journey into the mystical unknown. Deep within the obsidian expanse, they chance upon enigmatic luminous artifacts, pulsating with an otherworldly energy. As the scientists delve into daring experiments to harness the power within, they unveil not only astonishing possibilities but also unanticipated dangers. The delicate equilibrium between perpetual darkness and fleeting light is at stake, and they must navigate the treacherous path between discovery and catastrophe.",
  "Amidst the hushed corridors of a therapeutic haven, a seasoned psychologist takes on the enigmatic case of a patient shrouded in the nebulous recesses of the human psyche. As the therapist unravels the tightly woven threads of suppressed traumas, he unwittingly becomes entangled in the labyrinth of his own unresolved demons. The demarcation separating reality and the realm of nightmares begins to blur, pushing both healer and patient to the brink of an unsettling revelation that challenges the very fabric of their existence.",
  "The bustling cityscape beckons a young artist from the tranquil provinces, lured by the promise of realizing artistic dreams. However, the city's vibrant exterior conceals a clandestine world of forgery, betrayal, and illicit dealings. Caught in the crossfire of loyalty and personal conscience, the artist must navigate the murky waters of urban ambition, where every stroke on the canvas could either lead to fame or plunge them into the abyss of moral compromise.",
  "In the aftermath of a cataclysmic global event that reduced civilization to smoldering ruins, the last bastion of humanity teeters on the brink of extinction. A disparate group of heroes emerges, drawn together by a shared determination to traverse the desolate wasteland in search of a fabled oasis of hope. Their perilous journey becomes a race against time as the final ember of life threatens to flicker out, and the destiny of humanity hangs in the balance.",
  "In a meticulously engineered world dictated by algorithms, the quest for true love becomes an unconventional dance. Two souls navigate the labyrinth of computerized dating programs, where the binary confines of algorithms yield to the unpredictable nuances of human connection. Their encounter unfolds in a cascade of amusing situations, unraveling the paradox that, in matters of the heart, the most intricate equations are often overshadowed by the simplicity of genuine emotion.",
  "In a realm where magical beings coexist with humans, a young orphan discovers a hidden prophecy that foretells the rise of an ancient evil. With an unlikely group of allies, they embark on an epic quest to save their world from impending darkness. As they journey through enchanted realms and face mythical creatures, the orphan realizes their own pivotal role in shaping the destiny of the magical world.",
  "In a dystopian metropolis ruled by corruption, a jaded detective stumbles upon a series of unsolved murders connected to a clandestine conspiracy. As he delves deeper, the detective unravels a web of deceit that threatens to shatter the city's fragile facade. With danger lurking in every shadowy alley, the detective must navigate the treacherous landscape of deception and betrayal to expose the truth and bring justice to a city drowning in its own darkness.",
  "Set in a future where virtual reality dominates, a skilled hacker named Cipher discovers a digital world harboring a dangerous secret. Pursued by both powerful corporations hungry for control and rogue agents with their own agendas, Cipher must navigate the virtual landscape with unparalleled skill and cunning. As the lines between the real and virtual blur, Cipher unveils a conspiracy that not only challenges the fabric of reality but also poses a threat to the very essence of human existence.",
  "Against the backdrop of an ancient archaeological site, an intrepid archaeologist uncovers a forgotten civilization with a mysterious past. As they meticulously decode ancient texts and unearth artifacts, the archaeologist becomes entangled in a race against time. With rival factions seeking to exploit the ancient knowledge for power, the archaeologist must navigate a web of intrigue and danger to preserve the secrets of a lost era and prevent the imminent threat that could reshape the course of history.",
  "A person awakens to a world devoid of memories, only to discover they are a pawn in an elaborate identity theft scheme. With law enforcement on their tail and criminal masterminds closing in, the person must piece together fragments of their past. As they navigate a web of deceit and betrayal, the truth slowly unravels. The journey to reclaim their identity becomes a harrowing odyssey, with each revelation bringing them closer to the heart of a conspiracy that threatens not just their life, but the very fabric of trust and reality itself."
];
