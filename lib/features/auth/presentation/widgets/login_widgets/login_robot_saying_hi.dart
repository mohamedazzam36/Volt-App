import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';

class LoginRobotSayingHi extends StatelessWidget {
  const LoginRobotSayingHi(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SpeakingRobot(
      message: message,
      robotImagePath: Assets.images.authRobotSaysHi.path,
      messageShiftingRatio: .58,
      spaceAfterMessage: 6,
      robotWidth: (context.width * 0.25).clamp(100.0, 150.0),
    );
  }
}
