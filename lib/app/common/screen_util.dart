import 'package:flutter/widgets.dart';

class ScreenUtil {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleFactor;

  static void init(BuildContext context, {double baseWidth = 375.0}) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _scaleFactor = _screenWidth / baseWidth;
  }

  static double scale(double size) => size * _scaleFactor;
}
extension ResponsiveExtension on num {
  double get dp => ScreenUtil.scale(toDouble());
}
