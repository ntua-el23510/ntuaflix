import 'package:flutter/material.dart';

import '../shared/components/default_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppDefaultView(
      canGoBack: false,
      body: Container(),
    );
  }
}
