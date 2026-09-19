import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/text_style_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class QuizTextField extends StatelessWidget {
  final TextEditingController controller;

  const QuizTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoftBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.brandPrimary,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: AppStyles.regular12.responsive(context).copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: QuizStrings.writeAnswerHere,
          hintStyle: AppStyles.regular12
              .responsive(context)
              .copyWith(color: AppColors.textDisabled),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
