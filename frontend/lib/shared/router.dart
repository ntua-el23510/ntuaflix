import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ntuaflix/views/details_page.dart';
import 'package:ntuaflix/views/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/views/login_page.dart';

/// Global keys for different [Navigator]s in widget stack
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Provider of routing
class AppRouter {
  var builded = false;
  String location = "";
  final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
    initialLocation: HomePage.route,
    routes: [
      /// Home page
      GoRoute(
          path: HomePage.route,
          name: HomePage.route,
          pageBuilder: (context, state) {
            return fadeTransition(state, const HomePage());
          },
          routes: [
            /// Search
            GoRoute(
                path: SearchPage.route,
                name: SearchPage.route,
                pageBuilder: (context, state) {
                  return fadeTransition(state, const SearchPage());
                }),
          ]),

      /// Login
      GoRoute(
          path: LoginPage.route,
          name: LoginPage.route,
          pageBuilder: (context, state) {
            return fadeTransition(state, const LoginPage());
          }),
      // /// Routes available for ex. logged user
      // ShellRoute(
      //   navigatorKey: shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return child;
      //   },
      //   routes: [
      //   ],
      // ),
    ],
  );
}

/// Universal animation for changing views with [FadeTransition]
CustomTransitionPage fadeTransition(GoRouterState state, Widget page) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

/// Universal animation for subroute views with [FadeTransition]
CustomTransitionPage slideTransition(GoRouterState state, Widget page) {
  return CustomTransitionPage<void>(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          ));
}
