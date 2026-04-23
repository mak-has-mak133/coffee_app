import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline32SemiBoldSora => TextStyle(
    fontSize: 32.fSize,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sora',
    color: appTheme.white_A700,
  );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
    fontSize: 20.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14RegularSora => TextStyle(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sora',
    color: appTheme.gray_500,
  );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get textStyle4 => TextStyle();
}
