import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class OnboardingProvider extends ChangeNotifier {
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  void initialize() {
    // Initialize any required data or animations
    isLoading = false;
    notifyListeners();
  }

  void onGetStartedPressed(BuildContext context) {
    try {
      isLoading = true;
      notifyListeners();

      // Show loading state briefly for better UX
      Future.delayed(Duration(milliseconds: 300), () {
        isLoading = false;
        notifyListeners();

        // Navigate to the main screen or home screen
        // Since no specific route is provided, we'll show a snackbar for now
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome to Coffee Delight! Let\'s start your coffee journey.',
            ),
            backgroundColor: appTheme.red_300,
            duration: Duration(seconds: 2),
          ),
        );
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong. Please try again.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
  }
}
