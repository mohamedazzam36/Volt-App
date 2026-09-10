import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/theme/app_colors.dart';

class SurpriseMeWidget extends StatelessWidget {
  const SurpriseMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.brandSecondaryOrange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.brandSecondaryOrange.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AuthStrings.surpriseMe, // بدال 'فاجئنى'
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.brandSecondaryOrange,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.casino_outlined,
            size: 16,
            color: AppColors.brandSecondaryOrange,
          ),
        ],
      ),
    );
  }
}
