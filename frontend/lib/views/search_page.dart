import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/shared/api_client.dart';
import 'package:ntuaflix/shared/components/default_view.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';
import 'package:ntuaflix/shared/components/movie_tile.dart';
import 'package:ntuaflix/shared/components/person_tile.dart';
import 'package:ntuaflix/shared/extensions/string_extension.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/movie.dart';
import 'package:ntuaflix/shared/models/person.dart';
import 'package:ntuaflix/shared/models/search_results.dart';
import 'package:ntuaflix/views/movie_page.dart';
import 'package:ntuaflix/views/person_page.dart';
import 'package:styled_text/styled_text.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String route = "search";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(milliseconds: 500);

  final searchResults = StreamController<SearchResults>();

  Future<SearchResults> search(String value) async {
    var response =
        await AppAPIClient().client.get("/searchbar?searchPart=$value");
    var data = SearchResults.fromMap((response.data as dynamic), value);
    searchResults.add(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return AppDefaultView(
        displaySearchbox: false,
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: "searchbar",
                    child: AppTextField(
                      autofocus: true,
                      name: "searchbar",
                      label: "Search for films, actors",
                      onChanged: (p0) {
                        if ((p0?.length ?? 0) >= 3) {
                          _debouncer.run(() {
                            search(p0!);
                          });
                        } else {
                          searchResults.add(SearchResults(
                              movies: [], people: [], searchText: ""));
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder<SearchResults>(
                          initialData: SearchResults(
                              movies: [], people: [], searchText: ""),
                          stream: searchResults.stream,
                          builder: (context, snapshot) {
                            List<dynamic> searchResultsList = [
                              ...(snapshot.data?.movies ?? []),
                              ...(snapshot.data?.people ?? [])
                            ];
                            return ListView.builder(
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                var element = searchResultsList[index];

                                return TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      )),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  onPressed: () {
                                    if (element is Movie) {
                                      context.pushNamed(MoviePage.route,
                                          pathParameters: {
                                            'id': element.tconst
                                          },
                                          extra: element);
                                    }
                                    if (element is Person) {
                                      context.pushNamed(PersonPage.route,
                                          pathParameters: {
                                            'id': element.nconst
                                          },
                                          extra: element);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Builder(
                                      builder: (context) {
                                        RegExp pattern = RegExp(
                                            snapshot.data?.searchText ?? '',
                                            caseSensitive: false);
                                        return MovieOrPersonTile(
                                            element: element, pattern: pattern);
                                      },
                                    ),
                                  ),
                                );
                              },
                              itemCount: searchResultsList.length,
                            );
                          }))
                ],
              ),
            ),
          ),
        ));
  }
}

class MovieOrPersonTile extends StatelessWidget {
  const MovieOrPersonTile({
    super.key,
    required this.element,
    required this.pattern,
  });

  final dynamic element;
  final RegExp pattern;

  @override
  Widget build(BuildContext context) {
    String text = element is Movie
        ? (element as Movie).originalTitle
        : (element as Person).primaryName;
    String subtext = (element is Movie
            ? (element as Movie).titleType
            : (element as Person).primaryProfession)
        .split(",")
        .map((e) => e.capitalize())
        .join(", ");
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: element is Movie
              ? MovieTile(
                  movie: element,
                  index: 0,
                  actionEnabled: false,
                )
              : PersonTile(
                  person: element,
                  index: 0,
                  actionEnabled: false,
                ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledText(
                textHeightBehavior: const TextHeightBehavior(),
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: text.replaceAllMapped(
                    pattern,
                    (Match m) =>
                        "<bold>${text.substring(m.start, m.end)}</bold>"),
                style: context.theme.appTypos.title,
                tags: {
                  'bold': StyledTextTag(
                      style: context.theme.appTypos.title
                          .copyWith(color: context.theme.appColors.primary)),
                },
              ),
              Opacity(
                opacity: 0.5,
                child: Text(subtext, style: context.theme.appTypos.body),
              )
            ],
          ),
        )
      ],
    );
  }
}
