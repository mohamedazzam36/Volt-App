import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/utils/validators.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_google_button.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_header/auth_thinking_robot.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_or_widget.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';

class RegisterEmailInputBody extends StatefulWidget {
  const RegisterEmailInputBody({super.key});

  @override
  State<RegisterEmailInputBody> createState() => _RegisterEmailInputBodyState();
}

class _RegisterEmailInputBodyState extends State<RegisterEmailInputBody> {
  final TextEditingController _emailController = TextEditingController();
  Timer? _debounce;

  bool _isValid = false;
  String? _errorText;

  @override
  void dispose() {
    _debounce?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    setState(() {
      _isValid = false;
      _errorText = null;
    });

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final error = AppValidators.validateEmail(value);
      if (error == null && value.isNotEmpty) {
        setState(() {
          _isValid = true;
        });
      }
    });
  }

  void _onSubmit() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final error = AppValidators.validateEmail(_emailController.text);

    setState(() {
      if (error != null) {
        _errorText = error;
        _isValid = false;
      } else {
        _errorText = null;
        _isValid = true;
        debugPrint('Navigating to next step...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isValid
            ? SpeakingRobot(
                message: AuthStrings.validEmailMessage,
                robotImagePath: Assets.images.authRobotHappy.path,
                messageShiftingRatio: 0.52,
                spaceAfterMessage: 6,
                robotWidth: (context.width * 0.4).clamp(150.0, 250.0),
              )
            : const AuthThinkingRobot(AuthStrings.askEmail),
        const SizedBox(height: 40),
        AuthTextField.email(
          controller: _emailController,
          onChanged: _onEmailChanged,
          isValid: _isValid,
          errorText: _errorText,
        ),
        const SizedBox(height: 32),
        CustomElevatedButton(
          onTap: _onSubmit,
          backgroundColor: _isValid ? AppColors.brandSecondaryBlue : AppColors.neutralSlate,
          textColor: Colors.white,
          text: CommonStrings.next,
          width: double.infinity,
        ),
        const SizedBox(height: 24),
        const AuthOrWidget(),
        const SizedBox(height: 24),
        AuthGoogleButton(
          onTap: () {},
        ),
      ],
    );
  }
}
