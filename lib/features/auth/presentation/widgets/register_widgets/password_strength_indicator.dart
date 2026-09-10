import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strength; // من 0 لـ 5

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isActive = index < strength;

        return Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            // استبدال خلفية البرتقالي الفاتح أو الرمادي الفاتح
            color: isActive
                ? AppColors.brandSecondaryOrange.withValues(alpha: 0.15)
                : AppColors.surfaceSubtle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              // بوردر البرتقالي في الـ Active وشفاف في العادي
              color: isActive
                  ? AppColors.brandSecondaryOrange.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Icon(
            Icons.bolt,
            color: isActive
                ? AppColors.brandSecondaryOrange
                : AppColors.neutralSlate.withValues(alpha: 0.4),
            size: 22,
          ),
        );
      }),
    );
  }
}
