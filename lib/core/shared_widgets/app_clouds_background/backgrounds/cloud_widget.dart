import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/cloud_painter.dart';
import 'package:volt/core/theme/app_colors.dart';

class CloudWidget extends StatelessWidget {
  final double width;
  final CloudShape shape;
  final Color color;

  const CloudWidget({
    super.key,
    this.width = 120,
    this.shape = CloudShape.flatBottom,
    this.color = AppColors.textOnBrand,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.clamp(60, 220),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: RepaintBoundary(
          child: CustomPaint(
            painter: CloudPainter(shape: shape, color: color),
          ),
        ),
      ),
    );
  }
}
