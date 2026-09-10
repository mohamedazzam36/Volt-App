import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_app_bar_elevated_button.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key, required this.buttonText, required this.onButtonTap, this.padding});
  final String buttonText;
  final Function() onButtonTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          CustomAppBarElevatedButton(onTap: onButtonTap, text: buttonText),
        ],
      ),
    );
  }
}
