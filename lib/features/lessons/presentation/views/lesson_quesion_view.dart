import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/features/lessons/data/models/lesson_questio_item_model.dart';

import '../../data/models/lesson_theme_config.dart';
import '../widgets/lesson_header.dart';
import '../widgets/lesson_question_card_body.dart';
import 'lesson_end_view.dart';
import 'lesson_results_view.dart';

class LessonQuestionView extends StatefulWidget {
  final List<LessonQuestionItemModel> lessons;
  final LessonThemeConfig themeConfig;
  final VoidCallback? onLessonCompleted;

  const LessonQuestionView({
    super.key,
    required this.lessons,
    required this.themeConfig,
    this.onLessonCompleted,
  });

  @override
  State<LessonQuestionView> createState() => _LessonQuestionViewState();
}

class _LessonQuestionViewState extends State<LessonQuestionView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final Map<int, dynamic> _userAnswers = {};

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LessonEndView(
            onShowResultsPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonResultsView(
                    robotImagePath: Assets.images.greenRobotCelebrating.path,
                    percentage: 100,
                    correctAnswers: 0,
                    incorrectAnswers: 0,
                    xpGained: 0,
                    onRetryPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    onContinuePressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      widget.onLessonCompleted?.call();
                    },
                    onEssayAnswersPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
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
      return const Scaffold(
        body: Center(child: Text('لا توجد دروس حالياً')),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.themeConfig.backgroundImagePath),
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
                    final String robotImagePath = Assets.images.greenRobotThinking.path;

                    String buttonText = 'التالي';
                    if (index == 0) {
                      buttonText = 'ابدأ';
                    } else if (index == widget.lessons.length - 1) {
                      buttonText = 'إنهاء الدرس';
                    }

                    final double messageShiftingRatio = index == widget.lessons.length - 1
                        ? 0.02
                        : 1.2;

                    return LessonQuestionCardBody(
                      item: widget.lessons[index],
                      robotImagePath: robotImagePath,
                      buttonText: buttonText,
                      themeConfig: widget.themeConfig,
                      messageShiftingRatio: messageShiftingRatio,
                      selectedAnswer: _userAnswers[index],
                      onAnswerSelected: (answer) {
                        setState(() {
                          _userAnswers[index] = answer;
                        });
                      },
                      onNextPressed: _nextPage,
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
