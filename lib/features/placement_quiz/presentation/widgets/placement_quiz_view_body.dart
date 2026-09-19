import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/placement_quiz_question_body.dart';

class PlacementQuizViewBody extends StatelessWidget {
  const PlacementQuizViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacementQuizCubit, PlacementQuizState>(
      builder: (context, state) => switch (state) {
        PlacementQuizLoading() =>
          const Center(child: CircularProgressIndicator()),
        PlacementQuizSubmitting() =>
          const Center(child: CircularProgressIndicator()),
        PlacementQuizError() => Center(
          child: Text(
            state.message,
            style: AppStyles.semiBold14.copyWith(color: AppColors.statusError),
            textAlign: TextAlign.center,
          ),
        ),
        PlacementQuizQuestion() =>
          PlacementQuizQuestionBody(state: state),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
