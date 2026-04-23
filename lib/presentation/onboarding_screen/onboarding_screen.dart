import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/custom_image_view.dart';
import './provider/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
      create: (context) => OnboardingProvider(),
      child: OnboardingScreen(),
    );
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {    // Get the total screen height to calculate proportions
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Container(
              // Use minHeight so it takes at least the full screen but can grow if needed
              constraints: BoxConstraints(minHeight: screenHeight),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // 1. THE IMAGE
                      CustomImageView(
                        imagePath: ImageConstant.imgImageCoffee6,
                        // Reduced to 50% height so the cup is much higher up
                        height: screenHeight * 0.50,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // 2. THE GRADIENT OVERLAY
                      // This creates the smooth transition from image to black background
                      Container(
                        height: 100, // Just a fade at the bottom of the image
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 3. THE CONTENT AREA (Now outside the stack to prevent overlap)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
                    color: Colors.black,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Space between the "Image fade" and the text
                        SizedBox(height: 10.h),

                        Text(
                          'Fall in Love with Coffee in Blissful Delight!',
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.instance.headline32SemiBoldSora.copyWith(
                            height: 1.2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.instance.body14RegularSora.copyWith(
                            height: 1.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: 36.h),

                        CustomButton(
                          text: 'Get Started',
                          width: double.infinity,
                          height: 60.h,
                          backgroundColor: appTheme.red_300,
                          textColor: Colors.white,
                          borderRadius: 16.h,
                          fontSize: 18.fSize,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sora',
                          onPressed: () {
                            provider.onGetStartedPressed(context);
                          },
                        ),
                        // Safe area for the bottom of the screen
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
