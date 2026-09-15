import 'package:flutter/material.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/core/storage/pref_keys.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_data.dart';
import 'package:volt/features/onboarding/presentation/widgets/first_page_image.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextPage() {
    if (_currentIndex < OnboardingData.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      sl<CacheHelper>().setBool(PrefKeys.isOnboardingViewed, true);
      context.pushReplacementNamed(Routes.auth);
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
    final width = size.width;
    final height = size.height;

    final pages = OnboardingData.pages;
    final currentPage = pages[_currentIndex];

    final horizontalPadding = (width * 0.055).clamp(16.0, 28.0);
    final contentHeight = (height * 0.58).clamp(360.0, 460.0);
    return Scaffold(
      backgroundColor: currentPage.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0, top: 16.0),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: OnboardingHeader(
                  currentIndex: _currentIndex,
                  onSkipPressed: () {
                    sl<CacheHelper>().setBool(PrefKeys.isOnboardingViewed, true);
                    context.pushReplacementNamed(Routes.auth);
                  },
                ),
              ),
            ),

            const SizedBox(height: 60),

            SizedBox(
              height: contentHeight,
              width: double.infinity,

              child: PageView.builder(
                controller: _pageController,

                itemCount: OnboardingData.pages.length,

                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  final item = OnboardingData.pages[index];

                  final itemIsDarkBackground = index == 2;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    child: Column(
                      children: [
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
                                  ? AppStyles.bold16
                                        .responsive(context)
                                        .copyWith(
                                          color: AppColors.textOnBrand,
                                        )
                                  : AppStyles.bold16.responsive(context),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: contentHeight * 0.04,
                          width: double.infinity,

                          child: Center(
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: AppStyles.semiBold14
                                  .responsive(context)
                                  .copyWith(
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

            SizedBox(
              height: 8,
              child: Center(
                child: OnboardingIndicator(
                  currentIndex: _currentIndex,
                  itemCount: OnboardingData.pages.length,
                  activeColor: currentPage.buttonColor,
                ),
              ),
            ),
            const SizedBox(height: 8),

            CustomElevatedButton(
              onTap: _nextPage,
              text: currentPage.buttonText,
              backgroundColor: currentPage.buttonColor,
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
