import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // كبرنا الارتفاع شوية بناءً على الديزاين
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.textOnBrand,
          elevation: 0, // شلنا الـ Shadow عشان يكون Flat زي التصميم
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: AppStyles.bold16
              .responsive(context)
              .copyWith(
                color: AppColors.textOnBrand,
              ),
        ),
      ),
    );
  }
}
