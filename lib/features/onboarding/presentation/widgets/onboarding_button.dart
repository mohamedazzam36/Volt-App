import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const OnboardingButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 43,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(11),
        ),
        padding: const EdgeInsets.only(bottom: 3),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 5,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          child: Text(
            text,
            style: AppStyles.bold16.responsive(context).copyWith(color: AppColors.textOnBrand),
          ),
        ),
      ),
    );
  }
}
