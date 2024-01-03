import 'package:flutter/material.dart';
import 'package:ntuaflix/shared/components/default_view.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String route = "search";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const AppDefaultView(
        displaySearchbox: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "searchbar",
                child: AppTextField(
                  autofocus: true,
                  name: "searchbar",
                  label: "Search for films, actors",
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
