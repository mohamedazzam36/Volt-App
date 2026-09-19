import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/lessons/presentation1/cubits/lesson_content_cubit/lesson_content_cubit.dart';

class LessonContentAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;

  const LessonContentAppBar({
    super.key,
    this.onBackTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<LessonContentAppBar> createState() => _LessonContentAppBarState();
}

class _LessonContentAppBarState extends State<LessonContentAppBar> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonContentCubit, LessonContentState>(
      listener: (context, state) {
        if (state is LessonNextContent) {
          setState(() {
            progress = state.progress;
          });
        }
      },
      child: SafeArea(
        bottom: false,
        child: Container(
          height: widget.preferredSize.height,
          color: Colors.transparent,
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 32.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.iconPrimary,
                  size: 16,
                ),
                onPressed: widget.onBackTap ?? () => context.pop(),
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
                  builder: (context, value, child) {
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
                              color: AppColors.brandPrimary,
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
