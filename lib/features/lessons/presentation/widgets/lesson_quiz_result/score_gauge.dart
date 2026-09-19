import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class ScoreGauge extends StatelessWidget {
  const ScoreGauge({super.key, required this.score});
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
                  LessonStrings.total,
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
      ..color = AppColors.brandSecondaryGreen
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
