import 'package:flutter/material.dart';

class AppColors {
  Color black = Colors.black;
  var primaryColor = const MaterialColor(0xFF4a148c, {
    50: Color(0xFFf3e5f5),
    100: Color(0xFFce93d8),
    200: Color(0xFF7b1fa2),
    300: Color(0xFFba68c8),
    400: Color(0xFFab47bc),
    500: Color(0xFF9c27b0),
    600: Color(0xFF8e24aa),
    700: Color(0xFF7b1fa2),
    800: Color(0xFF6a1b9a),
    900: Color(0xFF4a148c),
  });

  Color white = Colors.white;

  get getColumnWithTitleHeaderColor => primaryColor.shade200;

  get appScaffoldBgColor => Colors.white;

  get appOutlinedTextButtonBackgroundColor => primaryColor.shade200;

  get appTextButtonForegroundColor => primaryColor.shade50;

  get appTextButtonBackgroundColor => primaryColor.shade200;

  get tabIndicatorColor => primaryColor.shade900;

  get tabDividerColor => primaryColor.shade900;

  get tabSelectedLabelColor => Colors.white;

  get tabUnSelectedLabelColor => Colors.white60;
}
