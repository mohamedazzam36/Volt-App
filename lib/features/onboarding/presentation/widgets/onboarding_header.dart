import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_app_bar_elevated_button.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';

class OnboardingHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onSkipPressed;

  const OnboardingHeader({
    super.key,
    required this.currentIndex,
    required this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return currentIndex != OnboardingModel.pages.length - 1
        ? CustomAppBarElevatedButton(onTap: onSkipPressed, text: CommonStrings.skip)
        : const SizedBox.shrink();
  }
}
