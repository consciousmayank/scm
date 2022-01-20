import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:stacked/stacked.dart';

class OrdersConsilidatedReportWidget
    extends ViewModelWidget<OrderReportsViewModel> {
  const OrdersConsilidatedReportWidget({
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
                consolidatedOrdersReportsWidgetTitle,
                style: Theme.of(context).textTheme.headline6,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const AppTableWidget.header(
              values: [
                AppTableSingleItem.string('Code'),
                AppTableSingleItem.string('Name', flexValue: 3),
                AppTableSingleItem.string(
                  'Qty',
                ),
                AppTableSingleItem.string(
                  'Amnt',
                ),
              ],
            ),
            if (viewModel.consolidatedOrdersReportResponse != null)
              ...viewModel.consolidatedOrdersReportResponse!.reportResultSet!
                  .map(
                    (singleValue) => AppTableWidget.values(
                      values: [
                        AppTableSingleItem.int(singleValue.itemCode),
                        AppTableSingleItem.string(
                          singleValue.itemTitle,
                          flexValue: 3,
                        ),
                        AppTableSingleItem.int(
                          singleValue.itemQuantity,
                        ),
                        AppTableSingleItem.double(
                          singleValue.itemAmount! / singleValue.itemQuantity!,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            if (viewModel.consolidatedOrdersReportResponse != null)
              AppTableWidget.values(
                values: [
                  AppTableSingleItem.string(
                    'Grand Total',
                    textAlignment: TextAlign.right,
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    flexValue: 4,
                  ),
                  AppTableSingleItem.int(
                      viewModel.getGrandTotalOfConsolidatedOrdersQty(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                  AppTableSingleItem.double(
                      viewModel.getGrandTotalOfConsolidatedOrdersAmount() /
                          viewModel.getGrandTotalOfConsolidatedOrdersQty(),
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
