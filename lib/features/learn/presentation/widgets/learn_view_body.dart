import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/lesson_banner_button.dart';
import 'package:volt/core/shared_widgets/top_stats_bar.dart';
import 'package:volt/core/theme/app_colors.dart';

class LearnViewBody extends StatelessWidget {
  const LearnViewBody({super.key});

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
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: LessonBannerButton(
                                backgroundColor: index == 6 ? AppColors.brandSecondaryOrange : null,
                                onTap: () {},
                              ),
                            );
                          },
                          childCount: 200,
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                    ],
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
