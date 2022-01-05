import 'package:flutter/material.dart';

class AppColors {
  // late final BuildContext context;

  // AppColors({required this.context});

  static const MaterialColor demandPrimaryColor = MaterialColor(0xFF2D2F42, {
    50: Color(0xFFefedfc),
    100: Color(0xFFd2d6e9),
    200: Color(0xFFb8bad2),
    300: Color(0xFF9c9fbb),
    400: Color(0xFF888ba9),
    500: Color(0xFF737798),
    600: Color(0xFF646987),
    700: Color(0xFF525570),
    800: Color(0xFF41435a),
    900: Color(0xFF2D2F42),
  });

  static const MaterialColor shadesOfBlack = MaterialColor(0xFF000000, {
    50: Color(0xffff5f5f5),
    100: Color(0xFFe9e9e9),
    200: Color(0xFFd9d9d9),
    300: Color(0xFFc4c4c4),
    400: Color(0xFF9d9d9d),
    500: Color(0xFF7b7b7b),
    600: Color(0xFF555555),
    700: Color(0xFF434343),
    800: Color(0xFF262626),
    900: Color(0xFF000000),
  });

  static const MaterialColor supplyPrimaryColor = MaterialColor(0xff003f63, {
    50: Color(0xFFe2eff3),
    100: Color(0xFFb8d8e4),
    200: Color(0xFF8fc0d2),
    300: Color(0xFF69a7c1),
    400: Color(0xFF4e96b7),
    500: Color(0xFF3486ad),
    600: Color(0xFF287aa2),
    700: Color(0xFF1a6a92),
    800: Color(0xFF0f5a81),
    900: Color(0xFF003f63),
  });

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

  // get getColumnWithTitleHeaderColor => primaryColor.shade200;

  get appScaffoldBgColor => Colors.white;

  // get appOutlinedTextButtonBackgroundColor => primaryColor.shade200;

  // get appTextButtonForegroundColor => primaryColor.shade50;

  // get appTextButtonBackgroundColor => primaryColor.shade200;

  get tabIndicatorColor => primaryColor.shade900;

  get tabDividerColor => primaryColor.shade900;

  get tabSelectedLabelColor => Colors.white;

  get tabUnSelectedLabelColor => Colors.white60;

  get mobileNavigationShadowColor => Colors.black87;

  get popularBrandsBg => const Color(0xffEEF2F7);

  get popularBrandsSeeAllBg => const Color(0xff6568F3);

  get productListItemWebCategoryBg => const Color(0xffEEF2F7);

  get productListItemWebCategoryContainerBg => const Color(0xff979797);

  // get orderDetailsContainerBg => const Color(0xffC5C5C5);

  get productListItemWebCategoryTextColor => const Color(0xff6C757D);

  Color get productFilterBg => primaryColor.shade500;

  Color get dashboardTableHeaderBg => const Color(0xffEEF2F7);

  Color get processingOrderBg => const Color(0xffFFBC00);

  Color get placedOrderBg => const Color(0xff6568F3);

  Color get deliveredOrderBg => const Color(0xff00C48E);

  Color get shippedOrderBg => const Color(0xff4EB1D6);

  // Color get cancelledOrderBg => const Color(0xff646464);
  Color get cancelledOrderBg => Colors.red;

  Color get dashboardOrderInfoTileTitleBg => const Color(0xff979797);
}
