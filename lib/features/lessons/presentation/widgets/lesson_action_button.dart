import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';

class LessonActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const LessonActionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 12),
      child: CustomElevatedButton(
        text: text,
        onTap: onTap,
        backgroundColor: backgroundColor ?? AppColors.brandSecondaryGreen,
      ),
    );
  }
}
