import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
import 'package:volt/features/onboarding/presentation/widgets/first_page_image.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.item,
    required this.index,
    required this.contentHeight,
    required this.horizontalPadding,
  });

  final OnboardingModel item;
  final int index;
  final double contentHeight;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final isDark = item.isDark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          SizedBox(
            height: contentHeight * 0.68,
            width: double.infinity,
            child: index == 0
                ? FirstPageImage(imagePath: item.image)
                : Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                  ),
          ),

          SizedBox(
            height: contentHeight * 0.13,
            child: Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppStyles.bold24
                    .responsive(context)
                    .copyWith(
                      color: isDark ? AppColors.textOnBrand : AppColors.textPrimary,
                    ),
              ),
            ),
          ),

          SizedBox(
            height: contentHeight * 0.04,
            child: Center(
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                style: AppStyles.semiBold14
                    .responsive(context)
                    .copyWith(
                      height: 1.3,
                      color: isDark
                          ? AppColors.textOnBrand.withValues(alpha: 0.7)
                          : AppColors.neutralSlate,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
