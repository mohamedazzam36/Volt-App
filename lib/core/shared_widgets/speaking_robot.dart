import 'package:flutter/material.dart';

import '../extensions/ui_extension.dart';
import 'message_widget/message_widget.dart';

class SpeakingRobot extends StatelessWidget {
  final String message;
  final String robotImagePath;
  final double? robotWidth;

  final double messageShiftingRatio;
  final double spaceAfterMessage;
  final double messageHorizontalOffset;
  final bool isMessageOneLine;

  const SpeakingRobot({
    super.key,
    required this.message,
    required this.robotImagePath,
    this.robotWidth,
    this.messageShiftingRatio = 0.5,
    this.isMessageOneLine = true,
    this.spaceAfterMessage = 10,
    this.messageHorizontalOffset = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    final double defaultRobotWidth = (context.width * 0.45).clamp(140.0, 300.0);
    final double robotFinalWidth = robotWidth ?? defaultRobotWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: spaceAfterMessage,
      children: [
        Transform.translate(
          offset: Offset(
            (messageShiftingRatio - 0.5) * robotFinalWidth + messageHorizontalOffset,
            0,
          ),
          child: MessageWidget(
            message,
            isOneLine: isMessageOneLine,
          ),
        ),

        Transform.translate(
          offset: Offset(-messageHorizontalOffset * 0.5, 0),
          child: Image.asset(
            robotImagePath,
            width: robotFinalWidth,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
