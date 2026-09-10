import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class CustomAgeSlider extends StatelessWidget {
  final double currentAge;
  final ValueChanged<double> onChanged;

  const CustomAgeSlider({
    super.key,
    required this.currentAge,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const double minAge = 6;
    const double maxAge = 13;
    const int divisions = 7;
    const double overlayRadius = 20.0;

    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            activeTrackColor: AppColors.brandSecondaryGreen,
            inactiveTrackColor: AppColors.surfaceSubtle.withValues(alpha: 0.5),
            trackHeight: 6.0,

            thumbShape: const CustomSliderThumbCircle(
              thumbRadius: 10.0,
              thumbColor: AppColors.brandSecondaryGreen,
              borderColor: AppColors.surfaceDefault,
              borderWidth: 2,
            ),
            overlayColor: AppColors.brandSecondaryGreen.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: overlayRadius),
            trackShape: const RoundedRectSliderTrackShape(),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: Slider(
            value: currentAge,
            min: minAge,
            max: maxAge,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),

        CustomPaint(
          size: const Size(double.infinity, 12.0),
          painter: AgeSliderTicksPainter(
            minAge: minAge.toInt(),
            maxAge: maxAge.toInt(),
            divisions: divisions,
            currentAge: currentAge.toInt(),
            overlayRadius: overlayRadius,
            isRtl: isRtl,
            normalTextColor: AppColors.textDisabled,
            selectedTextColor: AppColors.brandSecondaryGreen,
          ),
        ),
      ],
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbColor;
  final Color borderColor;
  final double borderWidth;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.thumbColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Path shadowPath = Path()
      ..addArc(Rect.fromCircle(center: center, radius: thumbRadius), 0, 3.14 * 2);
    canvas.drawShadow(shadowPath, Colors.black45, 4.0, true);

    final Paint fillPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, fillPaint);

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}

class AgeSliderTicksPainter extends CustomPainter {
  final int minAge;
  final int maxAge;
  final int divisions;
  final int currentAge;
  final double overlayRadius;
  final bool isRtl;
  final Color normalTextColor;
  final Color selectedTextColor;

  AgeSliderTicksPainter({
    required this.minAge,
    required this.maxAge,
    required this.divisions,
    required this.currentAge,
    required this.overlayRadius,
    required this.isRtl,
    required this.normalTextColor,
    required this.selectedTextColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double trackWidth = size.width - (overlayRadius * 2);
    final double spacing = trackWidth / divisions;

    for (int i = 0; i <= divisions; i++) {
      int age = minAge + i;
      bool isSelected = age == currentAge;

      TextSpan span = TextSpan(
        style: AppStyles.bold16.copyWith(color: isSelected ? selectedTextColor : normalTextColor),
        text: '$age',
      );

      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      );
      tp.layout();

      double xCenter = isRtl
          ? size.width - overlayRadius - (i * spacing)
          : overlayRadius + (i * spacing);
      double xOffset = xCenter - (tp.width / 2);

      tp.paint(canvas, Offset(xOffset, 5.0));
    }
  }

  @override
  bool shouldRepaint(covariant AgeSliderTicksPainter oldDelegate) {
    return oldDelegate.currentAge != currentAge || oldDelegate.isRtl != isRtl;
  }
}
