import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_data.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_indicator.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.currentIndex,
    required this.currentPage,
    required this.onNext,
  });

  final int currentIndex;
  final OnboardingModel currentPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8,
          child: Center(
            child: OnboardingIndicator(
              currentIndex: currentIndex,
              itemCount: OnboardingData.pages.length,
              activeColor: currentPage.buttonColor,
            ),
          ),
        ),

        const SizedBox(height: 8),

        CustomElevatedButton(
          onTap: onNext,
          text: currentPage.buttonText,
          backgroundColor: currentPage.buttonColor,
        ),
      ],
    );
  }
}
