import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';

class GreenThinkingRobot extends StatelessWidget {
  const GreenThinkingRobot(this.message, {super.key, this.robotWidth});
  final String message;
  final double? robotWidth;

  @override
  Widget build(BuildContext context) {
    return SpeakingRobot(
      message: message,
      robotImagePath: Assets.images.greenRobotThinking.path,
      messageShiftingRatio: .65,
      spaceAfterMessage: 6,
      robotWidth: robotWidth ?? (context.width * 0.35).clamp(100.0, 200.0),
    );
  }
}
