import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class XpCardWidget extends StatelessWidget {
  final int xpValue;
  final Color textColor;
  final EdgeInsetsGeometry? padding;

  const XpCardWidget({
    super.key,
    required this.xpValue,
    this.textColor = AppColors.textSuccess,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '+$xpValue XP',
          style: AppStyles.extraBold14.responsive(context).copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
