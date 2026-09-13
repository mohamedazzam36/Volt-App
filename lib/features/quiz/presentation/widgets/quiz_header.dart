import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class QuizHeader extends StatelessWidget {
  final int currentQuestionIndex;
  final int totalQuestions;
  final int lives;
  final VoidCallback onBackPressed;
  final VoidCallback? onPreviousQuestion;

  const QuizHeader({
    super.key,
    required this.currentQuestionIndex,
    this.totalQuestions = 6,
    required this.lives,
    required this.onBackPressed,
    this.onPreviousQuestion,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (currentQuestionIndex / totalQuestions).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // 1. زر العودة
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textDisabled),
            onPressed: () {
              if (currentQuestionIndex > 1 && onPreviousQuestion != null) {
                onPreviousQuestion!();
              } else {
                onBackPressed();
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),

          // 2. شريط التقدم AnimatedProgress (ينمو من اليمين إلى اليسار)
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.borderDefault,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.centerRight, // 👈 التغيير هنا لعكس اتجاه الشريط
                children: [
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 300),
                    widthFactor: progress,
                    heightFactor: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // 3. عدد المحاولات / القلوب
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$lives',
                style: AppStyles.bold12.responsive(context).copyWith(
                      color: AppColors.accentRed,
                    ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.favorite, color: AppColors.accentRed, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}