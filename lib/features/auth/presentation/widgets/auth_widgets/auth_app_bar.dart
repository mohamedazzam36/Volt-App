import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/custom_app_bar_elevated_button.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    super.key,
    required this.buttonText,
    required this.onButtonTap,
    this.padding,
    this.onBackTap,
  });
  final String buttonText;
  final Function() onButtonTap;
  final VoidCallback? onBackTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap:
                onBackTap ??
                () {
                  Navigator.pop(context);
                },
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
          ),
          CustomAppBarElevatedButton(onTap: onButtonTap, text: buttonText),
        ],
      ),
    );
  }
}
