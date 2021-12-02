import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  // bool get isDark => ThemeUtils.isDark(this);
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}
