import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/utils/validators.dart';
import 'package:volt/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_base_layout.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_buttons_section.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_hiding_eyes_robot.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_thinking_robot.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_worried_robot.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/forget_password_flow_view.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/forget_password_widget.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/login_robot_saying_hi.dart';

class LoginFlowView extends StatefulWidget {
  const LoginFlowView({super.key});

  @override
  State<LoginFlowView> createState() => _LoginFlowViewState();
}

class _LoginFlowViewState extends State<LoginFlowView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Timer? _emailDebounce;
  Timer? _passwordDebounce;

  bool _isEmailValid = false;
  String? _emailError;
  String? _passwordError;
  bool _isPasswordVisible = false;
  bool _hasStartedTypingPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailDebounce?.cancel();
    _passwordDebounce?.cancel();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    if (_emailDebounce?.isActive ?? false) _emailDebounce!.cancel();

    setState(() {
      _isEmailValid = false;
      _emailError = null;
    });

    _emailDebounce = Timer(const Duration(milliseconds: 500), () {
      final error = AppValidators.validateEmail(value);
      if (error == null && value.isNotEmpty) {
        setState(() {
          _isEmailValid = true;
        });
      }
    });
  }

  void _onPasswordChanged(String value) {
    if (_passwordDebounce?.isActive ?? false) _passwordDebounce!.cancel();

    setState(() {
      _passwordError = null;
      if (value.isNotEmpty) {
        _hasStartedTypingPassword = true;
      }
    });

    _passwordDebounce = Timer(const Duration(milliseconds: 500), () {
      // لا نعرض خطأ أثناء الكتابة في اللوجن
    });
  }

  void _onSubmit(BuildContext context) {
    if (_emailDebounce?.isActive ?? false) _emailDebounce!.cancel();
    if (_passwordDebounce?.isActive ?? false) _passwordDebounce!.cancel();

    final emailError = AppValidators.validateEmail(_emailController.text);
    final passwordError = AppValidators.validatePassword(_passwordController.text);

    setState(() {
      if (emailError != null) {
        _emailError = AuthStrings.invalidEmailError;
        _isEmailValid = false;
      } else {
        _emailError = null;
        _isEmailValid = true;
      }

      if (passwordError != null) {
        _passwordError = passwordError;
      } else {
        _passwordError = null;
      }
    });

    // لو مفيش أخطاء، نعمل لوجن
    if (emailError == null && passwordError == null) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  /// بتحدد الروبوت والرسالة حسب الحالة الحالية
  Widget _buildRobot() {
    // لو فيه أي error (إيميل أو باسورد)
    if (_emailError != null || _passwordError != null) {
      return AuthWorriedRobot(robotWidth: (context.width * 0.2).clamp(60.0, 200.0));
    }

    // لو اليوزر لسه مبدأش يكتب الباسورد
    if (!_hasStartedTypingPassword) {
      return const LoginRobotSayingHi(AuthStrings.welcomeBack);
    }

    if (_isPasswordVisible) {
      return AuthThinkingRobot(
        AuthStrings.okWillLookABit,
        robotWidth: (context.width * 0.2).clamp(60.0, 200.0),
      );
    }

    // لو الباسورد مخفي
    return AuthHidingEyesRobot(
      AuthStrings.dontWorryWontLook,
      robotWidth: (context.width * 0.2).clamp(60.0, 200.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.pushNamedAndRemoveAll(Routes.authReady);
          } else if (state is LoginError) {
            context.showSnackBar(state.errorMessage, type: SnackBarType.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return PopScope(
            canPop: !isLoading,
            child: AuthBaseLayout(
              appBarButtonText: AuthStrings.createAccount,
              onAppBarButtonTap: isLoading
                  ? () {}
                  : () => context.pushAboveNamed(Routes.auth, Routes.register),
              onBackTap: isLoading ? () {} : null,
              child: IgnorePointer(
                ignoring: isLoading,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLoading ? 0.5 : 1.0,
                  child: Column(
                    children: [
                      // الروبوت
                      _buildRobot(),
                      const SizedBox(height: 40),

                      // حقل الإيميل
                      AuthTextField.email(
                        controller: _emailController,
                        hintText: AuthStrings.emailOrUsernameHint,
                        onChanged: _onEmailChanged,
                        isValid: _isEmailValid,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 16),

                      // حقل الباسورد
                      AuthTextField.password(
                        controller: _passwordController,
                        onChanged: _onPasswordChanged,
                        errorText: _passwordError,
                        obscureText: !_isPasswordVisible,
                        onVisibilityToggle: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 8),

                      ForgetPasswordWidget(
                        onTap: () {
                          context.push(
                            BlocProvider(
                              create: (context) => sl<LoginCubit>(),
                              child: const ForgetPasswordFlowView(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),

                      AuthButtonsSection(
                        isValid: _isEmailValid && _passwordController.text.isNotEmpty && !isLoading,
                        buttonText: AuthStrings.loginButton,
                        activeColor: AppColors.brandSecondaryBlue,
                        onMainButtonTap: isLoading ? () {} : () => _onSubmit(context),
                        onGoogleTap: () {
                          debugPrint('Google tapped...');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
