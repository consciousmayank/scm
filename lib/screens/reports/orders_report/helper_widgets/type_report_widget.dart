import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:stacked/stacked.dart';

class TypeReportWidget extends ViewModelWidget<OrderReportsViewModel> {
  const TypeReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderReportsViewModel viewModel) {
    return Card(
      elevation: Dimens().getDefaultElevation,
      shape: Dimens().getCardShape(),
      color: AppColors().white,
      child: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ordersReportsGroupByTypeWidgetTitle,
                style: Theme.of(context).textTheme.headline6,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const AppTableWidget.header(
              values: [
                AppTableSingleItem.string(
                  'Name',
                  flexValue: 2,
                ),
                AppTableSingleItem.string(
                  'Qty',
                ),
                AppTableSingleItem.string(
                  'Amnt',
                ),
              ],
            ),
            if (viewModel.ordersReportGroupByTypeResponse != null)
              ...viewModel.ordersReportGroupByTypeResponse!.reportResultSet!
                  .map(
                    (singleValue) => AppTableWidget.values(
                      values: [
                        AppTableSingleItem.string(
                          singleValue.itemType,
                          flexValue: 2,
                        ),
                        AppTableSingleItem.int(
                          singleValue.itemQuantity,
                        ),
                        AppTableSingleItem.int(
                          singleValue.itemAmount,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            if (viewModel.ordersReportGroupByTypeResponse != null)
              AppTableWidget.values(
                values: [
                  AppTableSingleItem.string(
                    'Grand Total',
                    textAlignment: TextAlign.right,
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    flexValue: 2,
                  ),
                  AppTableSingleItem.int(
                      viewModel.getGrandTotalOfOrdersQtyGroupByType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                  AppTableSingleItem.double(
                      viewModel.getGrandTotalOfOrdersAmountGroupByType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                ],
              )
          ],
        ),
      ),
    );
  }
}
