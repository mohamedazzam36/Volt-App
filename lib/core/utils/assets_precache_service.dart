import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/constants/assets.gen.dart';

class AssetsPrecacheService {
  static Future<void> precacheAll(BuildContext context) async {
    try {
      // 1. Precache all images
      final imageFutures = Assets.images.values.map((img) {
        return precacheImage(img.provider(), context);
      });

      // 2. Precache all SVGs
      final svgFutures = Assets.svgs.values.map((svgImg) async {
        final loader = SvgAssetLoader(svgImg.path);
        await svg.cache.putIfAbsent(
          loader.cacheKey(null),
          () => loader.loadBytes(null),
        );
      });

      // Wait for all to finish
      await Future.wait([...imageFutures, ...svgFutures]);
    } catch (e) {
      debugPrint('Error precaching assets: \$e');
    }
  }
}
