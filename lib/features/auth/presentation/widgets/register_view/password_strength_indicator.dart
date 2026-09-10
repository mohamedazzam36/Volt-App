import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strength; // من 0 لـ 5

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: .center,
      children: List.generate(5, (index) {
        final isActive = index < strength;

        return Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFFDE8D7) : const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? const Color(0xFFF6A96C) : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Icon(
            Icons.bolt, // أو أي svg/icon للأيقونة بتاعتك
            color: isActive ? const Color(0xFFF39233) : const Color(0xFFCBD5E1),
            size: 22,
          ),
        );
      }),
    );
  }
}
