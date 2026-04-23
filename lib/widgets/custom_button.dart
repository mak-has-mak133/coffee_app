import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    required this.width,
    this.height,
    this.padding,
    this.margin,
  });

  /// Text displayed on the button
  final String? text;

  /// Callback function executed when button is pressed
  final VoidCallback? onPressed;

  /// Background color of the button
  final Color? backgroundColor;

  /// Text color of the button
  final Color? textColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Font size of the button text
  final double? fontSize;

  /// Font weight of the button text
  final FontWeight? fontWeight;

  /// Font family for the button text
  final String? fontFamily;

  /// Width of the button (required)
  final double width;

  /// Height of the button
  final double? height;

  /// Internal padding of the button content
  final EdgeInsetsGeometry? padding;

  /// External margin around the button
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 53.h,
      margin: margin ?? EdgeInsets.only(top: 30.h, bottom: 26.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFFC67C4E),
          padding:
          padding ?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 30.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.h),
          ),
          elevation: 0,
        ),
        child: Text(
          text ?? "Get Started",
          style: TextStyleHelper.instance.textStyle4.copyWith(
            color: textColor ?? Color(0xFFFFFFFF),
            height: 1.31,
          ),
        ),
      ),
    );
  }
}
