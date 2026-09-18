import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../extensions/navigation_extension.dart';
import '../extensions/text_style_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class BackGhostButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  const BackGhostButton({
    super.key,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      child: Text(
        text ?? CommonStrings.back,
        style: AppStyles.extraBold14.responsive(context).copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
