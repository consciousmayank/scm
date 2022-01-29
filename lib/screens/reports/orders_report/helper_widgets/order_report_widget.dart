import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_reports_type.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_table_widget.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget.consolidated({
    Key? key,
    required this.reportResponse,
    required this.title,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = true,
        reportType = OrderReportsType.CONSOLIDATED,
        super(key: key);

  const ReportWidget.dashBoardGroupByBrands({
    Key? key,
    required this.reportResponse,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = false,
        title = null,
        reportType = OrderReportsType.GROUP_BY_BRANDS,
        super(key: key);

  const ReportWidget.dashBoardGroupByCategory({
    Key? key,
    required this.reportResponse,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : reportType = OrderReportsType.GROUP_BY_CATEGORY,
        cardify = false,
        title = null,
        super(key: key);

  const ReportWidget.dashBoardGroupBySubCategory({
    Key? key,
    required this.reportResponse,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : reportType = OrderReportsType.GROUP_BY_SUB_CATEGORY,
        cardify = false,
        title = null,
        super(key: key);

  const ReportWidget.dashBoardconsolidated({
    Key? key,
    required this.reportResponse,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = false,
        title = null,
        reportType = OrderReportsType.CONSOLIDATED,
        super(key: key);

  const ReportWidget.groupByBrands({
    Key? key,
    required this.reportResponse,
    required this.title,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = true,
        reportType = OrderReportsType.GROUP_BY_BRANDS,
        super(key: key);

  const ReportWidget.groupByCategory({
    Key? key,
    required this.reportResponse,
    required this.title,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = true,
        reportType = OrderReportsType.GROUP_BY_CATEGORY,
        super(key: key);

  const ReportWidget.groupBySubCategory({
    Key? key,
    required this.reportResponse,
    required this.title,
    required this.quantityGrandTotal,
    required this.amountGrandTotal,
  })  : cardify = true,
        reportType = OrderReportsType.GROUP_BY_SUB_CATEGORY,
        super(key: key);

  final double? amountGrandTotal;
  final bool cardify;
  final int? quantityGrandTotal;
  final OrdersReportResponse? reportResponse;
  final OrderReportsType reportType;
  final String? title;

  Widget getChild({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Count : ${reportResponse?.reportResultSet?.length}',
                    style: Theme.of(context).textTheme.button,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          AppTableWidget.header(
            values: [
              AppTableSingleItem.string(
                '#',
                flexValue: Dimens().snoFlexValue,
                textAlignment: TextAlign.center,
                textStyle: Theme.of(context).textTheme.button?.copyWith(
                      color: AppColors().primaryHeaderTextColor,
                    ),
              ),
              AppTableSingleItem.string('Name',
                  flexValue: Dimens().nameFlexValue,
                  textStyle: Theme.of(context).textTheme.button?.copyWith(
                        color: AppColors().primaryHeaderTextColor,
                      )),
              AppTableSingleItem.string(labelQuantity,
                  textAlignment: TextAlign.end,
                  flexValue: Dimens().quantityFlexValue,
                  textStyle: Theme.of(context).textTheme.button?.copyWith(
                        color: AppColors().primaryHeaderTextColor,
                      )),
              AppTableSingleItem.string(labelAmount,
                  textAlignment: TextAlign.end,
                  flexValue: Dimens().amountFlexValue,
                  textStyle: Theme.of(context).textTheme.button?.copyWith(
                        color: AppColors().primaryHeaderTextColor,
                      )),
            ],
          ),
          if (reportResponse != null)
            Expanded(
              child: ListView(
                children: reportResponse!.reportResultSet!
                    .map(
                      (singleValue) => AppTableWidget.values(
                        values: [
                          AppTableSingleItem.int(
                            reportResponse!.reportResultSet!.indexOf(
                                  singleValue,
                                ) +
                                1,
                            flexValue: Dimens().snoFlexValue,
                            textAlignment: TextAlign.center,
                          ),
                          AppTableSingleItem.string(
                            getName(value: singleValue),
                            flexValue: Dimens().nameFlexValue,
                            textAlignment: TextAlign.left,
                          ),
                          AppTableSingleItem.int(
                            singleValue.itemQuantity,
                            textAlignment: TextAlign.end,
                            flexValue: Dimens().quantityFlexValue,
                            formatNumber: true,
                          ),
                          AppTableSingleItem.double(
                            singleValue.itemAmount,
                            textAlignment: TextAlign.end,
                            flexValue: Dimens().amountFlexValue,
                            formatNumber: true,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          if (reportResponse != null)
            AppTableWidget.values(
              values: [
                AppTableSingleItem.string(
                  'Grand Total',
                  textAlignment: TextAlign.right,
                  textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  flexValue: Dimens().grandTotaltFlexValue,
                ),
                AppTableSingleItem.int(
                  quantityGrandTotal,
                  textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  formatNumber: true,
                  textAlignment: TextAlign.end,
                  flexValue: Dimens().quantityFlexValue,
                ),
                AppTableSingleItem.double(
                  amountGrandTotal,
                  formatNumber: true,
                  textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  flexValue: Dimens().amountFlexValue,
                  textAlignment: TextAlign.end,
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget cardifyChild({
    required child,
  }) {
    return Card(
      elevation: Dimens().getDefaultElevation,
      shape: Dimens().getCardShape(),
      color: AppColors().white,
      child: child,
    );
  }

  String? getName({ReportResultSet? value}) {
    if (value == null) {
      return null;
    }

    switch (reportType) {
      case OrderReportsType.GROUP_BY_CATEGORY:
        return value.itemType;
      case OrderReportsType.GROUP_BY_SUB_CATEGORY:
        return value.itemSubType;
      case OrderReportsType.GROUP_BY_BRANDS:
        return value.itemBrand;
      case OrderReportsType.CONSOLIDATED:
        return value.itemTitle;
      default:
        return null;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return cardify
        ? SizedBox(
            height: Dimens().brandReportWidgetHeight,
            child: Card(
              child: cardifyChild(
                child: getChild(
                  context: context,
                ),
              ),
            ),
          )
        : getChild(context: context);
  }
}
