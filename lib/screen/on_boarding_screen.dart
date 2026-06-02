import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../assets_lib/images.dart';
import '../components/Shadow_Box.dart';
import '../components/custom_button.dart';
import '../components/on_board_image.dart';
import '../components/on_boarding_content.dart';
import '../router/app_router/app_router.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              /*borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),*/
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Onboardimage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    fit: BoxFit.cover,
                    imagePath: Images.onBordingImage,
                  ),
                  ShadowBox(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface.withAlpha(0),
                      Theme.of(context).colorScheme.surface,
                    ],
                    stops: [0.2, 0.8],
                    width: double.infinity,
                    height: 250,
                  ),
                ],
              ),
            ),

            OnboardingContent(),

            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                onPressed: () {
                  context.go(AppRoutes.home.path);
                },
                text: 'Get Started',
                width: MediaQuery.of(context).size.width * 60,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
