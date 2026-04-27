// lib/main.dart
import 'package:go_router/go_router.dart';

import '../../screen/home_screen.dart';
import '../../screen/on_boarding_screen.dart';
enum AppRoutes {
  onboarding('/onboarding'),
  home('/home');
final String path;
const AppRoutes(this.path);
}

// 1. Define the routes
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding.path,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

}
