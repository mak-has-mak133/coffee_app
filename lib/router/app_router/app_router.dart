// lib/main.dart
import 'package:go_router/go_router.dart';

import '../../screen/delivery_screen/map_screen.dart';
import '../../screen/home_screen.dart';
import '../../screen/on_boarding_screen.dart';
import '../../screen/order/order_screen.dart';
import '../../screen/product_screen.dart';

enum AppRoutes {
  onboarding('/onboarding'),
  home('/home'),
  product('/product'),
  order('/order'),
  map('/map');

  final String path;

  const AppRoutes(this.path);
}

// 1. Define the routes
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding.path,
    routes: [
      GoRoute(
        path: AppRoutes.map.path,

        builder: (context, state) => const MapScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home.path,

        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.product.path,

        builder: (context, state) => const ProductScreen(),
      ),
      GoRoute(
        path: AppRoutes.order.path,
        builder: (context, state) => const OrderScreen(),
      ),
    ],
  );
}
