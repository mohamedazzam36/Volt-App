import 'package:flutter/material.dart';

class AuthScrollableBody extends StatelessWidget {
  const AuthScrollableBody({super.key, required this.child, this.padding});
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
