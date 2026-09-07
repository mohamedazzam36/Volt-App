import 'package:flutter/material.dart';
import 'package:volt/features/auth/presentation/widgets/painters/cloud_painter.dart';

class CloudWidget extends StatelessWidget {
  final double width;
  final double height;
  final CloudShape shape;
  final Color color;

  const CloudWidget({
    super.key,
    this.width = 120,
    this.height = 60,
    this.shape = CloudShape.flatBottom,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(width, height),
        painter: CloudPainter(shape: shape, color: color),
      ),
    );
  }
}
