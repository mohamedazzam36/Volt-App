import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';

import 'circle_image.dart';

class FirstPageImage extends StatelessWidget {
  final String imagePath;

  const FirstPageImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // حجم الدوائر Responsive
        final circleSize = (width * 0.10).clamp(
          36.0,
          46.0,
        );

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // =====================================================
            // MAIN ROBOT IMAGE
            // =====================================================
            SizedBox(
              width: width * 0.55,
              height: height * 0.90,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            // =====================================================
            // TOP LEFT CIRCLE
            // =====================================================
            Positioned(
              left: width * 0.02,
              top: height * 0.10,
              child: CircleImage(
                assetPath: Assets.images.svg.path,
                size: circleSize,
                iconSize: circleSize * 0.48,
              ),
            ),

            // =====================================================
            // TOP RIGHT CIRCLE
            // =====================================================
            Positioned(
              right: width * 0.02,
              top: height * 0.15,
              child: CircleImage(
                assetPath: Assets.images.vector.path,
                size: circleSize,
                iconSize: circleSize * 0.48,
              ),
            ),

            // =====================================================
            // BOTTOM LEFT CIRCLE
            // =====================================================
            Positioned(
              left: width * 0.07,
              bottom: height * 0.14,
              child: CircleImage(
                assetPath: Assets.images.svg1.path,
                size: circleSize,
                iconSize: circleSize * 0.48,
              ),
            ),

            // =====================================================
            // BOTTOM RIGHT CIRCLE
            // =====================================================
            Positioned(
              right: width * 0.01,
              bottom: height * 0.06,
              child: CircleImage(
                assetPath: Assets.images.book.path,
                size: circleSize,
                iconSize: circleSize * 0.48,
              ),
            ),
          ],
        );
      },
    );
  }
}

