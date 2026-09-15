import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/lesson_banner_button.dart';
import 'package:volt/core/shared_widgets/top_stats_bar.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';
import 'package:volt/features/home/presentation/cubits/home_cubit.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

  Color _colorForLesson(LessonHomeModel lesson) {
    return switch (lesson.lessonStatus) {
      LessonStatus.completed => const Color(0xFF4CAF50),
      LessonStatus.inProgress => AppColors.brandPrimary,
      _ => const Color(0xFFB0BEC5),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.homeBackgroundImage.path),
                repeat: ImageRepeat.repeat,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 36),
                const TopStatsBar(),
                const SizedBox(height: 32),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return switch (state) {
                        HomeLoading() => const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        HomeError(:final message) => Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  message,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed: () =>
                                      context.read<HomeCubit>().getPublishedLessons(),
                                  child: const Text(
                                    'إعادة المحاولة',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        HomeLoaded(:final lessons) => CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final lesson = lessons[index];
                                    final isLocked =
                                        lesson.lessonStatus == LessonStatus.locked;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Opacity(
                                        opacity: isLocked ? 0.55 : 1.0,
                                        child: LessonBannerButton(
                                          levelName: lesson.levelName ?? '',
                                          lessonName: lesson.lessonName ?? '',
                                          backgroundColor: _colorForLesson(lesson),
                                          onTap: isLocked
                                              ? () {}
                                              : () {
                                                  final isChest = lesson.lessonType == LessonType.finalLevelQuiz || 
                                                                  lesson.lessonType == LessonType.finalLevelQuizLower;
                                                  Navigator.of(context).pushNamed(
                                                    isChest ? Routes.lessonQuiz : Routes.lessonContent,
                                                    arguments: lesson.lessonId,
                                                  );
                                                },
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: lessons.length,
                                ),
                              ),
                              const SliverPadding(
                                padding: EdgeInsets.only(bottom: 100),
                              ),
                            ],
                          ),
                        _ => const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
