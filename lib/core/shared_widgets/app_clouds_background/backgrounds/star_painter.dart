import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Color color;
  final double spikesSharpness;

  const StarPainter({
    this.color = const Color(0xFFFFD54F),
    this.spikesSharpness = 0.25,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final innerR = r * spikesSharpness;

    path.moveTo(cx, cy - r);
    path.quadraticBezierTo(cx, cy, cx + innerR, cy - innerR);
    path.lineTo(cx + r, cy);
    path.quadraticBezierTo(cx, cy, cx + innerR, cy + innerR);
    path.lineTo(cx, cy + r);
    path.quadraticBezierTo(cx, cy, cx - innerR, cy + innerR);
    path.lineTo(cx - r, cy);
    path.quadraticBezierTo(cx, cy, cx - innerR, cy - innerR);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.spikesSharpness != spikesSharpness;
}
