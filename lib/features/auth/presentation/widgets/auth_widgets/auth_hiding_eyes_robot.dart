import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';

class AuthHidingEyesRobot extends StatelessWidget {
  const AuthHidingEyesRobot(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SpeakingRobot(
      message: message,
      robotImagePath: Assets.images.authRobotHidingHisEyes.path,
      messageShiftingRatio: .5,
      spaceAfterMessage: 6,
      robotWidth: (context.width * 0.25).clamp(100.0, 200.0),
    );
  }
}
