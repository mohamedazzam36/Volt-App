import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/placement_quiz_app_bar.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/placement_quiz_view_body.dart';

class PlacementQuizView extends StatelessWidget {
  const PlacementQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacementQuizCubit, PlacementQuizState>(
      listener: (context, state) {
        if (state is PlacementQuizError) {
          context.showSnackBar(state.message, type: SnackBarType.error);
        } else if (state is PlacementQuizSubmitted) {
          context.pushReplacementNamed(
            Routes.placementQuizResult,
            arguments: state.result,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.lessonsBackgroundImage1.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PlacementQuizAppBar(
            onCloseTap: () {
              final cubit = context.read<PlacementQuizCubit>();
              if (cubit.isFirstQuestion) {
                context.pop();
              } else {
                cubit.prevQuestion();
              }
            },
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PlacementQuizViewBody(),
          ),
        ),
      ),
    );
  }
}
