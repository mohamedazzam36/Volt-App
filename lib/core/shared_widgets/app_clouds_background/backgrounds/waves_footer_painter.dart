import 'package:flutter/material.dart';

class WavesFooterPainter extends CustomPainter {
  final Color baseColor;
  final Color topWaveColor;
  final Color connectorColor;

  WavesFooterPainter({
    required this.baseColor,
    required this.topWaveColor,
    required this.connectorColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. الطبقة المتوسطة (Middle Wave)
    final midPaint = Paint()..color = topWaveColor;
    final midPath = Path()
      ..moveTo(0, h * 0.18)
      ..cubicTo(w * 0.25, h * 0.06, w * 0.45, h * 0.42, w * 0.75, h * 0.16)
      ..quadraticBezierTo(w * 0.88, h * 0.06, w, h * 0.14)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(midPath, midPaint);

    // 2. الطبقة السفلية الأساسية (Base Wave)
    final basePaint = Paint()..color = baseColor;
    final basePath = Path()
      ..moveTo(0, h * 0.42)
      ..cubicTo(w * 0.25, h * 0.3, w * 0.50, h * 0.56, w * 0.75, h * 0.50)
      ..quadraticBezierTo(w * 0.88, h * 0.46, w, h * 0.44)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(basePath, basePaint);

    // 3. الخطوط والـ Ellipses (Connectors)
    final linePaint = Paint()
      ..color = connectorColor
      ..strokeWidth = 2.7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final dotPaint = Paint()
      ..color = connectorColor
      ..style = PaintingStyle.fill;

    // أبعاد الشكل البيضاوي
    const ellipseWidth = 12.0;
    const ellipseHeight = 11.0;

    // الخط الأيسر (نزل من 0.67/0.58 إلى 0.77/0.68)
    final leftPath = Path()
      ..moveTo(0, h * 0.77)
      ..lineTo(w * 0.06, h * 0.77)
      ..lineTo(w * 0.06, h * 0.68)
      ..lineTo(w * 0.13, h * 0.68);
    canvas.drawPath(leftPath, linePaint);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.13, h * 0.68),
        width: ellipseWidth,
        height: ellipseHeight,
      ),
      dotPaint,
    );

    // الخط الأيمن (نزل من 0.72/0.63 إلى 0.82/0.73)
    final rightPath = Path()
      ..moveTo(w, h * 0.82)
      ..lineTo(w * 0.94, h * 0.82)
      ..lineTo(w * 0.94, h * 0.73)
      ..lineTo(w * 0.87, h * 0.73);
    canvas.drawPath(rightPath, linePaint);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.87, h * 0.73),
        width: ellipseWidth,
        height: ellipseHeight,
      ),
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant WavesFooterPainter oldDelegate) {
    return oldDelegate.baseColor != baseColor ||
        oldDelegate.topWaveColor != topWaveColor ||
        oldDelegate.connectorColor != connectorColor;
  }
}
