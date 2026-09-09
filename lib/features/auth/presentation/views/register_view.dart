import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/register_view/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.surfaceOrangeSoft,
      body: RegisterViewBody(),
    );
  }
}
