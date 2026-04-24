import 'package:flutter/cupertino.dart';

class Onboardimage extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final BoxFit fit;
  const Onboardimage({super.key,required this.imagePath,required this.height,required this.width,required this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
