import 'package:flutter/material.dart';
import './cloud_painter.dart';
import './cloud_widget.dart';

class AnimatedCloud extends StatelessWidget {
  const AnimatedCloud({
    super.key,
    required this.slide,
    required this.fade,
    required this.width,
    this.left,
    this.right,
    this.top,
  }) : assert(left != null || right != null, 'يجب تحديد left أو right');

  final Animation<Offset> slide;
  final Animation<double> fade;
  final double width;
  final double? left;
  final double? right;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: CloudWidget(width: width, shape: CloudShape.puffy),
        ),
      ),
    );
  }
}
