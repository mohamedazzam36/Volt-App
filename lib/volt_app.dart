import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/message_widget/message_widget.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaintTestWidget(),
    );
  }
}

class PaintTestWidget extends StatelessWidget {
  const PaintTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: MessageWidget(
            "dddddddffffffffffdيييييييييييlllllllllllllllllllllllllllllllllllllllllllllllllllllllيييييييييdddd",
          ),
        ),
      ),
    );
  }
}
