import 'package:flutter/material.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/clouds_header.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/waves_footer.dart';

class AppCloudsBackgroundLayout extends StatelessWidget {
  const AppCloudsBackgroundLayout({
    super.key,
    required this.bodyWidget,
    required this.bottomBaseColor,
    this.bottomTopWaveColor,
    this.bottomConnectorColor = const Color(0xFF2E7D32),
    this.headerStartFromLeft = false,
  });

  final Widget bodyWidget;
  final Color bottomBaseColor;
  final Color? bottomTopWaveColor;
  final Color bottomConnectorColor;
  final bool headerStartFromLeft;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: CloudsHeader(startFromLeft: headerStartFromLeft)),
          SliverToBoxAdapter(child: SizedBox(height: (context.height * .04).clamp(16, 32))),
          SliverToBoxAdapter(child: bodyWidget),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.zero,
              child: WavesFooter(
                baseColor: bottomBaseColor,
                topWaveColor: bottomTopWaveColor,
                connectorColor: bottomConnectorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
