import 'package:flutter/material.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/screens/more_options/more_options_view.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/utils/strings.dart';

class MoreOptionsViewModel extends GeneralisedBaseViewModel {
  List<MoreItems> optionsList = [];

  takeToOrderReports() {
    navigationService.navigateTo(
      orderReportsRoute,
      arguments: OrderReportsViewArguments(
        arguments: OrderReportsViewArgs(),
      ),
    );
  }

  init({required MoreOptionsViewArguments args}) {
    optionsList.add(
      MoreItems(
        title: optionOrderReportTitle,
        subTitle: optionOrderReportSubTitle,
        onPressed: takeToOrderReports,
        icon: Image.asset(
          orderReportImage,
          height: 40,
        ),
      ),
    );
  }
}

class MoreItems {
  MoreItems({
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final Widget icon;
  final String title, subTitle;
}
