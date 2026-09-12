import 'package:flutter/material.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_body.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_footer.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_header/auth_header.dart';

class AuthViewBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: AuthHeader()),
          SliverToBoxAdapter(child: SizedBox(height: (context.height * .04).clamp(16, 32))),
          const SliverToBoxAdapter(child: AuthBody()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.zero,
              child: AuthFooter(baseColor: AppColors.brandSecondaryGreen),
            ),
          ),
        ],
      ),
    );
  }
}
