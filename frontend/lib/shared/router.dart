import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ntuaflix/shared/blocs/auth/auth_bloc.dart';
import 'package:ntuaflix/shared/extensions/read_or_null_extension.dart';
import 'package:ntuaflix/shared/models/movie.dart';
import 'package:ntuaflix/shared/models/person.dart';
import 'package:ntuaflix/views/search_page.dart';
import 'package:ntuaflix/views/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/views/login_page.dart';
import 'package:ntuaflix/views/movie_page.dart';
import 'package:ntuaflix/views/person_page.dart';

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

            /// Movies
            GoRoute(
                path: MoviePage.route,
                name: MoviePage.route,
                pageBuilder: (context, state) {
                  var movie = state.extra as Movie?;
                  var pId = state.pathParameters['id'];
                  if (pId == null) {
                    return fadeTransition(state, const HomePage());
                  }
                  return fadeTransition(
                      state,
                      MoviePage(
                        movieId: pId,
                        movie: movie,
                      ));
                }),

            /// Persons
            GoRoute(
                path: PersonPage.route,
                name: PersonPage.route,
                pageBuilder: (context, state) {
                  var person = state.extra as Person?;
                  var pId = state.pathParameters['id'];
                  if (pId == null) {
                    return fadeTransition(state, const HomePage());
                  }
                  return fadeTransition(
                      state,
                      PersonPage(
                        personId: pId,
                        person: person,
                      ));
                }),
          ]),

      /// Login
      GoRoute(
          path: LoginPage.route,
          name: LoginPage.route,
          redirect: (context, state) {
            if (context.readOrNull<AuthBloc>()?.state.runtimeType !=
                Unauthorized) {
              return HomePage.route;
            }
            return null;
          },
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
