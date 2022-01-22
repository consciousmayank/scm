import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';

class Dimens {
  static const int defaultProductListPageSize = 25;
  static const int defaultProductListPageSizeWhenInHome = 14;

  double get orderInfoTilesHeight => 110;

  double get buttonHeight => 50;

  double get buttonWidth => 100;

  double get getDefaultRadius => 8;

  int get maxSummaryLength => 400;

  int get minSummaryLength => 120;

  int get maxTagsLength => 120;

  double get getColumnWithTitleHeaderPadding => 8;

  double get getDefaultElevation => 8;

  TextStyle get pageTitleHeadingStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors().black,
      );

  TextStyle get pageSubTitleHeadingStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors().black,
      );

  double get getDecoratedContainerDefaultPadding => 8;

  double get defaultBorder => 16;

  double get popularBrandsHeight => 350;

  double get popularCategoryHeight => 150;

  double get popularProductsHeight => 800;

  double get popularBrandsToppadding => 10;

  double get popularBrandsLeftpadding => 10;

  double get popularBrandsRightpadding => 10;

  double get brandReportWidgetHeight => 400;

  double get typeReportWidgetHeight => 400;

  double get subtypeReportWidgetHeight => 400;

  double get ordersConsolidatedReportWidgetHeight => 500;

  get productListItemWebHeight => 230;

  get productListItemWebWidth => 319;

  get dashboardOrderedBrandsInfoCardHeight => 400;

  get dashboardOrderedTypeInfoCardHeight => 400;

  get dashboardOrderListCardHeight => 500;

  double get suppliersListItemImageCircularRaduis => 8;

  double get defaultButtonPadding => 6;

  getBorderRadius({double? radius}) {
    return BorderRadius.circular(
      radius ?? getDefaultRadius,
    );
  }

  RoundedRectangleBorder getCardShape({double? radius}) {
    return RoundedRectangleBorder(
      borderRadius: getBorderRadius(
        radius: radius,
      ),
    );
  }

  TextInputFormatter get numericTextInputFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]'),
      );

  TextInputFormatter get numericWithDecimalsTextInputFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,2}'),
      );

  TextInputFormatter get numericWithDecimalFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'^\d+\.?\d{0,2}'),
      );

  TextInputFormatter get alphaNumericWithSpaceSlashHyphenUnderScoreFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z0-9 -/_]'),
      );

  TextInputFormatter get alphabeticFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z ]'),
      );
}
