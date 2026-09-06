import 'package:flutter/material.dart';

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
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // =========================
            // Main Robot Image
            // =========================
            SizedBox(
              width: constraints.maxWidth * 0.82,
              height: constraints.maxHeight * 0.85,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),

            // =========================
            // Top Left Circle
            // =========================
            Positioned(
              left: constraints.maxWidth * 0.00,
              top: constraints.maxHeight * 0.1,
              child: const CircleImage(
                assetPath: 'assets/images/SVG.png',
                size: 42,
                iconSize: 20,
              ),
            ),

            // =========================
            // Top Right Circle
            // =========================
            Positioned(
              right: constraints.maxWidth * 0.00,
              top: constraints.maxHeight * 0.1,
              child: const CircleImage(
                assetPath: 'assets/images/Vector.png',
                size: 42,
                iconSize: 20,
              ),
            ),

            // =========================
            // Bottom Left Circle
            // =========================
            Positioned(
              left: constraints.maxWidth * 0.04,
              bottom: constraints.maxHeight * 0.1,
              child: const CircleImage(
                assetPath: 'assets/images/SVG (1).png',
                size: 42,
                iconSize: 20,
              ),
            ),

            // =========================
            // Bottom Right Circle
            // =========================
            Positioned(
              right: constraints.maxWidth * 0.02,
              bottom: constraints.maxHeight * 0.06,
              child: const CircleImage(
                assetPath: 'assets/images/book.png',
                size: 42,
                iconSize: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}