import 'package:flutter/material.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
import 'package:volt/features/onboarding/presentation/widgets/first_page_image.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  // ============================================================
  // PAGE NAVIGATION
  // ============================================================

  void _nextPage() {
    if (_currentIndex < OnboardingModel.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pushReplacementNamed(Routes.auth);
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final screenWidth = size.width;
    final screenHeight = size.height;

    final currentPage = OnboardingModel.pages[_currentIndex];

    final horizontalPadding = (screenWidth * 0.055).clamp(
      16.0,
      28.0,
    );

    final contentHeight = (screenHeight * 0.59).clamp(
      350.0,
      445.0,
    );

    return Scaffold(
      backgroundColor: currentPage.backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            // ========================================================
            // HEADER
            // ========================================================

            SizedBox(
              height: 48,
              width: double.infinity,
              child: OnboardingHeader(
                currentIndex: _currentIndex,
                onBackPressed: _previousPage,
                onLoginPressed: () {
                  // TODO: Handle login
                },
              ),
            ),

            const SizedBox(height: 60),

            SizedBox(
              height: contentHeight,
              width: double.infinity,

              child: PageView.builder(
                controller: _pageController,

                itemCount: OnboardingModel.pages.length,

                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  final item = OnboardingModel.pages[index];

                  final itemIsDarkBackground = index == 2;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    child: Column(
                      children: [
                        // ==================================================
                        // IMAGE
                        // ==================================================

                        SizedBox(
                          height: contentHeight * 0.68,
                          width: double.infinity,

                          child: index == 0
                              ? FirstPageImage(
                                  imagePath: item.image,
                                )
                              : Image.asset(
                                  item.image,
                                  fit: BoxFit.contain,
                                ),
                        ),

                        // ==================================================
                        // TITLE
                        // ==================================================
                        SizedBox(
                          height: contentHeight * 0.13,
                          width: double.infinity,

                          child: Center(
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: itemIsDarkBackground
                                  ? AppStyles.bold16.responsive(context).copyWith(
                                      color: AppColors.textOnBrand,
                                    )
                                  : AppStyles.bold16.responsive(context),
                            ),
                          ),
                        ),

                        // ==================================================
                        // DESCRIPTION
                        // ==================================================
                        SizedBox(
                          height: contentHeight * 0.04,
                          width: double.infinity,

                          child: Center(
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: AppStyles.semiBold14.responsive(context).copyWith(
                                height: 1.3,
                                color: itemIsDarkBackground
                                    ? AppColors.textOnBrand.withValues(alpha: 0.7)
                                    : AppColors.neutralSlate,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ============================================================
            // INDICATOR
            // ============================================================
            SizedBox(
              height: 8,
              child: Center(
                child: OnboardingIndicator(
                  currentIndex: _currentIndex,
                  itemCount: OnboardingModel.pages.length,
                  activeColor: currentPage.buttonColor,
                ),
              ),
            ),
            const SizedBox(height: 8),

            CustomElevatedButton(
              onTap: _nextPage,
              text: currentPage.buttonText,
              color: currentPage.buttonColor,
            ),

            // ============================================================
            // BOTTOM SPACE
            // ============================================================
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
