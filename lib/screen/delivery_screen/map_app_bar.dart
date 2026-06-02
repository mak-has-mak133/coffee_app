import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          IconButton.outlined(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Spacer(),
          IconButton.outlined(
            onPressed: () {},
            icon: Icon(
              Icons.location_searching,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
