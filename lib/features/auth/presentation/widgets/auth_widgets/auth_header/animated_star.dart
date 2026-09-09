import 'package:flutter/material.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_header/star_widget.dart';

class AnimatedStar extends StatelessWidget {
  const AnimatedStar({
    super.key,
    required this.scale,
    required this.size,
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  final Animation<double> scale;
  final double size;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: ScaleTransition(
        scale: scale,
        child: StarWidget(size: size),
      ),
    );
  }
}
