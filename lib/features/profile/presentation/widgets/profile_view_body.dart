import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // When logged out, navigate to Splash which handles auth routing
          context.pushNamedAndRemoveAll(Routes.splash);
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceBlueSoft,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.brandPrimary, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandPrimary.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SvgPicture.asset(
                          Assets.svgs.profileNavIcon.path,
                          colorFilter: const ColorFilter.mode(
                            AppColors.brandPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // User Name
                  Text(
                    user.fullName.isNotEmpty ? user.fullName : ProfileStrings.voltHero,
                    style: AppStyles.bold24.copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),

                  // Age
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceBlueSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${ProfileStrings.agePrefix} ${user.age} ${ProfileStrings.years}',
                      style: AppStyles.semiBold14.copyWith(color: AppColors.brandPrimary),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Role Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDefault,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.starAmber.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.star_rounded, color: AppColors.starAmber, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              ProfileStrings.role,
                              style: AppStyles.semiBold16.copyWith(color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        Text(
                          user.role == 'Child' ? ProfileStrings.child : ProfileStrings.parent,
                          style: AppStyles.bold16.copyWith(color: AppColors.brandPrimary),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                      icon: const Icon(Icons.logout_rounded, color: AppColors.textOnBrand),
                      label: Text(
                        ProfileStrings.logout,
                        style: AppStyles.bold16.copyWith(color: AppColors.textOnBrand),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
