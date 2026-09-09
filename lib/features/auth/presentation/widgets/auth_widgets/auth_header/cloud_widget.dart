import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_header/cloud_painter.dart';

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
