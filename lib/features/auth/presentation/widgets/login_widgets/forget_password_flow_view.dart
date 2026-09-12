import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/utils/validators.dart';
import 'package:volt/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_base_layout.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/check_email_body.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/forget_password_body.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/reset_password_body.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/verify_otp_body.dart';

class ForgetPasswordFlowView extends StatefulWidget {
  const ForgetPasswordFlowView({super.key});

  @override
  State<ForgetPasswordFlowView> createState() => _ForgetPasswordFlowViewState();
}

class _ForgetPasswordFlowViewState extends State<ForgetPasswordFlowView> {
  int _currentStep = 0; // 0: Forget, 1: CheckEmail, 2: VerifyOtp, 3: ResetPassword

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _otpCode = '';
  String _resetToken = '';

  bool _isEmailValid = false;
  String? _emailError;
  bool _isPasswordVisible = false;
  bool _hasEmptyOtpError = false;

  Timer? _emailDebounce;
  Timer? _countdownTimer;
  int _remainingSeconds = 47;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailDebounce?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    if (_emailDebounce?.isActive ?? false) _emailDebounce!.cancel();

    if (_emailError != null) {
      setState(() {
        _emailError = null;
      });
    }

    _emailDebounce = Timer(const Duration(milliseconds: 500), () {
      final error = AppValidators.validateEmail(value);
      setState(() {
        _isEmailValid = error == null && value.isNotEmpty;
      });
    });
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _remainingSeconds = 47;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
    if (_currentStep == 2) {
      _startCountdown();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep = 0;
      });
    } else {
      context.pop();
    }
  }

  void _backToLogin() {
    context.pop();
  }

  Color _getBackgroundColor() {
    switch (_currentStep) {
      case 0:
        return AppColors.surfaceOrangeSoft; // Coral
      case 1:
        return const Color(0xffEFEAFE); // Light Purple
      case 2:
        return AppColors.surfaceDefault; // White
      case 3:
        return AppColors.surfaceGreenSoft; // Light Green
      default:
        return AppColors.surfaceDefault;
    }
  }

  Widget _getCurrentStep(bool isLoading, bool hasOtpError) {
    switch (_currentStep) {
      case 0:
        return ForgetPasswordBody(
          emailController: _emailController,
          isEmailValid: _isEmailValid,
          emailError: _emailError,
          onEmailChanged: _onEmailChanged,
          isLoading: isLoading,
          onBackToLogin: _backToLogin,
          onSubmit: () {
            final error = AppValidators.validateEmail(_emailController.text);
            if (error != null) {
              setState(() {
                _emailError = AuthStrings.invalidEmailError;
                _isEmailValid = false;
              });
              return;
            }
            setState(() {
              _emailError = null;
              _isEmailValid = true;
            });
            context.read<LoginCubit>().forgetPassword(_emailController.text.trim());
          },
        );
      case 1:
        return CheckEmailBody(
          onNext: _nextStep,
          onBackToLogin: _backToLogin,
        );
      case 2:
        return VerifyOtpBody(
          onOtpChanged: (value) {
            setState(() {
              _otpCode = value;
              if (_hasEmptyOtpError) _hasEmptyOtpError = false;
            });
          },
          hasError: hasOtpError,
          showEmptyError: _hasEmptyOtpError,
          isLoading: isLoading,
          remainingSeconds: _remainingSeconds,
          isOtpComplete: _otpCode.length == 6,
          onResend: () {
            _startCountdown();
            context.read<LoginCubit>().forgetPassword(_emailController.text.trim());
          },
          onSubmit: () {
            if (_otpCode.length < 6) {
              setState(() {
                _hasEmptyOtpError = true;
              });
              context.showSnackBar(AuthStrings.enterFullOtpError, type: SnackBarType.error);
              return;
            }
            context.read<LoginCubit>().verifyOtpCode(
              email: _emailController.text.trim(),
              otpCode: _otpCode,
            );
          },
          onBackToLogin: _backToLogin,
        );
      case 3:
        return ResetPasswordBody(
          passwordController: _passwordController,
          isPasswordVisible: _isPasswordVisible,
          isLoading: isLoading,
          onVisibilityToggle: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          onPasswordChanged: (val) {},
          onSubmit: () {
            final error = AppValidators.validatePassword(_passwordController.text);
            if (error != null) {
              context.showSnackBar(error, type: SnackBarType.error);
              return;
            }
            context.read<LoginCubit>().resetPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
              resetToken: _resetToken,
            );
          },
          onBackToLogin: _backToLogin,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          if (_currentStep == 0) {
            _nextStep();
          } else if (_currentStep == 2) {
            context.showSnackBar('تم إعادة الإرسال بنجاح', type: SnackBarType.success);
          }
        } else if (state is ForgetPasswordError) {
          context.showSnackBar(state.errorMessage, type: SnackBarType.error);
        } else if (state is VerifyOtpSuccess) {
          _resetToken = state.resetToken;
          _nextStep();
        } else if (state is VerifyOtpError) {
          context.showSnackBar(AuthStrings.invalidCodeError, type: SnackBarType.error);
        } else if (state is ResetPasswordSuccess) {
          context.showSnackBar('تم إعادة تعيين كلمة المرور بنجاح!', type: SnackBarType.success);
          context.pushAboveNamed(Routes.auth, Routes.login);
        } else if (state is ResetPasswordError) {
          context.showSnackBar(state.errorMessage, type: SnackBarType.error);
        }
      },
      builder: (context, state) {
        final bool isLoading =
            state is ForgetPasswordLoading ||
            state is VerifyOtpLoading ||
            state is ResetPasswordLoading;

        final bool hasOtpError = state is VerifyOtpError;

        return PopScope(
          canPop: _currentStep == 0 && !isLoading,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (isLoading) return;
            _previousStep();
          },
          child: AuthBaseLayout(
            backgroundColor: _getBackgroundColor(),
            onBackTap: isLoading ? () {} : _previousStep,
            showFooter: false,
            child: IgnorePointer(
              ignoring: isLoading,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLoading ? 0.5 : 1.0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.05, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<int>(_currentStep),
                    child: _getCurrentStep(isLoading, hasOtpError),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
