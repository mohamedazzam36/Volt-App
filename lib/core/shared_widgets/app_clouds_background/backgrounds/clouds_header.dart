import 'package:flutter/material.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/animated_cloud.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/animated_star.dart';

class CloudsHeader extends StatefulWidget {
  final bool startFromLeft;

  const CloudsHeader({
    super.key,
    this.startFromLeft = false,
  });

  @override
  State<CloudsHeader> createState() => _CloudsHeaderState();
}

class _CloudsHeaderState extends State<CloudsHeader> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  late final Animation<Offset> _cloud1Slide;
  late final Animation<Offset> _cloud2Slide;
  late final Animation<Offset> _cloud3Slide;
  late final Animation<double> _cloudFade;

  late final Animation<double> _star1Scale;
  late final Animation<double> _star2Scale;
  late final Animation<double> _star3Scale;
  late final Animation<double> _star4Scale;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    final dir = widget.startFromLeft ? -1.0 : 1.0;
    _cloudFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.23, curve: Curves.easeIn),
      ),
    );

    _cloud1Slide = Tween<Offset>(begin: Offset(0.3 * dir, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.28, curve: Curves.easeOut),
      ),
    );

    _cloud2Slide = Tween<Offset>(begin: Offset(0.5 * dir, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.023, 0.30, curve: Curves.easeOut),
      ),
    );

    _cloud3Slide = Tween<Offset>(begin: Offset(0.7 * dir, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.047, 0.33, curve: Curves.easeOut),
      ),
    );

    _star1Scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.35, 1.0, curve: Curves.elasticOut),
      ),
    );

    _star2Scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.50, 1.0, curve: Curves.elasticOut),
      ),
    );

    _star3Scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.65, 0.85, curve: Curves.elasticOut),
      ),
    );

    _star4Scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.78, 1.0, curve: Curves.elasticOut),
      ),
    );

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = context.width;

    final cloud1W = (w * 0.32).clamp(60.0, 220.0);
    final cloud2W = (w * 0.27).clamp(60.0, 220.0);
    final cloud3W = (w * 0.30).clamp(60.0, 220.0);

    const cloudAspect = 1.6;
    const maxTopOffset = 18.0;
    final cloudAreaH = (cloud1W / cloudAspect + maxTopOffset).clamp(80.0, 160.0);

    const starRowH = 48.0;
    const gap = 8.0;
    final totalH = cloudAreaH + gap + starRowH;

    return SizedBox(
      width: double.infinity,
      height: totalH,
      child: Column(
        children: [
          SizedBox(
            height: cloudAreaH,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedCloud(
                  slide: _cloud1Slide,
                  fade: _cloudFade,
                  width: cloud1W,
                  left: -cloud1W * 0.15,
                  top: 8,
                ),
                AnimatedCloud(
                  slide: _cloud2Slide,
                  fade: _cloudFade,
                  width: cloud2W,
                  left: (w - cloud2W) / 2,
                  top: 0,
                ),
                AnimatedCloud(
                  slide: _cloud3Slide,
                  fade: _cloudFade,
                  width: cloud3W,
                  right: -cloud3W * 0.1,
                  top: 10,
                ),
              ],
            ),
          ),

          const SizedBox(height: gap),

          SizedBox(
            width: double.infinity,
            height: starRowH,
            child: Stack(
              children: [
                AnimatedStar(
                  scale: _star2Scale,
                  size: (w * 0.04).clamp(12, 20),
                  left: w * 0.05,
                  top: 6,
                ),

                AnimatedStar(
                  scale: _star1Scale,
                  size: (w * 0.075).clamp(16, 32),
                  left: w * 0.37,
                  top: 18,
                ),

                AnimatedStar(
                  scale: _star3Scale,
                  size: (w * 0.05).clamp(14, 24),
                  left: w * 0.60,
                  top: 4,
                ),

                AnimatedStar(
                  scale: _star4Scale,
                  size: (w * 0.032).clamp(10, 18),
                  right: w * 0.05,
                  top: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
