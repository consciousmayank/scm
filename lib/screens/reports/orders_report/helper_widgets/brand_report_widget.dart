import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:stacked/stacked.dart';

class BrandReportWidget extends ViewModelWidget<OrderReportsViewModel> {
  const BrandReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderReportsViewModel viewModel) {
    return SizedBox(
      height: Dimens().brandReportWidgetHeight,
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
                      ordersReportsGroupByBrandsWidgetTitle,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Count : ${viewModel.ordersReportGroupByBrandResponse?.reportResultSet?.length}',
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
              if (viewModel.ordersReportGroupByBrandResponse != null)
                Expanded(
                  child: ListView(
                    children: viewModel
                        .ordersReportGroupByBrandResponse!.reportResultSet!
                        .map(
                          (singleValue) => AppTableWidget.values(
                            values: [
                              AppTableSingleItem.int(
                                viewModel.ordersReportGroupByBrandResponse!
                                    .reportResultSet!
                                    .indexOf(
                                  singleValue,
                                ),
                                flexValue: Dimens().snoFlexValue,
                                textAlignment: TextAlign.center,
                              ),
                              AppTableSingleItem.string(
                                singleValue.itemBrand,
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
              if (viewModel.ordersReportGroupByBrandResponse != null)
                AppTableWidget.values(
                  values: [
                    AppTableSingleItem.string(
                      'Grand Total',
                      textAlignment: TextAlign.right,
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      flexValue: Dimens().grandTotaltFlexValue,
                    ),
                    AppTableSingleItem.int(
                      viewModel.getGrandTotalOfOrdersQtyGroupByBrand(),
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      formatNumber: true,
                      textAlignment: TextAlign.end,
                      flexValue: Dimens().quantityFlexValue,
                    ),
                    AppTableSingleItem.double(
                      viewModel.getGrandTotalOfOrdersAmountGroupByBrand(),
                      formatNumber: true,
                      textStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      flexValue: Dimens().amountFlexValue,
                      textAlignment: TextAlign.end,
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
