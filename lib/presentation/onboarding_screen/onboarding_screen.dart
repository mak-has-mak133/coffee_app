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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray_50,
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 768.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: appTheme.white_A700),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgImageCoffee6,
                        height: 492.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x05050505), appTheme.black_900],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    padding: EdgeInsets.all(24.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 26.h),
                        Text(
                          'Fall in Love with Coffee in Blissful Delight!',
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.instance.headline32SemiBoldSora
                              .copyWith(height: 1.5),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                          textAlign: TextAlign.center,
                          style: TextStyleHelper.instance.body14RegularSora
                              .copyWith(height: 1.5),
                        ),
                        SizedBox(height: 30.h),
                        CustomButton(
                          text: 'Get Started',
                          width: double.infinity,
                          height: 53.h,
                          backgroundColor: appTheme.red_300,
                          textColor: appTheme.white_A700,
                          borderRadius: 16.h,
                          fontSize: 16.fSize,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sora',
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 30.h,
                          ),
                          onPressed: () {
                            provider.onGetStartedPressed(context);
                          },
                        ),
                        SizedBox(height: 26.h),
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
