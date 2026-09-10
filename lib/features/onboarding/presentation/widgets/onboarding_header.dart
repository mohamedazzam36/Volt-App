import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class OnboardingHeader extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final VoidCallback onSkipPressed;

  const OnboardingHeader({
    super.key,
    required this.currentIndex,
    this.isDark = false,
    required this.onSkipPressed,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SKIP BUTTON WITH 3D BORDER
          Container(
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onSkipPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Text(
                    CommonStrings.skip,
                    style: AppStyles.black12
                        .responsive(context)
                        .copyWith(
                          color: AppColors.brandPrimary,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}