import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';
import 'package:volt/features/home/presentation/widgets/level_node_button.dart';
import 'package:volt/features/home/presentation/widgets/robot_with_base.dart';

class LevelNode extends StatelessWidget {
  final LessonHomeModel? lesson;
  final int index;

  const LevelNode({super.key, required this.lesson, required this.index});

  const LevelNode.placeholder({super.key, required this.index}) : lesson = null;

  bool get _isChest {
    final t = lesson?.lessonType;
    return t == LessonType.finalLevelQuiz || t == LessonType.finalLevelQuizLower;
  }

  bool get _isUnlocked {
    final s = lesson?.lessonStatus ?? LessonStatus.locked;
    return s == LessonStatus.completed || s == LessonStatus.inProgress;
  }

  @override
  Widget build(BuildContext context) {
    double alignX = math.sin(index * 0.5 + 1.4) * 0.4;

    final isPlaceholder = lesson == null;
    final status = lesson?.lessonStatus ?? LessonStatus.locked;
    final showLevelLabel = lesson?.isFirstLevelLesson == true;

    final bool hasRobot =
        index == 1 || index == 4 || index == 8 || index == 15 || index == 19;
    final bool robotOnLeft = alignX >= 0;

    return Column(
      children: [
        if (showLevelLabel)
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.brandPrimary.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.brandPrimary.withAlpha(80)),
              ),
              child: Text(
                lesson?.levelName ?? '',
                style: AppStyles.semiBold12.copyWith(color: AppColors.brandPrimary),
              ),
            ),
          ),
        Align(
          alignment: Alignment(alignX, 0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (_isChest)
                _ChestNode(
                  isUnlocked: _isUnlocked,
                  onTap: isPlaceholder
                      ? null
                      : () => Navigator.of(context).pushNamed(
                            Routes.lessonQuiz,
                            arguments: lesson!.lessonId,
                          ),
                )
              else if (_isUnlocked)
                LevelNodeButton.unlocked(
                  iconPath: status == LessonStatus.completed
                      ? Assets.svgs.homeStarButtonIcon.path
                      : Assets.svgs.homeBookButtonIcon.path,
                  progress: status == LessonStatus.inProgress ? 0.5 : null,
                  onTap: isPlaceholder
                      ? null
                      : () => Navigator.of(context).pushNamed(
                            Routes.lessonContent,
                            arguments: lesson!.lessonId,
                          ),
                )
              else
                LevelNodeButton.locked(
                  iconPath: Assets.svgs.homeLockButtonIcon.path,
                  onTap: null,
                ),
              if (hasRobot)
                Positioned(
                  left: robotOnLeft
                      ? -(context.width * 0.4).clamp(170.0, 250.0)
                      : null,
                  right: !robotOnLeft
                      ? -(context.width * 0.4).clamp(170.0, 250.0)
                      : null,
                  bottom: -10,
                  child: RobotWithBase(
                    imagePath: robotOnLeft
                        ? Assets.images.readingBookRobot.path
                        : Assets.images.blueAmazedRobot.path,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ويدجت الكنز مع bounce animation وقابل للنقر
class _ChestNode extends StatefulWidget {
  final bool isUnlocked;
  final VoidCallback? onTap;

  const _ChestNode({required this.isUnlocked, this.onTap});

  @override
  State<_ChestNode> createState() => _ChestNodeState();
}

class _ChestNodeState extends State<_ChestNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  double _bottomOffset = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.isUnlocked) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      )..repeat(reverse: true);
      _scaleAnim = Tween<double>(begin: 1.0, end: 1.06).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
    } else {
      _controller = AnimationController(vsync: this);
      _scaleAnim = const AlwaysStoppedAnimation(1.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canTap = widget.isUnlocked && widget.onTap != null;

    return GestureDetector(
      onTapDown: canTap ? (_) => setState(() => _bottomOffset = 4.0) : null,
      onTapUp: canTap
          ? (_) {
              setState(() => _bottomOffset = 0.0);
              widget.onTap!();
            }
          : null,
      onTapCancel: canTap ? () => setState(() => _bottomOffset = 0.0) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnim.value,
            child: Transform.translate(
              offset: Offset(0, -_bottomOffset),
              child: SvgPicture.asset(
                widget.isUnlocked
                    ? Assets.svgs.homeChestEnabledButtonIcon.path
                    : Assets.svgs.homeChestDisabledButtonIcon.path,
                width: 86,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
