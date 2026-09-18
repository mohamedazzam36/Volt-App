import 'package:flutter/material.dart';
import './star_painter.dart';

class StarWidget extends StatelessWidget {
  final double size;
  final Color color;
  final double sharpness;

  const StarWidget({
    super.key,
    this.size = 24,
    this.color = const Color(0xFFFFD54F),
    this.sharpness = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.clamp(12, 40),
      child: AspectRatio(
        aspectRatio: 1,
        child: RepaintBoundary(
          child: CustomPaint(
            painter: StarPainter(color: color, spikesSharpness: sharpness),
          ),
        ),
      ),
    );
  }
}
