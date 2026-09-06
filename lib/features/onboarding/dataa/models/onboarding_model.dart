import 'package:flutter/material.dart';

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
      image: 'assets/images/onboarding1.png',
      title: 'تعلّم بذكاء وحافظ على حماسك',
      description: 'دروس مخصصة وتحديات ممتعة ومكافآت تنتظرك',
      backgroundColor: const Color(0xFFFFFFFF),
      buttonColor: const Color(0xFF4CAF50),
      buttonText: 'متابعة',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'حقق العديد من الانجازات',
      description: 'العديد من التحديات مصممة خصيصاً لك',
      backgroundColor: const Color(0xFFFFF9E6),
      buttonColor: const Color(0xFFFF9800),
      buttonText: 'متابعة',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'العب واستكشف مع فولت',
      description: 'رفيقك الذكي في التعلم',
      backgroundColor: const Color(0xFF2C2B5B),
      buttonColor: const Color(0xFF4CAF50),
      buttonText: 'متابعة',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding4.png',
      title: 'آمن للأطفال',
      description: 'تأكد من سلامتك مع فولت',
      backgroundColor: const Color(0xFFF0F8FF),
      buttonColor: const Color(0xFF29B6F6),
      buttonText: 'ابدأ اللعب',
    ),
  ];
}