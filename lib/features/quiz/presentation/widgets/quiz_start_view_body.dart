import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/app_clouds_background_layout.dart';
import 'package:volt/core/shared_widgets/back_ghost_button.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/quiz/data/repositories/quiz_repository.dart';
import 'package:volt/features/quiz/presentation/cubits/quiz_cubit.dart';
import 'package:volt/features/quiz/presentation/views/quiz_screen.dart';
import 'package:volt/features/quiz/presentation/widgets/green_thinking_robot.dart';

class QuizStartViewBody extends StatefulWidget {
  const QuizStartViewBody({super.key});

  @override
  State<QuizStartViewBody> createState() => _QuizStartViewBodyState();
}

class _QuizStartViewBodyState extends State<QuizStartViewBody> {
  bool isFirstStep = true;

  @override
  Widget build(BuildContext context) {
    return AppCloudsBackgroundLayout(
      headerStartFromLeft: true,
      bottomBaseColor: AppColors.brandSecondaryOrange,
      bodyWidget: Column(
        children: [
          isFirstStep
              ? const GreenThinkingRobot(QuizStrings.startDialogue1)
              : SpeakingRobot(
                  message: QuizStrings.startDialogue2,
                  robotImagePath: Assets.images.readingBookRobot.path,
                  robotWidth: (context.width * 0.35).clamp(100.0, 200.0),
                  messageShiftingRatio: .43,
                  spaceAfterMessage: 6,
                ),
          const SizedBox(height: 54),
          CustomElevatedButton(
            text: CommonStrings.next,
            backgroundColor: AppColors.brandSecondaryOrange,
            textColor: AppColors.textOnBrand,
            onTap: () {
              if (isFirstStep) {
                setState(() {
                  isFirstStep = false;
                });
              } else {
                context.pushAndRemoveAll(
                  BlocProvider(
                    create: (_) => QuizCubit(QuizRepository())..loadQuestions(),
                    child: const QuizScreen(),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          if (!isFirstStep)
            BackGhostButton(
              onTap: () {
                setState(() {
                  isFirstStep = true;
                });
              },
            ),
        ],
      ),
    );
  }
}
