import 'package:flutter/material.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_footer/auth_footer_painter.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.baseColor,
    this.topWaveColor,
    this.connectorColor = const Color(0xFF2E7D32),
  });
  final Color baseColor;
  final Color? topWaveColor;
  final Color connectorColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: (context.height * .2).clamp(140, 270),
        width: double.infinity,
        child: CustomPaint(
          painter: AuthFooterPainter(
            baseColor: baseColor,
            topWaveColor: topWaveColor ?? baseColor.withValues(alpha: 0.55),
            connectorColor: connectorColor,
          ),
        ),
      ),
    );
  }
}
