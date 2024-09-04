import 'package:callr/src/controllers/user_contact_controller.dart';
import 'package:callr/src/views/screens/home_screen.dart';
import 'package:callr/src/views/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Enum to define the routes in the app
enum AppRoute {
  splashScreen,
  homeScreen,
}

/// Extension on [AppRoute] to get the route path strings
extension AppRouteX on AppRoute {
  String get routePath {
    switch (this) {
      case AppRoute.splashScreen:
        return '/splashScreen';
      case AppRoute.homeScreen:
        return '/homeScreen';
    }
  }
}

/// Provider for the [GoRouter] instance
final appRouter = Provider<GoRouter>((ref) {
 
  return GoRouter(
    initialLocation: AppRoute.splashScreen.routePath,
    redirect: (context, state) {
       final userContact = ref.watch(userContactController);
      if (userContact.isLoading){
        return AppRoute.splashScreen.routePath;
      } else {
        return AppRoute.homeScreen.routePath;
      }
    },
    routes: [
      GoRoute(
        name: AppRoute.splashScreen.name,
        path: AppRoute.splashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoute.homeScreen.name,
        path: AppRoute.homeScreen.routePath,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
