import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class LoadingBar extends StatefulWidget {
  const LoadingBar({
    super.key,
    this.widthRatio = 0.35,
    this.height = 8.0,
    this.duration = const Duration(seconds: 2),
  });

  final double widthRatio;
  final double height;
  final Duration duration;

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double responsiveWidth =
        MediaQuery.sizeOf(context).width * widget.widthRatio;

    return Container(
      width: responsiveWidth,
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(widget.height),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: _animation.value,
                heightFactor: 1.0,
                child: child,
              ),
            );
          },
          child: const ColoredBox(
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }
}