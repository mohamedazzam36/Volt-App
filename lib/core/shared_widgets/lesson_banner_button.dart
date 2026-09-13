import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';

class LessonBannerButton extends StatefulWidget {
  final VoidCallback onTap;

  const LessonBannerButton({super.key, required this.onTap});

  @override
  State<LessonBannerButton> createState() => _LessonBannerButtonState();
}

class _LessonBannerButtonState extends State<LessonBannerButton> {
  double bottomMargin = 6.0;

  void _pressDown() => setState(() => bottomMargin = 0.0);
  void _releaseUp() => setState(() => bottomMargin = 6.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: GestureDetector(
        onTapDown: (_) => _pressDown(),
        onTapUp: (_) {
          _releaseUp();
          widget.onTap();
        },
        onTapCancel: _releaseUp,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.orange.shade800,
            borderRadius: BorderRadius.circular(15),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: EdgeInsets.only(bottom: bottomMargin),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Assets.svgs.lessonBannerButtonBookIcon.svg(),
                const SizedBox(width: 15),
                Container(width: 2, height: 80, color: Colors.black12),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "كوكب الكهرباء",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ما هي الكهرباء",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
