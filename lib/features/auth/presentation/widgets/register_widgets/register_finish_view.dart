import 'package:flutter/material.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_finish_loading_view.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_term_footer.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_finish_body.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_finish_header.dart';

class RegisterFinishView extends StatelessWidget {
  final String name;
  final String email;
  final int age;

  const RegisterFinishView({
    super.key,
    required this.name,
    required this.email,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceSubtle,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: RegisterFinishHeader(),
            ),
            SliverToBoxAdapter(
              child: RegisterFinishBody(
                name: name,
                email: email,
                age: age,
                onSubmit: () {
                  context.push(const AuthFinishLoadingView());
                },
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AuthTermsFooter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
