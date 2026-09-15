import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

import '../../data/lesson_questions_data.dart';
import '../../data/models/lesson_question_item_model.dart';
import '../../data/models/lesson_theme_config.dart';
import 'lesson_quesion_view.dart';
import '../widgets/lesson_card_body.dart';
import '../widgets/lesson_header.dart';

class LessonView extends StatefulWidget {
  final List<LessonItemModel> lessons;
  final String backgroundImagePath;
  final VoidCallback? onLessonCompleted;

  const LessonView({
    super.key,
    required this.lessons,
    this.backgroundImagePath = 'assets/images/backgroundLevel1.png',
    this.onLessonCompleted,
  });

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < widget.lessons.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final lessonButtonColor = widget.lessons.last.buttonColor ?? AppColors.brandSecondaryGreen;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LessonQuestionView(
            lessons: LessonQuestionsData.lessons,
            themeConfig: LessonThemeConfig(
              backgroundImagePath: widget.backgroundImagePath,
              primaryButtonColor: lessonButtonColor,
            ),
            onLessonCompleted: widget.onLessonCompleted,
          ),
        ),
      );
    }
  }

  void _previousPageOrPop() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lessons.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('لا توجد دروس حالياً', style: AppStyles.semiBold16.responsive(context)),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              LessonHeader(
                progress: (_currentIndex + 1) / widget.lessons.length,
                onBackPressed: _previousPageOrPop,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemCount: widget.lessons.length,
                  itemBuilder: (context, index) {
                    // تحديد مسار صورة الروبوت مباشرة: سعيد في أول وآخر صفحة، ويفكر في الباقي
                    final String robotImagePath = (index == 0 || index == widget.lessons.length - 1)
                        ? Assets.images.authRobotThinking.path
                        : Assets.images.authRobotHappy.path;

                    return LessonCardBody(
                      item: widget.lessons[index],
                      robotImagePath: robotImagePath,
                      buttonText: 'التالي',
                      onNextPressed: _nextPage,
                      robotWidth: index == 0
                          ? (MediaQuery.sizeOf(context).width * 0.26).clamp(100.0, 180.0)
                          : null,
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
