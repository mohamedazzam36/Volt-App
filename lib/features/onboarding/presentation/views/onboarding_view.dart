import 'package:flutter/material.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_data.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  int _currentIndex = 0;

  static const _pageAnimationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextPage() {
    final pages = OnboardingData.pages;

    if (_currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: _pageAnimationDuration,
        curve: Curves.easeInOut,
      );
      return;
    }

    context.pushReplacementNamed(Routes.auth);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
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
            _buildHeader(isDark: currentPage.isDark),

            const Spacer(flex: 2),

            _buildPageView(
              pages: pages,
              contentHeight: contentHeight,
              horizontalPadding: horizontalPadding,
            ),

            const SizedBox(height: 12),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: OnboardingFooter(
                currentIndex: _currentIndex,
                currentPage: currentPage,
                onNext: _nextPage,
              ),
            ),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required bool isDark}) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: OnboardingHeader(
        currentIndex: _currentIndex,
        isDark: isDark,
        onSkipPressed: () {
          context.pushReplacementNamed(Routes.auth);
        },
      ),
    );
  }

  Widget _buildPageView({
    required List<OnboardingModel> pages,
    required double contentHeight,
    required double horizontalPadding,
  }) {
    return SizedBox(
      height: contentHeight,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return OnboardingPage(
            item: pages[index],
            index: index,
            contentHeight: contentHeight,
            horizontalPadding: horizontalPadding,
          );
        },
      ),
    );
  }
}
