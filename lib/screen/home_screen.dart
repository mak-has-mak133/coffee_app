import 'package:coffe_app/components/Shadow_Box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../assets_lib/products/coffee_products.dart';
import '../components/coffee_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          ShadowBox(
            height: 280,
            // Give it a clear boundary
            begin: AlignmentGeometry.centerLeft,
            end: AlignmentGeometry.centerRight,
            colors: [AppTheme.homeGradientStart, AppTheme.homeGradientEnd],
            stops: [0.0, 0.7],
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
                        // THE BANNER
                        _buildPromoBanner(),
                      ],
                    ),
                  ),

                  // Add a Spacer here so the categories start after the banner
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        _buildCategories(),
                        const SizedBox(height: 24),
                        _buildCoffeeGrid(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                'Bilzen, Tanjungbalai',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: 4),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Location',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      // You can add more location selection UI here
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            /*decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),*/
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Search coffee',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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
      child: Stack(
        children: [
          // Dark overlay to make text readable
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildCoffeeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68, // Adjust the aspect ratio as needed
      ),
      itemCount: CoffeeProducts.coffeeProducts.length,
      itemBuilder: (context, index) {
        final coffee = CoffeeProducts.coffeeProducts[index];
        return GestureDetector(
          onTap: () => context.push(AppRoutes.product.path),
          child: CoffeeCard(coffee: CoffeeProducts.coffeeProducts[index]),
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
            color: Colors.grey.withOpacity(0.1),
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
        context.go(AppRoutes.onboarding.path);
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
