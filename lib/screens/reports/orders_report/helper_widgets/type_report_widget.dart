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
    return SizedBox(
      height: Dimens().typeReportWidgetHeight,
      child: Card(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ordersReportsGroupByTypeWidgetTitle,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Count : ${viewModel.ordersReportGroupByTypeResponse?.reportResultSet?.length}',
                      style: Theme.of(context).textTheme.button,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              const AppTableWidget.header(
                values: [
                  AppTableSingleItem.string(
                    '#',
                    flexValue: 2,
                    textAlignment: TextAlign.center,
                  ),
                  AppTableSingleItem.string(
                    'Name',
                    flexValue: 5,
                  ),
                  AppTableSingleItem.string(
                    'Qty',
                    textAlignment: TextAlign.end,
                    flexValue: 2,
                  ),
                  AppTableSingleItem.string(
                    'Amnt',
                    textAlignment: TextAlign.end,
                    flexValue: 3,
                  ),
                ],
              ),
              if (viewModel.ordersReportGroupByTypeResponse != null)
                Expanded(
                  child: ListView(
                    children: viewModel
                        .ordersReportGroupByTypeResponse!.reportResultSet!
                        .map(
                          (singleValue) => AppTableWidget.values(
                            values: [
                              AppTableSingleItem.int(
                                  viewModel.ordersReportGroupByTypeResponse!
                                      .reportResultSet!
                                      .indexOf(singleValue),
                                  flexValue: 2,
                                  textAlignment: TextAlign.center),
                              AppTableSingleItem.string(
                                singleValue.itemType,
                                flexValue: 5,
                              ),
                              AppTableSingleItem.int(
                                singleValue.itemQuantity,
                                textAlignment: TextAlign.end,
                                flexValue: 2,
                                formatNumber: true,
                              ),
                              AppTableSingleItem.double(
                                singleValue.itemAmount,
                                textAlignment: TextAlign.end,
                                flexValue: 3,
                                formatNumber: true,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              if (viewModel.ordersReportGroupByTypeResponse != null)
                AppTableWidget.values(
                  values: [
                    AppTableSingleItem.string(
                      'Grand Total',
                      textAlignment: TextAlign.right,
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      flexValue: 7,
                    ),
                    AppTableSingleItem.int(
                      viewModel.getGrandTotalOfOrdersQtyGroupByType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlignment: TextAlign.end,
                      formatNumber: true,
                      flexValue: 2,
                    ),
                    AppTableSingleItem.double(
                      viewModel.getGrandTotalOfOrdersAmountGroupByType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlignment: TextAlign.end,
                      flexValue: 3,
                      formatNumber: true,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
