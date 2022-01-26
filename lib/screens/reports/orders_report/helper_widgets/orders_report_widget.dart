import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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

  Column mainUi(BuildContext context, OrderReportsViewModel viewModel) {
    return Column(
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
        AppTableWidget.header(
          values: [
            AppTableSingleItem.string(
              '#',
              flexValue: 1,
              textAlignment: TextAlign.center,
              textStyle: Theme.of(context).textTheme.button?.copyWith(
                    color: AppColors().primaryHeaderTextColor,
                  ),
            ),
            AppTableSingleItem.string(
              labelItemCode,
              flexValue: 2,
              textStyle: Theme.of(context).textTheme.button?.copyWith(
                    color: AppColors().primaryHeaderTextColor,
                  ),
            ),
            AppTableSingleItem.string(
              'Item Name',
              flexValue: 7,
              textStyle: Theme.of(context).textTheme.button?.copyWith(
                    color: AppColors().primaryHeaderTextColor,
                  ),
            ),
            AppTableSingleItem.string(
              labelQuantity,
              textAlignment: TextAlign.end,
              flexValue: 2,
              textStyle: Theme.of(context).textTheme.button?.copyWith(
                    color: AppColors().primaryHeaderTextColor,
                  ),
            ),
            AppTableSingleItem.string(
              labelAmount,
              textAlignment: TextAlign.end,
              flexValue: 2,
              textStyle: Theme.of(context).textTheme.button?.copyWith(
                    color: AppColors().primaryHeaderTextColor,
                  ),
            ),
          ],
        ),
        if (viewModel.consolidatedOrdersReportResponse != null)
          ...viewModel.consolidatedOrdersReportResponse!.reportResultSet!
              .map(
                (singleValue) => AppTableWidget.values(
                  values: [
                    AppTableSingleItem.int(
                        viewModel
                            .consolidatedOrdersReportResponse!.reportResultSet!
                            .indexOf(
                          singleValue,
                        ),
                        flexValue: 1,
                        textAlignment: TextAlign.center),
                    AppTableSingleItem.int(
                      singleValue.itemCode,
                      flexValue: 2,
                    ),
                    AppTableSingleItem.string(
                      singleValue.itemTitle,
                      flexValue: 7,
                    ),
                    AppTableSingleItem.int(
                      singleValue.itemQuantity,
                      textAlignment: TextAlign.end,
                      flexValue: 2,
                    ),
                    AppTableSingleItem.double(
                      singleValue.itemAmount! / singleValue.itemQuantity!,
                      textAlignment: TextAlign.end,
                      flexValue: 2,
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
                flexValue: 5,
              ),
              AppTableSingleItem.int(
                viewModel.getGrandTotalOfConsolidatedOrdersQty(),
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlignment: TextAlign.end,
                formatNumber: true,
              ),
              AppTableSingleItem.double(
                viewModel.getGrandTotalOfConsolidatedOrdersAmount(),
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlignment: TextAlign.end,
                formatNumber: true,
              ),
            ],
          )
      ], //862
    );
  }

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
        child: getValueForScreenType(
            context: context,
            mobile: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 2.5,
                  child: mainUi(context, viewModel),
                ),
              ),
            ),
            desktop: mainUi(context, viewModel),
            tablet: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: mainUi(context, viewModel),
                ),
              ),
            )),
      ),
    );
  }
}
