import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/lesson_banner_button.dart';
import 'package:volt/core/shared_widgets/top_stats_bar.dart';
import 'package:volt/core/theme/app_colors.dart';

class LearnViewBody extends StatefulWidget {
  const LearnViewBody({super.key});

  @override
  State<LearnViewBody> createState() => _LearnViewBodyState();
}

class _LearnViewBodyState extends State<LearnViewBody> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
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
                const SizedBox(height: 32),
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
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
