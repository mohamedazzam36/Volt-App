import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/routing/app_router.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class LessonQuizResultView extends StatelessWidget {
  const LessonQuizResultView({
    super.key,
    required this.result,
    this.retryAttemptNumber = 0,
  });

  final QuizAttemptResultModel result;
  final int retryAttemptNumber;

  static const int _maxRetries = 3;

  @override
  Widget build(BuildContext context) {
    final scorePercent = result.scorePercentage;
    final isGood = scorePercent >= 60;
    final hasRetry = result.retryQuestions?.isNotEmpty == true;
    final canRetry = hasRetry && retryAttemptNumber < _maxRetries;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.lessonsBackgroundImage1.path),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Results', // تم تعديلها بناءً على التصميم الجديد
                    style: AppStyles.bold20
                        .responsive(context)
                        .copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                        ),
                  ),
                ),
                const SizedBox(height: 32),

                // مؤشر النتيجة (Custom Arc)
                _ScoreGauge(score: scorePercent),
                const SizedBox(height: 32),

                // كروت الإجابات
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        value: result.correctAnswers.toString(),
                        label: 'اجابات صحيحة',
                        color: const Color(0xFF4CAF50), // لون أخضر للتصميم
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        value: result.wrongAnswers.toString(),
                        label: 'اجابات خاطئة',
                        color: const Color(0xFFE53935), // لون أحمر للتصميم
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // الروبوت والـ XP
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      isGood
                          ? Assets.images.authRobotHappy.path
                          : Assets.images.authRobotThinking.path,
                      height: 180,
                    ),
                    Positioned(
                      right: -20, // لضبط مكان الـ XP زي التصميم
                      top: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          '+${result.earnedPoints} XP',
                          style: AppStyles.bold14
                              .responsive(context)
                              .copyWith(color: const Color(0xFF4CAF50)),
                        ),
                      ),
                    ),
                  ],
                ),

                if (hasRetry)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      retryAttemptNumber >= _maxRetries
                          ? 'استنفذت محاولات إعادة الاختبار'
                          : 'المحاولة ${retryAttemptNumber + 1} من $_maxRetries',
                      style: AppStyles.medium12
                          .responsive(context)
                          .copyWith(
                            color: retryAttemptNumber >= _maxRetries
                                ? AppColors.statusError
                                : AppColors.textSecondary,
                          ),
                    ),
                  ),

                const Spacer(),

                // الأزرار السفلية
                Row(
                  children: [
                    if (canRetry) ...[
                      Expanded(
                        child: _ActionButton(
                          label: 'اعد المحاولة',
                          backgroundColor: const Color(0xFF5C9E54), // أخضر
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                              Routes.lessonQuizRetry,
                              arguments: LessonQuizRetryArgs(
                                retryQuestions: result.retryQuestions!,
                                attemptId: result.attemptId,
                                retryAttemptNumber: retryAttemptNumber + 1,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: _ActionButton(
                        label: 'متابعة',
                        backgroundColor: const Color(0xFF55A6F8), // أزرق
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.mainLayout,
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                if (result.essayResults?.isNotEmpty == true) ...[
                  const SizedBox(height: 16),
                  _ActionButton(
                    label: 'عرض اجابات الاسالة المقالية',
                    backgroundColor: const Color(0xFF5C9E54),
                    onTap: () {},
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreGauge extends StatelessWidget {
  const _ScoreGauge({required this.score});
  final double score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // ارتفاع نص الدايرة
      width: 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: const Size(240, 120),
            painter: _ScoreGaugePainter(score: score),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'المجموع',
                  style: AppStyles.semiBold14
                      .responsive(context)
                      .copyWith(color: Colors.grey.shade500),
                ),
                Text(
                  '%${score.toStringAsFixed(1)}',
                  style: AppStyles.bold36
                      .responsive(context)
                      .copyWith(color: const Color(0xFF2C3E50)), // لون داكن للنص
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// الكاستوم بينتر لرسم الـ Arc
class _ScoreGaugePainter extends CustomPainter {
  final double score;

  _ScoreGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 16.0;
    // بنرسم مستطيل يمثل مساحة الدايرة الكاملة
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      (size.height * 2) - strokeWidth,
    );

    // ستايل الخلفية الرمادي
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // ستايل شريط التقدم الأخضر
    final fgPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // رسم الخلفية (من زاوية 180 درجة ولمسافة 180 درجة)
    canvas.drawArc(rect, math.pi, math.pi, false, bgPaint);

    // رسم النتيجة بناءً على النسبة
    final sweepAngle = (score / 100) * math.pi;
    canvas.drawArc(rect, math.pi, sweepAngle, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _ScoreGaugePainter oldDelegate) {
    return oldDelegate.score != score;
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1.2,
            ),
          ),
          Text(
            label,
            style: AppStyles.semiBold12.responsive(context).copyWith(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // كبرنا الارتفاع شوية بناءً على الديزاين
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0, // شلنا الـ Shadow عشان يكون Flat زي التصميم
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: AppStyles.bold16
              .responsive(context)
              .copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
