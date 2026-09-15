import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color buttonColor;
  final String buttonText;
  final bool isDark;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.buttonColor,
    required this.buttonText,
    this.isDark = false,
  });
}
