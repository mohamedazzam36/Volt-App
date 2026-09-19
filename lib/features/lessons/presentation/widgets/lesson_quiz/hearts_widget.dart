import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class HeartsWidget extends StatelessWidget {
  final int hearts;

  const HeartsWidget({super.key, required this.hearts});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 2,
      children: [
        const Icon(
          Icons.favorite_rounded,
          color: AppColors.accentRed,
          size: 20,
        ),
        Text(
          '$hearts',
          style: AppStyles.bold14.copyWith(color: AppColors.accentRed),
        ),
      ],
    );
  }
}
