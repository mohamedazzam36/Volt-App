import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String assetPath;
  final double size;
  final double iconSize;

  const CircleImage({
    super.key,
    required this.assetPath,
    this.size = 42,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF323B492E),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),

            offset: const Offset(0, 3.5),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Image.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
      ),
    );
  }
}
