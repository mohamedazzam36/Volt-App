import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/quiz_start_view_body.dart';

class QuizInitialView extends StatelessWidget {
  const QuizInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    // The cubit is provided by the router (app_router.dart)
    return const Scaffold(
      backgroundColor: AppColors.surfaceOrangeSoft,
      body: QuizStartViewBody(),
    );
  }
}
