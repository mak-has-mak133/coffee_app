import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Jl. Kpg Sutoyo',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 229,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedBookEdit,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 14,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Edit address',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedNote,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 14,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Add Note',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
