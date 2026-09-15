import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/features/lessons/data/models/lesson_questio_item_model.dart';
import 'package:volt/features/quiz/data/models/option_model.dart';
import 'package:volt/features/quiz/presentation/widgets/question_types/text_choice_quiz_view.dart';
import 'package:volt/features/quiz/presentation/widgets/question_types/true_false_quiz_view.dart';
import 'package:volt/features/quiz/presentation/widgets/quiz_text_field.dart';

import '../../data/models/lesson_theme_config.dart';
import 'lesson_question_action_button.dart';
import 'lesson_help_button.dart';

class LessonQuestionCardBody extends StatelessWidget {
  final LessonQuestionItemModel item;
  final String robotImagePath;
  final String buttonText;
  final VoidCallback onNextPressed;
  final VoidCallback? onHelpPressed;
  final LessonThemeConfig themeConfig;
  final double messageShiftingRatio;
  final dynamic selectedAnswer;
  final ValueChanged<dynamic>? onAnswerSelected;

  const LessonQuestionCardBody({
    super.key,
    required this.item,
    required this.robotImagePath,
    required this.buttonText,
    required this.onNextPressed,
    this.onHelpPressed,
    required this.themeConfig,
    this.messageShiftingRatio = 1.2,
    this.selectedAnswer,
    this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = item.contentImagePath != null && item.contentImagePath!.isNotEmpty;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // قيم ريسبونسيف متجاوبة بناءً على ارتفاع وعرض الشاشة
    final double responsiveTopOffset = screenHeight * 0.025; 

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, 
        vertical: screenHeight * 0.015,
      ),
      child: Column(
        children: [
          // رأس الصفحة: العربية والروبوت بالرسالة (بشكل ريسبونسيف بالكامل)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasImage) ...[
                Expanded(
                  flex: 2,
                  child: Transform.translate(
                    offset: Offset(0, responsiveTopOffset + (screenHeight * 0.005)), 
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        item.contentImagePath!,
                        height: screenWidth * 0.24,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
              Expanded(
                flex: 3,
                child: Transform.translate(
                  offset: Offset(0, responsiveTopOffset), 
                  child: SpeakingRobot(
                    message: item.message,
                    robotImagePath: robotImagePath,
                    isMessageOneLine: item.isOneLine,
                    spaceAfterMessage: 12,
                    robotWidth: screenWidth * 0.26,
                    messageShiftingRatio: messageShiftingRatio,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.03), 

          // منطقة خيارات الأسئلة وزر المساعدة
          if (item.questionType != LessonQuestionType.none) ...[
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildQuizWidget(),
                    SizedBox(height: screenHeight * 0.02),
                    // زر المساعدة بتصميم ريسبونسيف على الشمال
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: screenWidth * 0.35,
                        height: screenHeight * 0.055,
                        child: LessonHelpButton(
                          onTap: onHelpPressed ?? () {},
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ),
            ),
          ] else ...[
            const Spacer(),
          ],

          SizedBox(height: screenHeight * 0.015),

          // زرار التفاعل السفلي
          LessonQuestionActionButton(
            text: buttonText,
            onTap: onNextPressed,
            backgroundColor: themeConfig.primaryButtonColor,
          ),
          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }

  Widget _buildQuizWidget() {
    switch (item.questionType) {
      case LessonQuestionType.trueFalse:
        return TrueFalseQuizView(
          selectedValue: selectedAnswer == 'صح'
              ? true
              : selectedAnswer == 'خطأ'
              ? false
              : null,
          onValueSelected: (value) => onAnswerSelected?.call(value ? 'صح' : 'خطأ'),
        );

      case LessonQuestionType.multipleChoice:
        final options = (item.options ?? [])
            .map((optionText) => OptionModel(id: optionText, text: optionText))
            .toList();

        return TextChoiceQuizView(
          options: options,
          selectedOptionId: selectedAnswer is String ? selectedAnswer as String : null,
          onOptionSelected: (id) => onAnswerSelected?.call(id),
        );

      case LessonQuestionType.textInput:
        final textController = TextEditingController(
          text: selectedAnswer is String ? selectedAnswer as String : '',
        );
        return QuizTextField(controller: textController);

        default:
        return const SizedBox.shrink();
    }
  }
}