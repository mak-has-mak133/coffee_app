import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class ProgressBarSection extends StatelessWidget {
  const ProgressBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 30,
            thickness: 5,
            color: AppTheme.progressBarColor,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Divider(
            height: 30,
            thickness: 5,
            color: AppTheme.progressBarColor,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Divider(
            height: 30,
            thickness: 5,
            color: AppTheme.progressBarColor,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Divider(
            height: 30,
            thickness: 5,
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}
