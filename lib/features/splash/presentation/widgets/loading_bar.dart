import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.brandPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
