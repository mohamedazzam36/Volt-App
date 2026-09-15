import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/message_widget/message_widget.dart';

class TextContentBody extends StatelessWidget {
  const TextContentBody({super.key, required this.content, required this.isFirst});

  final String? content;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MessageWidget(
          content ?? "no content",
          isOneLine: false,
          maxWidth: 300,
        ),
        const SizedBox(
          height: 36,
        ),
        Image.asset(
          isFirst ? Assets.images.authRobotThinking.path : Assets.images.authRobotHappy.path,
          width: 200,
        ),
      ],
    );
  }
}
