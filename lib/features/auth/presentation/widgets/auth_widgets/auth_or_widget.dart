import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class AuthOrWidget extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderSubtle)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'أو',
            style: AppStyles.medium14.responsive(context).copyWith(color: AppColors.textSecondary),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderSubtle)),
      ],
    );
  }
}
