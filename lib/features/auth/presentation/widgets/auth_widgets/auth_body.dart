import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/message_widget/message_widget.dart';

class AuthBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const MessageWidget(RobotStrings.startAdventure),
        Assets.images.rasingLeftHandRobot.image(
          width: (context.width * 0.5).clamp(100, 300),
        ),
      ],
    );
  }
}
