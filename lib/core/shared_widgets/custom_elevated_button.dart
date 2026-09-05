import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.bottomColor,
  });
  final VoidCallback onTap;
  final String text;
  final Color color, bottomColor;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double bottomBorder = 4;

  void _pressDown() => setState(() => bottomBorder = 1);

  void _releaseUp() => setState(() => bottomBorder = 4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 300,
      child: GestureDetector(
        onTapDown: (_) {
          _pressDown();
        },
        onTapUp: (_) {
          _releaseUp();
          widget.onTap();
        },
        onTapCancel: _releaseUp,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: bottomBorder),
            decoration: BoxDecoration(
              color: widget.bottomColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
