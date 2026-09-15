import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/message_widget/message_widget.dart';

class TextAndImageContentBody extends StatelessWidget {
  final String? content;
  final String? mediaUrl;
  final bool isFirst;
  const TextAndImageContentBody({
    super.key,
    required this.content,
    required this.mediaUrl,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 43,
      children: [
        MessageWidget(
          content ?? "no content",
          isOneLine: false,
          maxWidth: 300,
        ),
        Image.asset(
          isFirst ? Assets.images.authRobotThinking.path : Assets.images.authRobotHappy.path,
          width: 150,
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 300,
          ),
          child: CachedNetworkImage(
            imageUrl: mediaUrl ?? "",
            placeholder: (context, url) => const SizedBox(
              height: 110,
              width: 110,
            ),
            errorWidget: (context, url, error) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
