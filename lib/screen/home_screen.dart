import 'package:coffe_app/components/Shadow_Box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../assets_lib/products/coffee_products.dart';
import '../components/coffee_card.dart';
import '../components/location_search_modal.dart';
import '../data/favorites_manager.dart';
import '../router/app_router/app_router.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoffeeHomeScreen();
  }
}

class CoffeeHomeScreen extends StatefulWidget {
  const CoffeeHomeScreen({super.key});

  @override
  State<CoffeeHomeScreen> createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {
  int selectedCategoryIndex = 0;
  int bottomNavIndex = 0;
  String currentLocation = 'Bilzen, Tanjungbalai';
  final favoritesManager = FavoritesManager();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: favoritesManager.favoriteIds,
        builder: (context, favorites, child) {
          switch (bottomNavIndex) {
            case 1:
              return _buildFavoritesContent(favorites);
            case 2:
              return _buildCartContent();
            case 3:
              return _buildNotificationsContent();
            default:
              return _buildHomeContent(favorites);
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeContent(Set<String> favorites) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ShadowBox(
          height: 280,
          begin: AlignmentGeometry.centerLeft,
          end: AlignmentGeometry.centerRight,
          colors: [AppTheme.homeGradientStart, AppTheme.homeGradientEnd],
          stops: const [0.0, 0.7],
          width: double.infinity,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationHeader(),
                      const SizedBox(height: 24),
                      _buildSearchBar(),
                      const SizedBox(height: 24),
                      _buildPromoBanner(),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 400,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildCategories(),
                      const SizedBox(height: 24),
                      _buildCoffeeGrid(favorites),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesContent(Set<String> favorites) {
    final favoriteProducts = CoffeeProducts.coffeeProducts
        .where((coffee) => favorites.contains(coffee['name']))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Favorites',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: favoriteProducts.isEmpty
                  ? _buildEmptyStateUI(
                      icon: Icons.favorite_border,
                      message: 'No favorites yet',
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final coffee = favoriteProducts[index];
                        return GestureDetector(
                          onTap: () =>
                              context.push(AppRoutes.product.path, extra: coffee),
                          child: CoffeeCard(
                            coffee: coffee,
                            isFavorite: true,
                            onFavoriteToggle: () {
                              favoritesManager.toggleFavorite(coffee['name']);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return _buildEmptyState(
      title: 'Cart',
      message: 'Your cart is empty',
      icon: Icons.shopping_bag_outlined,
    );
  }

  Widget _buildNotificationsContent() {
    return _buildEmptyState(
      title: 'Notifications',
      message: 'No notifications yet',
      icon: Icons.notifications_none,
    );
  }

  Widget _buildEmptyState({
    required String title,
    required String message,
    required IconData icon,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildEmptyStateUI(icon: icon, message: message),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStateUI({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _showLocationPicker(),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                currentLocation,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return LocationSearchModal(
          onLocationSelected: (locationName, latLng) {
            setState(() {
              currentLocation = locationName;
            });
          },
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              decoration: InputDecoration(
                hintText: 'Search coffee',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.tune, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=800&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Promo',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buy one get\none FREE',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 28,
                height: 1.1,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          CoffeeProducts.categories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selectedCategoryIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                CoffeeProducts.categories[index],
                style: TextStyle(
                  color: selectedCategoryIndex == index
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: selectedCategoryIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeGrid(Set<String> favorites) {
    final selectedCategory = CoffeeProducts.categories[selectedCategoryIndex];
    final filteredProducts = CoffeeProducts.coffeeProducts.where((p) {
      final matchesCategory =
          selectedCategory == 'All Coffee' || p['category'] == selectedCategory;
      final matchesSearch = p['name'].toString().toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    if (filteredProducts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: _buildEmptyStateUI(icon: Icons.search_off, message: 'No coffee found'),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final coffee = filteredProducts[index];
        return GestureDetector(
          onTap: () => context.push(AppRoutes.product.path, extra: coffee),
          child: CoffeeCard(
            coffee: coffee,
            isFavorite: favorites.contains(coffee['name']),
            onFavoriteToggle: () {
              favoritesManager.toggleFavorite(coffee['name']);
            },
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home_filled, 0),
          _buildNavItem(Icons.favorite_border, 1),
          _buildNavItem(Icons.shopping_bag_outlined, 2),
          _buildNavItem(Icons.notifications_none, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = bottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          bottomNavIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: 28,
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 5,
              width: 15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }
}
