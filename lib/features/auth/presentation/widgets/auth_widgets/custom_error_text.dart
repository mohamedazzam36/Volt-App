import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class CustomErrorText extends StatelessWidget {
  final String errorText;

  const CustomErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.statusError,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            errorText,
            style: AppStyles.bold14.responsive(context).copyWith(color: AppColors.statusError),
          ),
        ],
      ),
    );
  }
}
