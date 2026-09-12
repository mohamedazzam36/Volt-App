import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/quiz/presentation/widgets/quiz_header.dart';

import '../../../../core/constants/assets.gen.dart';
import '../../../../core/shared_widgets/custom_elevated_button.dart';
import '../../../../core/shared_widgets/speaking_robot.dart';

class TextQuizView extends StatefulWidget {
  const TextQuizView({super.key});

  @override
  State<TextQuizView> createState() => _TextQuizViewState();
}

class _TextQuizViewState extends State<TextQuizView> {
  final TextEditingController _answerController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _answerController.addListener(_onAnswerChanged);
  }

  void _onAnswerChanged() {
    final isEnabled = _answerController.text.trim().isNotEmpty;

    if (_isButtonEnabled != isEnabled) {
      setState(() {
        _isButtonEnabled = isEnabled;
      });
    }
  }

  void _submitAnswer() {
    if (!_isButtonEnabled) return;

    final answer = _answerController.text.trim();

    // TODO: Handle answer
    debugPrint('Answer: $answer');
  }

  @override
  void dispose() {
    _answerController.removeListener(_onAnswerChanged);
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final robotWidth = screenWidth * 0.28;

    return Scaffold(
      backgroundColor: AppColors.surfaceDefault,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              QuizHeader(
                currentQuestionIndex: 1,
                totalQuestions: 6,
                lives: 5,
                onBackPressed: () => Navigator.maybePop(context),
              ),

              const Spacer(flex: 1),

              DefaultTextStyle(
                style: AppStyles.semiBold14
                    .responsive(context)
                    .copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                child: SpeakingRobot(
                  message: QuizStrings.whatIsDiffVoltageCurrent,
                  robotImagePath: Assets.images.voltActiveMode.path,
                  isMessageOneLine: true,
                  messageShiftingRatio: 0.5,
                  spaceAfterMessage: 4,
                  robotWidth: robotWidth,
                ),
              ),

              const Spacer(flex: 1),

              Container(
                height: 145,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoftBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.brandPrimary,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: _answerController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppStyles.regular12
                      .responsive(context)
                      .copyWith(
                        color: AppColors.textPrimary,
                      ),
                  decoration: InputDecoration(
                    hintText: QuizStrings.writeAnswerHere,
                    hintStyle: AppStyles.regular12
                        .responsive(context)
                        .copyWith(
                          color: AppColors.textDisabled,
                        ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: CustomElevatedButton(
                  text: CommonStrings.sent,
                  backgroundColor: _isButtonEnabled
                      ? AppColors.brandPrimary
                      : AppColors.borderDefault,
                  textColor: AppColors.textOnBrand,
                  onTap: _submitAnswer,
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
