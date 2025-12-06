import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  /// Retorna padding/margen horizontal responsivo (% del ancho)
  static double paddingHorizontal(double percent) =>
      safeBlockHorizontal * percent;

  /// Retorna padding/margen vertical responsivo (% del alto)
  static double paddingVertical(double percent) => safeBlockVertical * percent;

  /// Retorna tamaño de fuente responsivo
  static double fontSize(double baseSize) {
    double scale = screenWidth / 375;
    return baseSize * scale;
  }

  /// Retorna altura responsiva
  static double height(double percent) => screenHeight * (percent / 100);

  /// Retorna ancho responsivo
  static double width(double percent) => screenWidth * (percent / 100);

  /// Retorna true si es tablet (ancho >= 600)
  static bool isTablet() => screenWidth >= 600;

  /// Retorna true si es mobile (ancho < 600)
  static bool isMobile() => screenWidth < 600;

  /// Retorna true si es en modo landscape
  static bool isLandscape() =>
      _mediaQueryData.orientation == Orientation.landscape;

  /// Retorna el número de columnas según el tamaño
  static int getGridColumns() {
    if (screenWidth >= 1200) return 4;
    if (screenWidth >= 800) return 3;
    if (screenWidth >= 600) return 2;
    return 1;
  }
}
