import 'package:flutter/material.dart';

enum CloudShape { flatBottom, rounded, puffy }

class CloudPainter extends CustomPainter {
  final CloudShape shape;
  final Color color;

  const CloudPainter({
    this.shape = CloudShape.flatBottom,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    switch (shape) {
      case CloudShape.flatBottom:
        path.moveTo(w * 0.15, h * 0.85);
        path.lineTo(w * 0.85, h * 0.85);
        path.quadraticBezierTo(w, h * 0.85, w * 0.95, h * 0.6);
        path.quadraticBezierTo(w * 0.95, h * 0.35, w * 0.75, h * 0.3);
        path.quadraticBezierTo(w * 0.55, h * 0.05, w * 0.35, h * 0.25);
        path.quadraticBezierTo(w * 0.1, h * 0.2, w * 0.05, h * 0.55);
        path.quadraticBezierTo(0, h * 0.85, w * 0.15, h * 0.85);
        break;

      case CloudShape.rounded:
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.1, h * 0.4, w * 0.8, h * 0.45),
            Radius.circular(h * 0.25),
          ),
        );
        path.addOval(Rect.fromCircle(center: Offset(w * 0.4, h * 0.4), radius: h * 0.3));
        path.addOval(Rect.fromCircle(center: Offset(w * 0.65, h * 0.45), radius: h * 0.25));
        break;

      case CloudShape.puffy:
        path.addOval(
          Rect.fromLTWH(0, h * 0.2, w * 0.85, h * 0.8),
        );

        path.addOval(
          Rect.fromLTWH(w * 0.35, h * 0.3, w * 0.65, h * 0.6),
        );
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CloudPainter oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.color != color;
}
