import 'package:coffe_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OrderTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const OrderTabs({
    super.key, 
    this.selectedIndex = 0, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.productIconBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // --- Deliver Tab ---
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
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
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- Pick Up Tab ---
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(1),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Pick Up',
                    style: (selectedIndex == 1
                        ? Theme.of(context).textTheme.headlineMedium!
                        : Theme.of(context).textTheme.bodyMedium!)
                        .copyWith(
                      color: selectedIndex == 1
                          ? Colors.white
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
