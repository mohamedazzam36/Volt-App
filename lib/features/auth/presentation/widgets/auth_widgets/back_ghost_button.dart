import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

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
