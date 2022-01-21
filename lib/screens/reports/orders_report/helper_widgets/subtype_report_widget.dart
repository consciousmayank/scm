import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:stacked/stacked.dart';

class SubTypeReportWidget extends ViewModelWidget<OrderReportsViewModel> {
  const SubTypeReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderReportsViewModel viewModel) {
    return SizedBox(
      height: Dimens().subtypeReportWidgetHeight,
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
                      ordersReportsGroupBySubTypeWidgetTitle,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Count : ${viewModel.ordersReportGroupBySubTypeResponse?.reportResultSet?.length}',
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
                    labelQuantity,
                    textAlignment: TextAlign.end,
                    flexValue: 2,
                  ),
                  AppTableSingleItem.string(
                    labelAmount,
                    textAlignment: TextAlign.end,
                    flexValue: 3,
                  ),
                ],
              ),
              if (viewModel.ordersReportGroupBySubTypeResponse != null)
                Expanded(
                  child: ListView(
                    children: viewModel
                        .ordersReportGroupBySubTypeResponse!.reportResultSet!
                        .map(
                          (singleValue) => AppTableWidget.values(
                            values: [
                              AppTableSingleItem.int(
                                viewModel.ordersReportGroupBySubTypeResponse!
                                    .reportResultSet!
                                    .indexOf(singleValue),
                                flexValue: 2,
                                textAlignment: TextAlign.center,
                              ),
                              AppTableSingleItem.string(
                                singleValue.itemSubType,
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
              if (viewModel.ordersReportGroupBySubTypeResponse != null)
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
                      viewModel.getGrandTotalOfOrdersQtyGroupBySubType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      formatNumber: true,
                      textAlignment: TextAlign.end,
                      flexValue: 2,
                    ),
                    AppTableSingleItem.double(
                      viewModel.getGrandTotalOfOrdersAmountGroupBySubType(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlignment: TextAlign.end,
                      formatNumber: true,
                      flexValue: 3,
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
