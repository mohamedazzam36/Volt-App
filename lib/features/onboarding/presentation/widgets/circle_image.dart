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
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 7,
            offset: const Offset(0, 3),
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