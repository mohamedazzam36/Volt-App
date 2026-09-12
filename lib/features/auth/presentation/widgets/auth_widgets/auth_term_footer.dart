import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class AuthTermsFooter extends StatelessWidget {
  const AuthTermsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${AuthStrings.termsPrefix} ',
        style: AppStyles.semiBold14
            .responsive(context)
            .copyWith(
              color: AppColors.textSecondary,
            ),
        children: [
          TextSpan(
            text: '${AuthStrings.terms} ',
            style: AppStyles.semiBold14
                .responsive(context)
                .copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
          const TextSpan(text: '${AuthStrings.and} '),
          TextSpan(
            text: '${AuthStrings.privacyPolicy} ',
            style: AppStyles.semiBold14
                .responsive(context)
                .copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
          const TextSpan(text: AuthStrings.termsSuffix),
        ],
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }
}
