import 'package:callr/src/views/screens/home_screen.dart';
import 'package:callr/src/views/screens/input_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Enum to define the routes in the app
enum AppRoute {
  splashScreen,
  inputScreen,
  homeScreen,
}


/// Extension on [AppRoute] to get the route path strings
extension AppRouteX on AppRoute {
  String get routePath {
    switch (this) {
      case AppRoute.splashScreen:
        return '/splashScreen';
      case AppRoute.inputScreen:
        return '/inputScreen';
      case AppRoute.homeScreen:
        return '/homeScreen';
    }
  }
}

/// Provider for the [GoRouter] instance
final appRouter = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: AppRoute.inputScreen.routePath, routes: [
    GoRoute(
      name: AppRoute.inputScreen.name,
      path: AppRoute.inputScreen.routePath,
      builder: (context, state) =>  InputScreen(),
    ),
    GoRoute(name: AppRoute.homeScreen.name, path: AppRoute.homeScreen.routePath, builder: (context, state) => const HomeScreen()),
  ]);
});
