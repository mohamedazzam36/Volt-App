import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';

class AuthWorriedRobot extends StatelessWidget {
  const AuthWorriedRobot({super.key, this.message = AuthStrings.inputErrorRobotMessage});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SpeakingRobot(
      message: message,
      robotImagePath: Assets.images.authRobotWorried.path,
      messageShiftingRatio: .65,
      spaceAfterMessage: 6,
      robotWidth: (context.width * 0.25).clamp(100.0, 200.0),
    );
  }
}
