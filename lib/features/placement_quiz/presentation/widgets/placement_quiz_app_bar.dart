import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';

class PlacementQuizAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onCloseTap;

  const PlacementQuizAppBar({super.key, this.onCloseTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<PlacementQuizAppBar> createState() => _PlacementQuizAppBarState();
}

class _PlacementQuizAppBarState extends State<PlacementQuizAppBar> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacementQuizCubit, PlacementQuizState>(
      listener: (context, state) {
        if (state is PlacementQuizQuestion) {
          setState(() => progress = state.progress);
        }
      },
      child: SafeArea(
        bottom: false,
        child: Container(
          height: widget.preferredSize.height,
          color: Colors.transparent,
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.iconPrimary,
                  size: 20,
                ),
                onPressed: widget.onCloseTap,
                splashRadius: 22,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: progress),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  builder: (context, value, _) {
                    return Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.borderSubtle,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: AlignmentDirectional.centerStart,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth * value,
                            decoration: BoxDecoration(
                              color: AppColors.brandSecondaryOrange,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
