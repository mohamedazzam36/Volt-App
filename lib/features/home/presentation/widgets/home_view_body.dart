import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/lesson_banner_button.dart';
import 'package:volt/core/shared_widgets/top_stats_bar.dart';
import 'package:volt/features/home/presentation/widgets/home_level_node.dart';

void main() => runApp(const LearningApp());

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GamePathScreen();
  }
}

class GamePathScreen extends StatefulWidget {
  const GamePathScreen({super.key});

  @override
  State<GamePathScreen> createState() => _GamePathScreenState();
}

class _GamePathScreenState extends State<GamePathScreen> {
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
          // 1. الخلفية (البارالاكس زي ما هو)
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
                const TopStatsBar(),
                const SizedBox(height: 20),
                LessonBannerButton(onTap: () {}),
                const SizedBox(height: 20), // مسافة قبل بداية المسار
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return LevelNode(index: index);
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
