import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class LessonHeader extends StatelessWidget {
  final double progress;
  final VoidCallback onBackPressed;

  const LessonHeader({
    super.key,
    required this.progress,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // 1. زر العودة بمساحة لمس مخصصة
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBackPressed,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF9CA3AF),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // 2. شريط التقدم المطابق لـ QuizHeader
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 300),
                    widthFactor: progress.clamp(0.0, 1.0),
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
        ],
      ),
    );
  }
}