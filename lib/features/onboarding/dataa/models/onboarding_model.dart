import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/theme/app_colors.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color buttonColor;
  final String buttonText;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.buttonColor,
    required this.buttonText,
  });

  static List<OnboardingModel> pages = [
    OnboardingModel(
      image: Assets.images.onboarding1.path,
      title: OnboardingStrings.title1,
      description: OnboardingStrings.subTitle1,
      backgroundColor: AppColors.surfaceDefault,
      buttonColor: AppColors.brandSecondaryGreen,
      buttonText: CommonStrings.continueAction,
    ),
    OnboardingModel(
      image: Assets.images.onboarding2.path,
      title: OnboardingStrings.title2,
      description: OnboardingStrings.subTitle2,
      backgroundColor: AppColors.surfaceYellowSoft,
      buttonColor: AppColors.brandSecondaryOrange,
      buttonText: CommonStrings.continueAction,
    ),
    OnboardingModel(
      image: Assets.images.onboarding3.path,
      title: OnboardingStrings.title3,
      description: OnboardingStrings.subTitle3,
      backgroundColor: AppColors.surfaceDarkNavy,
      buttonColor: AppColors.brandSecondaryGreen,
      buttonText: CommonStrings.continueAction,
    ),
    OnboardingModel(
      image: Assets.images.onboarding4.path,
      title: OnboardingStrings.title4,
      description: OnboardingStrings.subTitle4,
      backgroundColor: AppColors.surfaceBlueSoft,
      buttonColor: AppColors.brandPrimary,
      buttonText: OnboardingStrings.startPlaying,
    ),
  ];
}
