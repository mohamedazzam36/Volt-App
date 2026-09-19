import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/core/storage/pref_keys.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class PersonalInfoViewBody extends StatelessWidget {
  const PersonalInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cachedData = sl<CacheHelper>().getString(PrefKeys.cachedUserData);
    String name = ProfileStrings.voltHero;
    String age = '';
    String email = '';

    if (cachedData != null) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        name = decoded['fullName'] ?? ProfileStrings.voltHero;
        age = decoded['age']?.toString() ?? '';
        email = decoded['email'] ?? '';
      } catch (e) {
        // ignore parsing error
      }
    }

    return Column(
      children: [
        // Header with curved background and avatar
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 24.0, left: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.surfaceDefault,
                        ),
                      ),
                      Text(
                        ProfileStrings.personalInfo,
                        style: AppStyles.bold20
                            .responsive(context)
                            .copyWith(
                              color: AppColors.surfaceDefault,
                            ),
                      ),
                      const SizedBox(width: 24), // Placeholder for symmetry
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE2F0FD),
                      border: Border.all(color: AppColors.surfaceDefault, width: 4),
                      image: DecorationImage(
                        image: AssetImage(Assets.images.authRobotDanceWithBackground.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF55A6F8),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceDefault, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.surfaceDefault,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 80),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, ProfileStrings.basicInfo),
                _buildInfoField(context, label: ProfileStrings.name, value: name),
                const SizedBox(height: 16),
                _buildInfoField(context, label: ProfileStrings.age, value: age),

                const SizedBox(height: 32),

                _buildSectionTitle(context, ProfileStrings.contactInfo),
                _buildInfoField(context, label: ProfileStrings.email, value: email),

                const SizedBox(height: 48),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDefault,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFF55A6F8), width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              ProfileStrings.cancel,
                              style: AppStyles.bold16
                                  .responsive(context)
                                  .copyWith(
                                    color: const Color(0xFF55A6F8),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // TODO: Implement Save
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF55A6F8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              ProfileStrings.save,
                              style: AppStyles.bold16
                                  .responsive(context)
                                  .copyWith(
                                    color: AppColors.surfaceDefault,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: AppStyles.bold16
            .responsive(context)
            .copyWith(
              color: AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildInfoField(BuildContext context, {required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDefault.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.medium12
                .responsive(context)
                .copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppStyles.semiBold14
                .responsive(context)
                .copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
