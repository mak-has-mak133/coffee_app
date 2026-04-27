import 'package:flutter/cupertino.dart';

class ShadowBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Widget? child;
  const ShadowBox({
    super.key,
    required this.begin,
    required this.end,
     required this.colors,
    required this.stops,
    required this.width,
     this.height,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          stops: stops,
        ),
      ),
      child: child,
    );
  }
}
