import 'package:flutter/material.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: 500,
              height: 500,
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text("hello"),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final h = size.height;
    final w = size.width;
    path.moveTo(0, h / 2);
    // path.quadraticBezierTo(w / 2, 0, w, h / 2);
    // path.cubicTo(w / 3, h, w * 2 / 3, 100, w, h / 2);
    // path.lineTo(w, h);
    // path.lineTo(0, h);
    // path.lineTo(0, h / 2);
    // path.arcToPoint(
    //   Offset(w / 3, h / 2),
    //   radius: const Radius.circular(100),
    //   clockwise: false,
    //   // largeArc: true,
    // );
    path.fillType = PathFillType.evenOdd;
    path.addRect(const Rect.fromLTWH(0, 0, 100, 100));
    path.addOval(const Rect.fromLTWH(0, 0, 150, 100));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}

// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     final h = size.height;
//     final w = size.width;
//     path.moveTo(0, h / 2);
//     path.lineTo(w / 2 - 60, h / 2);
//     path.lineTo(w / 2, 0);
//     path.lineTo(w / 2 + 60, h / 2);
//     path.lineTo(w, h / 2);
//     path.lineTo(w / 2 + 70, h / 2 + 70);
//     path.lineTo(w, h);
//     path.lineTo(w / 2, h - 120);
//     path.lineTo(0, h);
//     path.lineTo(w / 2 - 70, h / 2 + 70);

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
//     return true;
//   }
// }
