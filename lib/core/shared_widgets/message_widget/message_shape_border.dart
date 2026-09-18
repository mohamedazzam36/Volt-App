import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MessageShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double thresholdHeight;

  const MessageShapeBorder({
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.borderRadius = 16.0,
    this.borderColor = AppColors.borderSubtle,
    this.borderWidth = 2,
    this.thresholdHeight = 65.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(
    left: borderRadius,
    right: borderRadius,
    bottom: arrowHeight,
  );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double bodyHeight = rect.height - arrowHeight;

    if (bodyHeight <= thresholdHeight) {
      return _buildShortMessagePath(rect);
    } else {
      return _buildLongMessagePath(rect);
    }
  }

  Path _buildShortMessagePath(Rect rect) {
    final double bodyBottom = rect.bottom - arrowHeight;
    final double r = (bodyBottom - rect.top) / 2;
    final double centerX = rect.center.dx;

    return Path()
      ..moveTo(rect.left + r, rect.top)
      ..lineTo(rect.right - r, rect.top)
      ..arcToPoint(Offset(rect.right - r, bodyBottom), radius: Radius.circular(r))
      ..lineTo(centerX + (arrowWidth / 2), bodyBottom)
      ..lineTo(centerX, rect.bottom)
      ..lineTo(centerX - (arrowWidth / 2), bodyBottom)
      ..lineTo(rect.left + r, bodyBottom)
      ..arcToPoint(Offset(rect.left + r, rect.top), radius: Radius.circular(r))
      ..close();
  }

  Path _buildLongMessagePath(Rect rect) {
    final double r = borderRadius;
    final double bodyBottom = rect.bottom - arrowHeight;
    final double centerX = rect.center.dx;

    return Path()
      ..moveTo(rect.left + r, rect.top)
      ..lineTo(rect.right - r, rect.top)
      ..arcToPoint(Offset(rect.right, rect.top + r), radius: Radius.circular(r))
      ..lineTo(rect.right, bodyBottom - r)
      ..arcToPoint(Offset(rect.right - r, bodyBottom), radius: Radius.circular(r))
      ..lineTo(centerX + (arrowWidth / 2), bodyBottom)
      ..lineTo(centerX, rect.bottom)
      ..lineTo(centerX - (arrowWidth / 2), bodyBottom)
      ..lineTo(rect.left + r, bodyBottom)
      ..arcToPoint(Offset(rect.left, bodyBottom - r), radius: Radius.circular(r))
      ..lineTo(rect.left, rect.top + r)
      ..arcToPoint(Offset(rect.left + r, rect.top), radius: Radius.circular(r))
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
