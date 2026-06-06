import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../assets_lib/images.dart';
import '../data/favorites_manager.dart';
import '../router/app_router/app_router.dart';
import '../theme/app_theme.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic>? coffee;
  const ProductScreen({super.key, this.coffee});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSize = 'M';
  final favoritesManager = FavoritesManager();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final coffee = widget.coffee ?? {
      'name': 'Caffe Mocha',
      'subtitle': 'Ice/Hot',
      'rating': 4.8,
      'reviews': 230,
      'price': 4.53,
      'image': Images.productImage,
    };

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Column(
              children: [
                // HEADER
                SizedBox(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Detail',
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 16,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      ValueListenableBuilder<Set<String>>(
                        valueListenable: favoritesManager.favoriteIds,
                        builder: (context, favorites, child) {
                          final isLiked = favorites.contains(coffee['name']);
                          return IconButton(
                            onPressed: () {
                              favoritesManager.toggleFavorite(coffee['name']);
                            },
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked 
                                  ? Theme.of(context).colorScheme.primary 
                                  : colorScheme.onSurface,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // PRODUCT IMAGE
                Container(
                  height: 202,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: coffee['image'] is String && (coffee['image'] as String).startsWith('http') 
                        ? NetworkImage(coffee['image']) 
                        : AssetImage(coffee['image'] ?? Images.productImage) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 15),
                // TITLE & RATING SECTION
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee['name'],
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  fontSize: 20,
                                  color: colorScheme.onSurface,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            coffee['subtitle'],
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${coffee['rating']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: colorScheme.onSurface,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${coffee['reviews'] ?? 230})',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      // ICONS SECTION
                      Row(
                        children: [
                          _buildServiceIcon(
                            HugeIcons.strokeRoundedDeliveredSent,
                          ),
                          const SizedBox(width: 12),
                          _buildServiceIcon(HugeIcons.strokeRoundedCoffee01),
                          const SizedBox(width: 12),
                          _buildServiceIcon(HugeIcons.strokeRoundedMotorbike01),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  height: 40,
                  thickness: 1,
                ),
                // DESCRIPTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontSize: 16, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                          TextSpan(
                            text: ' Read More',
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  color: colorScheme.primary,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // SIZES SECTION
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontSize: 16, color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSizeOption('S'),
                        _buildSizeOption('M'),
                        _buildSizeOption('L'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      // BOTTOM BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: 110,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '\$ ${coffee['price']}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 18,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 217,
              height: 62,
              child: ElevatedButton(
                onPressed: () => context.push(AppRoutes.order.path),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceIcon(List<List<dynamic>> icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: AppTheme.productIconBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: HugeIcon(
          color: Theme.of(context).colorScheme.primary,
          size: 20,
          icon: icon,
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = selectedSize == size;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        height: 41,
        width: 96,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.05)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colorScheme.primary : AppTheme.sizeBoarderColor,
            width: 1,
          ),
        ),
        child: Text(
          size,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: 14,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
