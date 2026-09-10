import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class CircleImage extends StatefulWidget {
  final String assetPath;
  final double size;
  final double iconSize;

  const CircleImage({
    super.key,
    required this.assetPath,
    this.size = 42,
    this.iconSize = 20,
  });

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceDefault,
          shape: BoxShape.circle,
          border: Border.all(
            color:AppColors.borderSubtle,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.35),
              offset: const Offset(0, 3.5),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Image.asset(
          widget.assetPath,
          width: widget.iconSize,
          height: widget.iconSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}