import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class RegisterFinishBody extends StatelessWidget {
  final String name;
  final String email;
  final int age;
  final VoidCallback onSubmit;

  const RegisterFinishBody({
    super.key,
    required this.name,
    required this.email,
    required this.age,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: (context.height * 0.05).clamp(32.0, 70.0)),
          _SummaryItem(text: name),
          _SummaryItem(text: email, isEmail: true),
          _SummaryItem(text: '$age'),
          const SizedBox(height: 60),
          CustomElevatedButton(
            onTap: onSubmit,
            text: AuthStrings.finishAccountCreation,
            width: double.infinity,
            backgroundColor: AppColors.brandSecondaryGreen,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String text;
  final bool isEmail;

  const _SummaryItem({
    required this.text,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_rounded,
            color: AppColors.statusSuccess,
            size: 32,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: AppStyles.medium18
                .responsive(context)
                .copyWith(
                  color: AppColors.textPrimary,
                ),
            textDirection: isEmail ? TextDirection.ltr : TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
