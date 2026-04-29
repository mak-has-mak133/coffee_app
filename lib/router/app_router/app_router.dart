// lib/main.dart
import 'package:go_router/go_router.dart';

import '../../screen/home_screen.dart';
import '../../screen/on_boarding_screen.dart';
import '../../screen/product_screen.dart';
enum AppRoutes {
  onboarding('/onboarding'),
  home('/home'),
  product('/product');
final String path;
const AppRoutes(this.path);
}

// 1. Define the routes
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.product.path,
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
      GoRoute(
        path: AppRoutes.product.path,
        name: AppRoutes.product.name,
        builder: (context, state) => const ProductScreen(),
      ),
    ],
  );

}
