import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/utils/validators.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_buttons_section.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_hiding_eyes_robot.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_thinking_robot.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/password_strength_indicator.dart';

class RegisterPasswordInputBody extends StatefulWidget {
  const RegisterPasswordInputBody({
    super.key,
    required this.onNextStep,
    required this.passwordController,
  });
  final VoidCallback onNextStep;
  final TextEditingController passwordController;

  @override
  State<RegisterPasswordInputBody> createState() => _RegisterPasswordInputBodyState();
}

class _RegisterPasswordInputBodyState extends State<RegisterPasswordInputBody> {
  Timer? _debounce;

  bool _isValid = false;
  String? _errorText;
  int _passwordStrength = 0;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.passwordController.text.isNotEmpty) {
      final text = widget.passwordController.text;
      _passwordStrength = AppValidators.calculatePasswordStrength(text);
      final error = AppValidators.validatePassword(text);
      if (error == null) _isValid = true;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    setState(() {
      _passwordStrength = AppValidators.calculatePasswordStrength(value);
      _isValid = false;
      _errorText = null;
    });

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final error = AppValidators.validatePassword(value);
      if (error == null && value.isNotEmpty) {
        setState(() {
          _isValid = true;
        });
      }
    });
  }

  void _onSubmit() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final error = AppValidators.validatePassword(widget.passwordController.text);

    setState(() {
      if (error != null) {
        _errorText = error;
        _isValid = false;
      } else {
        _errorText = null;
        _isValid = true;
        widget.onNextStep();
      }
    });
  }

  String _getRobotMessage() {
    if (_isPasswordVisible) return AuthStrings.robotWillLook;
    if (_isValid) return AuthStrings.strongPassword;
    return AuthStrings.robotWontLook;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isPasswordVisible
            ? AuthThinkingRobot(_getRobotMessage())
            : AuthHidingEyesRobot(_getRobotMessage()),
        const SizedBox(height: 40),

        AuthTextField.password(
          controller: widget.passwordController,
          onChanged: _onPasswordChanged,
          errorText: _errorText,
          obscureText: !_isPasswordVisible,
          onVisibilityToggle: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 12),
        PasswordStrengthIndicator(strength: _passwordStrength),
        const SizedBox(height: 32),
        AuthButtonsSection(
          isValid: _isValid,
          buttonText: CommonStrings.next,
          activeColor: AppColors.brandSecondaryOrange,
          onMainButtonTap: _onSubmit,
          onGoogleTap: () {
            debugPrint('Google tapped...');
          },
        ),
      ],
    );
  }
}
