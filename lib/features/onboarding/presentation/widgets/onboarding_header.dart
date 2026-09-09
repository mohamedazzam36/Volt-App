import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class OnboardingHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onBackPressed;
  final VoidCallback onLoginPressed;

  const OnboardingHeader({
    super.key,
    required this.currentIndex,
    required this.onBackPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 4,
      ),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceDefault,
            borderRadius: BorderRadius.circular(20),
            border: const Border(
              top: BorderSide(
                color: AppColors.borderSubtle,
                width: 1.5,
              ),
              left: BorderSide(
                color: AppColors.borderSubtle,
                width: 2.5,
              ),
              right: BorderSide(
                color: AppColors.borderSubtle,
                width: 2.5,
              ),
              bottom: BorderSide(
                color: AppColors.borderSubtle,
                width: 4,
              ),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onLoginPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                OnboardingStrings.login,
                style: AppStyles.black12.responsive(context).copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
