import 'package:flutter/material.dart';

class RobotWithBase extends StatelessWidget {
  const RobotWithBase({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            child: ClipOval(
              child: Container(
                width: 100,
                height: 80,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 20,
            child: Image.asset(
              imagePath,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
