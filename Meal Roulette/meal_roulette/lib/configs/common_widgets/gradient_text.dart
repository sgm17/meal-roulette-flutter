import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign textAlign;

  const GradientText(
      this.text, {
        super.key,
        this.style,
        this.textAlign = TextAlign.start,
        required this.gradient,
      });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: (style ?? const TextStyle()).copyWith(
          color: Colors.white, // Required to show gradient
        ),
      ),
    );
  }
}