import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/utils/validators.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_buttons_section.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_thinking_robot.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/surprice_me_widget.dart';

class RegisterNameInputBody extends StatefulWidget {
  final TextEditingController nameController;
  final VoidCallback onNextStep;

  const RegisterNameInputBody({
    super.key,
    required this.nameController,
    required this.onNextStep,
  });

  @override
  State<RegisterNameInputBody> createState() => _RegisterNameInputBodyState();
}

class _RegisterNameInputBodyState extends State<RegisterNameInputBody> {
  Timer? _debounce;
  bool _isValid = false;
  String? _errorText;
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.nameController.text.trim().isNotEmpty) {
      final error = AppValidators.validateName(widget.nameController.text);
      if (error == null) _isValid = true;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _onNameChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    setState(() {
      _isValid = false;
      _errorText = null;
    });

    _debounce = Timer(const Duration(milliseconds: 700), () {
      final text = value.trim();
      if (text.isEmpty) return;

      final error = AppValidators.validateName(text);
      if (error == null) {
        setState(() {
          _isValid = true;
        });
      }
    });
  }

  void _onSubmit() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final text = widget.nameController.text.trim();
    final error = AppValidators.validateName(text);

    setState(() {
      if (text.isEmpty || error != null) {
        _errorText = error ?? AuthStrings.emptyNameError;
        _isValid = false;
      } else {
        _errorText = null;
        _isValid = true;
        widget.onNextStep();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isValid
            ? SpeakingRobot(
                message: AuthStrings.greatRobotName,
                robotImagePath: Assets.images.authRobotHappy.path,
                messageShiftingRatio: 0.52,
                spaceAfterMessage: 6,
                robotWidth: (context.width * 0.4).clamp(150.0, 250.0),
              )
            : const AuthThinkingRobot(AuthStrings.askRobotName),

        const SizedBox(height: 40),

        AuthTextField.name(
          controller: widget.nameController,
          onChanged: _onNameChanged,
          isValid: _isValid,
          errorText: _errorText,
        ),

        const SizedBox(height: 8),

        Visibility(
          visible: _isValid,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 16, bottom: 12),
              child: SurpriseMeWidget(),
            ),
          ),
        ),

        AuthButtonsSection(
          isValid: _isValid,
          buttonText: CommonStrings.next,
          activeColor: AppColors.brandSecondaryPurple,
          onMainButtonTap: _onSubmit,
          onGoogleTap: () {
            debugPrint('Google tapped...');
          },
        ),
      ],
    );
  }
}
