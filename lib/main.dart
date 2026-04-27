import 'package:coffe_app/assets_lib/images.dart';
import 'package:coffe_app/components/Shadow_Box.dart';
import 'package:coffe_app/router/app_router/app_router.dart';
import 'package:coffe_app/screen/home_screen.dart';
import 'package:coffe_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'components/custom_button.dart';
import 'components/on_board_image.dart';
import 'components/on_boarding_content.dart';

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
