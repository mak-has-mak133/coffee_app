import 'package:coffe_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrderTabs extends StatefulWidget {
  const OrderTabs({super.key});

  @override
  State<OrderTabs> createState() => _OrderTabsState();
}

class _OrderTabsState extends State<OrderTabs> {
  // 0 for Deliver, 1 for Pick Up
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 43,
      width: double.infinity,
      child: Row(
        children: [
          // --- Deliver Tab ---
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = 0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : AppTheme.productIconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Deliver',
                    style: (selectedIndex == 0
                        ? Theme.of(context).textTheme.headlineMedium!
                        : Theme.of(context).textTheme.bodyMedium!)
                        .copyWith(
                      fontSize: 16,
                      color: selectedIndex == 0
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8), // Optional: small gap between buttons

          // --- Pick Up Tab ---
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = 1),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : AppTheme.productIconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Pick Up',
                    style: (selectedIndex == 1
                        ? Theme.of(context).textTheme.headlineMedium!
                        : Theme.of(context).textTheme.bodyMedium!)
                        .copyWith(
                      color: selectedIndex == 1
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
