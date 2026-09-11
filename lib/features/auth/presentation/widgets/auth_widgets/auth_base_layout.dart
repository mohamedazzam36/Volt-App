import 'package:flutter/material.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_app_bar.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_term_footer.dart';

class AuthBaseLayout extends StatelessWidget {
  final String? appBarButtonText;
  final VoidCallback? onAppBarButtonTap;
  final VoidCallback? onBackTap;
  final Widget child;
  final bool showFooter;
  final Color? backgroundColor;

  const AuthBaseLayout({
    super.key,
    this.appBarButtonText,
    this.onAppBarButtonTap,
    required this.child,
    this.showFooter = true,
    this.onBackTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.surfaceDefault,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: AuthAppBar(
                  buttonText: appBarButtonText,
                  onButtonTap: onAppBarButtonTap,
                  onBackTap: onBackTap,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: (context.height * .05).clamp(32, 70),
                ),
              ),

              // الـ Body اللي هيتغير حسب الشاشة
              SliverToBoxAdapter(
                child: child,
              ),

              // الفوتر الثابت في آخر الشاشة
              if (showFooter) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AuthTermsFooter(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
