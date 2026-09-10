import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_app_bar.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_term_footer.dart';
import 'package:volt/features/auth/presentation/widgets/register_view/register_email_input_body.dart';

class RegisterInputView extends StatelessWidget {
  const RegisterInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDefault, // غيرتها للأبيض الصريح عشان توافق الديزاين
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: AuthAppBar(buttonText: AuthStrings.login, onButtonTap: () {}),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: (context.height * .05).clamp(32, 70),
                ),
              ),
              const SliverToBoxAdapter(
                child: RegisterEmailInputBody(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AuthTermsFooter(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
