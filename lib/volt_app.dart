import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomElevatedButton(
            onTap: () {
              print(2);
            },
            text: "next",

            color: const Color(0xffE77C10),
            bottomColor: const Color(0xffEF9420),
          ),
        ),
      ),
    );
  }
}
