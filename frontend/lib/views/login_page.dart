import 'package:flutter/material.dart';
import 'package:ntuaflix/shared/components/default_view.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const AppDefaultView(
        canGoBack: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ));
  }
}
