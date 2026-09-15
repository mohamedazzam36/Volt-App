import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';


class LessonQuestionActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const LessonQuestionActionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: text,
      onTap: onTap,
      backgroundColor: backgroundColor,
      width: double.infinity,
    );
  }
}