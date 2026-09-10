import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class SequentialDotsLoading extends StatefulWidget {
  final double dotSize;
  final Duration stepDuration;

  const SequentialDotsLoading({
    super.key,
    this.dotSize = 8.0,
    this.stepDuration = const Duration(milliseconds: 400),
  });

  @override
  State<SequentialDotsLoading> createState() => _SequentialDotsLoadingState();
}

class _SequentialDotsLoadingState extends State<SequentialDotsLoading> {
  late Timer _timer;
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.stepDuration, (timer) {
      _currentIndex.value = (_currentIndex.value + 1) % 3;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (index) {
              final isActive = index == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: widget.dotSize,
                width: widget.dotSize,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.brandSecondaryBlue : AppColors.borderSubtle,
                  shape: BoxShape.circle,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
