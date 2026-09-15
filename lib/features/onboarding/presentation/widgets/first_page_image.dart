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

        final circleSize = (width * 0.12).clamp(40.0, 48.0);
        final iconSize = circleSize * 0.50;

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: width * 0.6,
              height: height * 0.80,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              left: width * 0.04,
              top: height * 0.10,
              child: CircleImage(
                assetPath: Assets.images.chartIcon.path,
                size: circleSize,
                iconSize: iconSize,
              ),
            ),

            Positioned(
              right: width * 0.04,
              top: height * 0.12,
              child: CircleImage(
                assetPath: Assets.images.vector.path,
                size: circleSize,
                iconSize: iconSize,
              ),
            ),

            Positioned(
              left: width * 0.04,
              bottom: height * 0.22,
              child: CircleImage(
                assetPath: Assets.images.book.path,

                size: circleSize,
                iconSize: iconSize,
              ),
            ),

            Positioned(
              right: width * 0.04,
              bottom: height * 0.20,
              child: CircleImage(
                assetPath: Assets.images.awardIcon.path,
                size: circleSize,
                iconSize: iconSize,
              ),
            ),
          ],
        );
      },
    );
  }
}
