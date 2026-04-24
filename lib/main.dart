import 'package:coffe_app/assets_lib/images.dart';
import 'package:coffe_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'components/custom_button.dart';
import 'components/on_board_image.dart';
import 'components/on_boarding_content.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.appDarkTheme,
      themeMode: ThemeMode.dark,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              // Qn1.what did you mean by  anchors the dark gradient to the bottom of the image.?
              alignment: Alignment.bottomCenter,
              children: [
                /*Image.asset(
                  Images.onBordingImage,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.cover,
                )*/
                Onboardimage(
                    width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit:BoxFit.cover ,
                  imagePath: Images.onBordingImage,
              )
              ,
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: AppTheme.onboardingFadeDecoration,
                ),
              ],
            ),

               OnboardingContent(),

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: /*ElevatedButton(
                      onPressed: () {},
                      child: const Text('Get Started'),
                    )*/
                    CustomButton(
                      onPressed: () {},
                      text: ('Get Started'),

                    )
                    ,
                  ),
                ],
              ),
            ),
    );
  }
}
