import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/app_clouds_background_layout.dart';
import 'package:volt/core/shared_widgets/back_ghost_button.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/green_thinking_robot.dart';

class QuizStartViewBody extends StatefulWidget {
  const QuizStartViewBody({super.key});

  @override
  State<QuizStartViewBody> createState() => _QuizStartViewBodyState();
}

class _QuizStartViewBodyState extends State<QuizStartViewBody> {
  bool isFirstStep = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacementQuizCubit, PlacementQuizState>(
      listener: (context, state) {
        if (state is PlacementQuizError) {
          context.showSnackBar(state.message, type: SnackBarType.error);
        } else if (state is PlacementQuizAttemptStarted) {
          // Navigate once when attempt is created – passing the cubit so the quiz screen reuses it
          context.pushNamed(
            Routes.placementQuiz,
            arguments: context.read<PlacementQuizCubit>(),
          );
        }
      },
      child: AppCloudsBackgroundLayout(
        headerStartFromLeft: true,
        bottomBaseColor: AppColors.brandSecondaryOrange,
        bodyWidget: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: isFirstStep
                  ? const GreenThinkingRobot(
                      QuizStrings.startDialogue1,
                      key: ValueKey('robot-step-1'),
                    )
                  : SpeakingRobot(
                      key: const ValueKey('robot-step-2'),
                      message: QuizStrings.startDialogue2,
                      robotImagePath: Assets.images.readingBookRobot.path,
                      robotWidth: (context.width * 0.35).clamp(100.0, 200.0),
                      messageShiftingRatio: .43,
                      spaceAfterMessage: 6,
                    ),
            ),
            const SizedBox(height: 54),
            BlocBuilder<PlacementQuizCubit, PlacementQuizState>(
              buildWhen: (_, s) =>
                  s is PlacementQuizLoading ||
                  s is PlacementQuizError ||
                  s is PlacementQuizInitial,
              builder: (context, state) {
                final isLoading = state is PlacementQuizLoading;
                return CustomElevatedButton(
                  text: isLoading ? '...' : CommonStrings.next,
                  backgroundColor: AppColors.brandSecondaryOrange,
                  textColor: AppColors.textOnBrand,
                  onTap: isLoading
                      ? null
                      : () {
                          if (isFirstStep) {
                            setState(() => isFirstStep = false);
                          } else {
                            context.read<PlacementQuizCubit>().startPlacement();
                          }
                        },
                );
              },
            ),
            const SizedBox(height: 16),
            if (!isFirstStep)
              BackGhostButton(
                onTap: () {
                  setState(() => isFirstStep = true);
                },
              ),
          ],
        ),
      ),
    );
  }
}
