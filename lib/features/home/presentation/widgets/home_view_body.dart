import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/lesson_banner_button.dart';
import 'package:volt/core/shared_widgets/top_stats_bar.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/home/presentation/cubits/home_cubit.dart';
import 'package:volt/features/home/presentation/widgets/home_level_node.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.surfaceBackgroundScaffold,
          body: Stack(
            children: [
              Positioned(
                top: -(_scrollOffset * 0.2),
                left: 0,
                right: 0,
                bottom: -50000,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.homeBackgroundImage.path),
                      repeat: ImageRepeat.repeat,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    const TopStatsBar(),
                    const SizedBox(height: 20),
                    _buildBanner(context, state),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _buildContent(context, state),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBanner(BuildContext context, HomeState state) {
    if (state is HomeLoaded) {
      final inProgress = context.read<HomeCubit>().inProgressLesson;
      if (inProgress != null) {
        return LessonBannerButton(
          levelName: inProgress.levelName ?? '',
          lessonName: inProgress.lessonName ?? '',
          onTap: () {
            context.pushNamed(
              Routes.lessonContent,
              arguments: inProgress.lessonId,
            );
          },
        );
      }
    }
    return LessonBannerButton(
      levelName: '-',
      lessonName: '-',
      onTap: () {},
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    return switch (state) {
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeError(:final message) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: AppStyles.semiBold14.copyWith(color: AppColors.statusError),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.read<HomeCubit>().getPublishedLessons(),
                child: const Text(CommonStrings.retry),
              ),
            ],
          ),
        ),
      HomeLoaded(:final lessons) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LevelNode(lesson: lessons[index], index: index),
                childCount: lessons.length,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      _ => CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LevelNode.placeholder(index: index),
                childCount: 8,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
    };
  }
}
