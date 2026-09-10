import 'dart:async';

import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class AnimatedBatteryLoader extends StatefulWidget {
  final VoidCallback onLoadComplete;
  final Duration stepDuration;

  const AnimatedBatteryLoader({
    super.key,
    required this.onLoadComplete,
    // كل 500 مللي ثانية هيشحن شرطة
    this.stepDuration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedBatteryLoader> createState() => _AnimatedBatteryLoaderState();
}

class _AnimatedBatteryLoaderState extends State<AnimatedBatteryLoader> {
  late Timer _timer;
  final ValueNotifier<int> _currentLevel = ValueNotifier<int>(0);
  final int _maxLevel = 5;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _timer = Timer.periodic(widget.stepDuration, (timer) {
      if (_currentLevel.value < _maxLevel) {
        _currentLevel.value++;
      } else {
        timer.cancel();
        widget.onLoadComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _currentLevel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // شيلنا الـ Directionality عشان الـ Widget تاخد اتجاه التطبيق الأساسي
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // جسم البطارية
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textPrimary, width: 2.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: _currentLevel,
            builder: (context, level, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_maxLevel, (index) {
                  final isFilled = index < level;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    // استخدمنا EdgeInsetsDirectional بدل EdgeInsets العادية
                    // كدا الـ end هيبقى على الشمال لو عربي، وعلى اليمين لو إنجليزي
                    margin: EdgeInsetsDirectional.only(
                      end: index == _maxLevel - 1 ? 0 : 4.0,
                    ),
                    width: 32,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isFilled ? AppColors.brandSecondaryGreen : Colors.transparent,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: isFilled
                        ? const Icon(
                            Icons.bolt,
                            color: Colors.white,
                            size: 24,
                          )
                        : null,
                  );
                }),
              );
            },
          ),
        ),
        // رأس البطارية (الطرف الموجب)
        Container(
          width: 6,
          height: 18,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            // استخدمنا BorderRadiusDirectional بدل BorderRadius.only
            // كدا التدوير هيتعمل في "النهاية" (اللي هي الشمال في حالة العربي)
            borderRadius: BorderRadiusDirectional.horizontal(
              end: Radius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
