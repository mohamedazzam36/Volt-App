import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/core/storage/pref_keys.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cachedData = sl<CacheHelper>().getString(PrefKeys.cachedUserData);
    String name = ProfileStrings.voltHero;
    String email = '';

    if (cachedData != null) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        name = decoded['fullName'] ?? ProfileStrings.voltHero;
        email = decoded['email'] ?? '';
      } catch (e) {
        // ignore parsing error
      }
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.pushNamedAndRemoveAll(Routes.auth);
        }
      },
      child: Column(
        children: [
          // Header with curved background and user card
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF55A6F8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        ProfileStrings.account,
                        style: AppStyles.bold20
                            .responsive(context)
                            .copyWith(
                              color: AppColors.surfaceDefault,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -45,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDefault,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2F0FD), width: 3),
                          image: DecorationImage(
                            image: AssetImage(Assets.images.authRobotDanceWithBackground.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: AppStyles.bold16
                                  .responsive(context)
                                  .copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email,
                              style: AppStyles.medium12
                                  .responsive(context)
                                  .copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to right (Arabic)
                children: [
                  // section 1
                  _buildSectionTitle(context, ProfileStrings.account),
                  _buildListTile(
                    context,
                    title: ProfileStrings.personalInfo,
                    icon: Icons.person_outline_rounded,
                    onTap: () {
                      context.pushNamed(Routes.personalInfo);
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: ProfileStrings.changePassword,
                    icon: Icons.lock_outline_rounded,
                    onTap: () {
                      // TODO: Implement Change Password
                    },
                  ),
                  const SizedBox(height: 24),

                  // section 2
                  _buildSectionTitle(context, ProfileStrings.supportAndSettings),
                  _buildListTile(
                    context,
                    title: ProfileStrings.settings,
                    icon: Icons.settings_outlined,
                    onTap: () {
                      // TODO: Implement Settings
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: ProfileStrings.help,
                    icon: Icons.info_outline_rounded,
                    onTap: () {
                      // TODO: Implement Help
                    },
                  ),
                  _buildDivider(),
                  _buildListTile(
                    context,
                    title: ProfileStrings.termsAndConditions,
                    icon: Icons.shield_outlined,
                    onTap: () {
                      // TODO: Implement Terms and Conditions
                    },
                  ),
                  const SizedBox(height: 24),

                  // section 3
                  _buildSectionTitle(context, ProfileStrings.accountActions),
                  const SizedBox(height: 8),

                  // Logout Button
                  InkWell(
                    onTap: () {
                      context.read<AuthCubit>().logout();
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE8E8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFFE53935),
                          ), // Using generic back arrow as placeholder for logout
                          const SizedBox(width: 8),
                          Text(
                            ProfileStrings.logout,
                            style: AppStyles.medium14
                                .responsive(context)
                                .copyWith(
                                  color: const Color(0xFFE53935),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Delete Account Button
                  InkWell(
                    onTap: () {
                      // TODO: Implement Delete Account
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cancel_outlined, color: Color(0xFFE53935)),
                          const SizedBox(width: 8),
                          Text(
                            ProfileStrings.deleteAccount,
                            style: AppStyles.medium14
                                .responsive(context)
                                .copyWith(
                                  color: const Color(0xFFE53935),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: AppStyles.semiBold14
            .responsive(context)
            .copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF55A6F8),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppStyles.semiBold14
                  .responsive(context)
                  .copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),

            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF55A6F8),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppColors.borderDefault.withValues(alpha: 0.5),
      height: 1,
    );
  }
}
