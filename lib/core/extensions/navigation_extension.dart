import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  Future<T?> push<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T, TO>(Widget screen, {TO? result}) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => screen),
      result: result,
    );
  }

  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  void popTimes(int count) {
    int popped = 0;
    Navigator.popUntil(this, (_) => popped++ >= count);
  }

  Future<T?> pushAbove<T>(String baseRouteName, Widget newScreen) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => newScreen),
      (route) => route.settings.name == baseRouteName,
    );
  }

  Future<T?> pushAboveNamed<T>(String baseRouteName, String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => route.settings.name == baseRouteName,
      arguments: arguments,
    );
  }

  Future<T?> pushAndRemoveAll<T>(Widget screen) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  Future<T?> pushNamedAndRemoveAll<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
