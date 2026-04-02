import 'package:flutter/material.dart';

class ThemeData {
  final Color primaryColor;
  final Color secondaryColor;
  final double fontSize;

  const ThemeData({
    required this.primaryColor,
    required this.secondaryColor,
    required this.fontSize,
  });
}

class ThemeInherited extends InheritedWidget {
  final ThemeData themeData;

  const ThemeInherited({
    super.key,
    required this.themeData,
    required super.child,
  });

  static ThemeInherited of(BuildContext context) {
    final ThemeInherited? result = context
        .dependOnInheritedWidgetOfExactType<ThemeInherited>();
    assert(result != null, 'ThemeInherited를 찾을 수 없습니다.');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeInherited oldWidget) {
    return themeData.primaryColor != oldWidget.themeData.primaryColor ||
        themeData.secondaryColor != oldWidget.themeData.secondaryColor ||
        themeData.fontSize != oldWidget.themeData.fontSize;
  }
}
