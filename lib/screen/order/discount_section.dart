import 'package:flutter/material.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
        ),
      ),
      padding: EdgeInsets.all(4),
      height: 56,
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            Icons.discount,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            '1 Discount is Applies',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
