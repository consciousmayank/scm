import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/order_report_widget.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:scm/widgets/bar_chart/app_bar_chart_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/common_dashboard/helper_widgets/table_graph_toggle_icon_button.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class OrderedSubTypeWidget extends ViewModelWidget<CommonDashboardViewModel> {
  const OrderedSubTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CommonDashboardViewModel viewModel) {
    return viewModel.busy(
              orderedSubTypeApi,
            ) ||
            viewModel.busy(getOrderReportsGroupBySubTypeApiStatus)
        ? const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: LoadingWidgetWithText(
                  text: 'Fetching Ordered Sub Categories,',
                ),
              ),
            ),
          )
        : SliverToBoxAdapter(
            child: SizedBox(
              height: Dimens().dashboardOrderedBrandsInfoCardHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Card(
                      shape: Dimens().getCardShape(),
                      elevation: Dimens().getDefaultElevation,
                      color: AppColors().white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sub Category',
                                  style: Theme.of(context).textTheme.subtitle1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                AppIconToggleButton(
                                  icons: [
                                    Tooltip(
                                      message: 'Table View',
                                      preferBelow: true,
                                      child: Image.asset(
                                        tableToggleIcon,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Graphical View',
                                      preferBelow: true,
                                      child: Image.asset(
                                        graphToogleIcon,
                                        height: 30,
                                        width: 30,
                                      ),
                                    )
                                  ],
                                  selected: ({required int newValue}) {
                                    viewModel.reportsBySubCategoryIndex =
                                        newValue;
                                    viewModel.notifyListeners();
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: viewModel.busy(
                                    getOrderReportsGroupBySubTypeApiStatus)
                                ? const LoadingWidget()
                                : IndexedStack(
                                    index: viewModel.reportsBySubCategoryIndex,
                                    children: [
                                      ReportWidget.dashBoardGroupBySubCategory(
                                        amountGrandTotal:
                                            getAmountGrandTotalOfOrderReport(
                                          reportResponse: viewModel
                                              .ordersReportGroupBySubTypeResponse,
                                        ),
                                        quantityGrandTotal:
                                            getQuantityGrandTotalOfOrderReport(
                                          reportResponse: viewModel
                                              .ordersReportGroupBySubTypeResponse,
                                        ),
                                        reportResponse: viewModel
                                            .ordersReportGroupBySubTypeResponse,
                                      ),
                                      AppBarChartWidget.grouped(
                                        seriesBarData: viewModel
                                            .ordersReportGroupBySubTypeBarData,
                                        xAxisTitle: 'Sub Category',
                                        yAxisTitle: '',
                                        onClickOfOrderReportsOption: () {
                                          viewModel.navigationService
                                              .navigateTo(
                                            orderReportsScreenPageRoute,
                                            arguments: OrderReportsViewArgs(
                                              orderStatus:
                                                  OrderStatusTypes.DELIVERED,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  wSizedBox(width: 8),
                  Flexible(
                    child: Card(
                      shape: Dimens().getCardShape(),
                      elevation: Dimens().getDefaultElevation,
                      color: AppColors().white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Trending Sub Categories',
                                  style: Theme.of(context).textTheme.subtitle1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                AppIconToggleButton(
                                  icons: [
                                    Tooltip(
                                      message: 'Table View',
                                      preferBelow: true,
                                      child: Image.asset(
                                        tableToggleIcon,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Graphical View',
                                      preferBelow: true,
                                      child: Image.asset(
                                        graphToogleIcon,
                                        height: 30,
                                        width: 30,
                                      ),
                                    )
                                  ],
                                  selected: ({required int newValue}) {
                                    viewModel.trendingSubCategoriesIndex =
                                        newValue;
                                    viewModel.notifyListeners();
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: IndexedStack(
                              index: viewModel.trendingSubCategoriesIndex,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTableWidget.header(
                                        values: [
                                          AppTableSingleItem.string(
                                            '#',
                                            flexValue:
                                                Dimens().snoFlexValueTrending,
                                            textAlignment: TextAlign.center,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .button
                                                ?.copyWith(
                                                  color: AppColors()
                                                      .primaryHeaderTextColor,
                                                ),
                                          ),
                                          AppTableSingleItem.string(
                                            'Name',
                                            textAlignment: TextAlign.start,
                                            flexValue:
                                                Dimens().nameFlexValueTrending,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .button
                                                ?.copyWith(
                                                  color: AppColors()
                                                      .primaryHeaderTextColor,
                                                ),
                                          ),
                                          AppTableSingleItem.string(
                                            labelCount,
                                            textAlignment: TextAlign.end,
                                            flexValue:
                                                Dimens().countFlexValueTrending,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .button
                                                ?.copyWith(
                                                  color: AppColors()
                                                      .primaryHeaderTextColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      // '${viewModel.orderedBrands.indexOf(singleBrand) + 1}',
                                      // '${singleBrand.brand}',
                                      // '${singleBrand.count}',
                                      ...viewModel.orderedSubTypes
                                          .map(
                                            (singleBrand) =>
                                                AppTableWidget.values(
                                              values: [
                                                AppTableSingleItem.int(
                                                  viewModel.orderedSubTypes
                                                          .indexOf(
                                                              singleBrand) +
                                                      1,
                                                  flexValue: Dimens()
                                                      .snoFlexValueTrending,
                                                  textAlignment:
                                                      TextAlign.center,
                                                ),
                                                AppTableSingleItem.string(
                                                  singleBrand.subType,
                                                  textAlignment:
                                                      TextAlign.start,
                                                  flexValue: Dimens()
                                                      .nameFlexValueTrending,
                                                ),
                                                AppTableSingleItem.int(
                                                  singleBrand.count,
                                                  flexValue: Dimens()
                                                      .countFlexValueTrending,
                                                  textAlignment: TextAlign.end,
                                                )
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      Expanded(
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              AppTableWidget.values(
                                            values: [
                                              AppTableSingleItem.string(
                                                '',
                                                flexValue: Dimens()
                                                    .snoFlexValueTrending,
                                                textAlignment: TextAlign.center,
                                              ),
                                              AppTableSingleItem.string(
                                                '',
                                                textAlignment: TextAlign.start,
                                                flexValue: Dimens()
                                                    .nameFlexValueTrending,
                                              ),
                                              AppTableSingleItem.string(
                                                '',
                                                flexValue: Dimens()
                                                    .countFlexValueTrending,
                                                textAlignment: TextAlign.end,
                                              )
                                            ],
                                          ),
                                          itemCount: 10 -
                                              viewModel.orderedSubTypes.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppBarChartWidget(
                                  seriesBarData:
                                      viewModel.orderedSubTypesBarData,
                                  xAxisTitle: 'Sub Categories',
                                  yAxisTitle: 'Count',
                                  onClickOfOrderReportsOption: () {
                                    viewModel.navigationService.navigateTo(
                                      orderReportsScreenPageRoute,
                                      arguments: OrderReportsViewArgs(
                                        orderStatus: OrderStatusTypes.DELIVERED,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          );
  }
}
