import 'package:flutter/material.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final ValueNotifier<Set<String>> favoriteIds = ValueNotifier<Set<String>>({});

  void toggleFavorite(String coffeeName) {
    final current = Set<String>.from(favoriteIds.value);
    if (current.contains(coffeeName)) {
      current.remove(coffeeName);
    } else {
      current.add(coffeeName);
    }
    favoriteIds.value = current;
  }

  bool isFavorite(String coffeeName) {
    return favoriteIds.value.contains(coffeeName);
  }
}
