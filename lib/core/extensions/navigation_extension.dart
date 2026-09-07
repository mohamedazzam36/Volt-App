import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  /// بتفتح شاشة جديدة فوق الشاشة الحالية مباشرة (بتضيفها في الـ Stack).
  Future<T?> push<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// بتفتح شاشة جديدة باستخدام اسمها (Named Route) ومع إمكانية إرسال داتا (arguments).
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// بتستبدل الشاشة الحالية بشاشة جديدة (بتمسح الحالية من الـ Stack وتحط الجديدة مكانها).
  Future<T?> pushReplacement<T, TO>(Widget screen, {TO? result}) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => screen),
      result: result,
    );
  }

  /// نفس فكرة الاستبدال اللي فوق بس باستخدام اسم الراوت (Named Route).
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) {
    return Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// بتقفل الشاشة الحالية وترجع للي تحتها، وتقدر تبعت داتا (result) للشاشة اللي رجعتلها.
  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  /// بتقفل عدد محدد من الشاشات ورا بعض دفعة واحدة حسب الرقم اللي هتديهولها.
  void popTimes(int count) {
    int popped = 0;
    Navigator.popUntil(this, (_) => popped++ >= count);
  }

  /// بترجع لشاشة معينة في الـ Stack، وتمسح كل الشاشات اللي فوقها، وتفتح الشاشة الجديدة فوقها مباشرة.
  Future<T?> pushAbove<T>(String baseRouteName, Widget newScreen) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => newScreen),
      (route) => route.settings.name == baseRouteName,
    );
  }

  /// نفس فكرة pushAbove بس باستخدام اسم الراوت (Named Route).
  Future<T?> pushAboveNamed<T>(String baseRouteName, String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => route.settings.name == baseRouteName,
      arguments: arguments,
    );
  }

  /// بتفتح شاشة جديدة وتمسح كل الشاشات اللي فاتت في التطبيق (تصفير الـ Stack بالكامل).
  Future<T?> pushAndRemoveAll<T>(Widget screen) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  /// نفس تصفير الـ Stack بالكامل بس باستخدام اسم الراوت (Named Route)، مفيدة في الـ Logout مثلاً.
  Future<T?> pushNamedAndRemoveAll<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
