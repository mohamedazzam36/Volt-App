import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/features/home/presentation/widgets/level_node_button.dart';
import 'package:volt/features/home/presentation/widgets/robot_with_base.dart';

class LevelNode extends StatelessWidget {
  final int index;
  const LevelNode({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double alignX = math.sin(index * 0.5 + 1.4) * 0.4;

    bool isUnlocked = index <= 1;
    bool isChest = index == 3 || index == 8 || index == 13;

    bool hasRobot = index == 1 || index == 4 || index == 8 || index == 15 || index == 19;

    bool robotOnLeft = alignX >= 0;

    return Align(
      alignment: Alignment(alignX, 0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          isChest
              ? SvgPicture.asset(
                  isUnlocked
                      ? Assets.svgs.homeChestEnabledButtonIcon.path
                      : Assets.svgs.homeChestDisabledButtonIcon.path,
                  width: 76,
                )
              : isUnlocked
              ? LevelNodeButton.unlocked(
                  iconPath: index == 0
                      ? Assets.svgs.homeStarButtonIcon.path
                      : Assets.svgs.homeBookButtonIcon.path,
                  onTap: () {},
                )
              : LevelNodeButton.locked(
                  iconPath: Assets.svgs.homeLockButtonIcon.path,
                  onTap: () {},
                ),
          if (hasRobot)
            Positioned(
              left: robotOnLeft ? -(context.width * 0.4).clamp(170.0, 250.0) : null,
              right: !robotOnLeft ? -(context.width * 0.4).clamp(170.0, 250.0) : null,
              bottom: -10,
              child: RobotWithBase(
                imagePath: robotOnLeft
                    ? Assets.images.readingBookRobot.path
                    : Assets.images.blueAmazedRobot.path,
              ),
            ),
        ],
      ),
    );
  }
}
