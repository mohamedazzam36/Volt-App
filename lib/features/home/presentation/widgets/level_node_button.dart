import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelNodeButton extends StatefulWidget {
  final bool isLocked;
  final String iconPath;
  final double? progress;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color shadowColor;

  const LevelNodeButton.unlocked({
    super.key,
    required this.iconPath,
    this.progress,
    this.onTap,
    this.backgroundColor = Colors.blue,
    this.shadowColor = const Color(0xFF1976D2),
  }) : isLocked = false;

  const LevelNodeButton.locked({
    super.key,
    this.onTap,
    required this.iconPath,
  }) : isLocked = true,
       progress = null,
       backgroundColor = const Color(0xFFE0E0E0),
       shadowColor = const Color(0xFFBDBDBD);

  @override
  State<LevelNodeButton> createState() => _LevelNodeButtonState();
}

class _LevelNodeButtonState extends State<LevelNodeButton> {
  double bottomBorder = 4.0;

  void _pressDown() => setState(() => bottomBorder = 0.0);
  void _releaseUp() => setState(() => bottomBorder = 4.0);

  @override
  Widget build(BuildContext context) {
    bool showProgress = !widget.isLocked && widget.progress != null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTapDown: widget.isLocked ? null : (_) => _pressDown(),
        onTapUp: widget.isLocked
            ? null
            : (_) {
                _releaseUp();
                widget.onTap?.call();
              },
        onTapCancel: widget.isLocked ? null : _releaseUp,
        child: SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (showProgress)
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    value: widget.progress,
                    strokeWidth: 6,
                    color: Colors.amber,
                    backgroundColor: Colors.grey.shade300,
                    strokeCap: StrokeCap.round,
                  ),
                ),

              SizedBox(
                width: 72,
                height: 72,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.shadowColor,
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: const Alignment(0, 0.1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),

                      margin: EdgeInsets.only(
                        bottom: bottomBorder,
                      ),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        widget.iconPath,
                        width: 46,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
