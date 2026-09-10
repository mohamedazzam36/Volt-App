import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_base_layout.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_age_input_body.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_email_input_body.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_name_input_body.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_password_input_body.dart';

class RegisterFlowView extends StatefulWidget {
  const RegisterFlowView({super.key});

  @override
  State<RegisterFlowView> createState() => _RegisterFlowViewState();
}

class _RegisterFlowViewState extends State<RegisterFlowView> {
  int _currentStep = 0; // 0: Email, 1: Password, 2: Name...
  int _selectedAge = 10;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      context.pop(); // لو في أول خطوة وداس رجوع، يخرج بره خالص
    }
  }

  // 1. الميثود دي بره الـ build خالص
  Widget _getCurrentStep() {
    switch (_currentStep) {
      case 0:
        return RegisterEmailInputBody(
          emailController: _emailController, // 3. باصينا الكنترولر للودجت
          onNextStep: _nextStep,
        );
      case 1:
        return RegisterPasswordInputBody(
          passwordController: _passwordController, // 3. باصينا الكنترولر للودجت
          onNextStep: _nextStep,
        );
      case 2:
        return RegisterNameInputBody(
          nameController: _nameController,
          onNextStep: _nextStep,
        );
      case 3:
        return RegisterAgeInputBody(
          onAgeSelected: (age) {
            _selectedAge = age; // 2. بنحفظ العمر لما يدوس التالي
          },
          onNextStep: () {
            debugPrint('تم تسجيل البيانات: الاسم، الإيميل، والعمر: $_selectedAge');
            // هنا هتكلم الـ Cubit وتديله الداتا كلها
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _previousStep();
      },
      child: AuthBaseLayout(
        appBarButtonText: AuthStrings.login,
        onAppBarButtonTap: () => context.pushAboveNamed(Routes.auth, Routes.login),
        onBackTap: _previousStep,
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
          // 2. بتنادي عليها هنا بسطر واحد في منتهى الشياكة
          child: _getCurrentStep(),
        ),
      ),
    );
  }
}
