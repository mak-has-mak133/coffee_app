import 'package:coffe_app/router/app_router/app_router.dart';
import 'package:coffe_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      darkTheme: AppTheme.appDarkTheme,
      themeMode: ThemeMode.dark,
    ),
  );
}

//AIzaSyDJeuyB95W1Ndk9uX4u615MEBNhCyxU6OM
