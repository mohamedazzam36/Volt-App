import 'package:flutter/material.dart';
import '../../data/models/question_model.dart';

abstract class QuizLayoutHelper {
  /// تحدد ما إذا كان يجب إلغاء الـ Spacer العلوي لمنع Overlap أو مساحات فارغة
  static bool shouldRemoveTopSpacer(int questionIndex, QuestionType type) {
    return type == QuestionType.trueFalse ||
        questionIndex == 3 ||
        questionIndex == 4;
  }

  /// حساب الـ Vertical Offset بنسبة مئوية من عرض الشاشة لضمان الـ Responsiveness
  static Offset getQuestionBodyOffset(
    BuildContext context, {
    required int questionIndex,
    required QuestionType type,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    if (questionIndex == 3 || questionIndex == 4) {
      return Offset(0, -screenWidth * 0.14);
    }

    if (type == QuestionType.trueFalse) {
      return Offset(0, -screenWidth * 0.05);
    }

    return Offset.zero;
  }
}