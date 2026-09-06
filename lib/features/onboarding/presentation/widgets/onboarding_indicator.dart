import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color activeColor;

  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isActive = currentIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: isActive ? 14 : 5,
            height: 5,
            decoration: BoxDecoration(
              color: isActive
                  ? activeColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        },
      ),
    );
  }
}