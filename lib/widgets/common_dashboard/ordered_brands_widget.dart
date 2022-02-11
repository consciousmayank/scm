import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
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

class OrderedBrands extends ViewModelWidget<CommonDashboardViewModel> {
  const OrderedBrands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CommonDashboardViewModel viewModel) {
    return viewModel.busy(orderedBrandsApi) ||
            viewModel.busy(getOrderReportsGroupByBrandApiStatus)
        ? const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: LoadingWidgetWithText(
                  text: 'Fetching Ordered Brands,',
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
                                  'Brands',
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
                                    viewModel.reportsByBrandsIndex = newValue;
                                    viewModel.notifyListeners();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: viewModel
                                    .busy(getOrderReportsGroupByBrandApiStatus)
                                ? const LoadingWidget()
                                : IndexedStack(
                                    index: viewModel.reportsByBrandsIndex,
                                    children: [
                                      ReportWidget.dashBoardGroupByBrands(
                                        amountGrandTotal:
                                            getAmountGrandTotalOfOrderReport(
                                          reportResponse: viewModel
                                              .ordersReportGroupByBrandResponse,
                                        ),
                                        quantityGrandTotal:
                                            getQuantityGrandTotalOfOrderReport(
                                          reportResponse: viewModel
                                              .ordersReportGroupByBrandResponse,
                                        ),
                                        reportResponse: viewModel
                                            .ordersReportGroupByBrandResponse,
                                      ),
                                      AppBarChartWidget.grouped(
                                        seriesBarData: viewModel
                                            .ordersReportGroupByBrandBarData,
                                        xAxisTitle: 'Brands',
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
                                  'Trending Brands',
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
                                    viewModel.trendingBrandsIndex = newValue;
                                    viewModel.notifyListeners();
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: IndexedStack(
                              index: viewModel.trendingBrandsIndex,
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
                                      ...viewModel.orderedBrands
                                          .map(
                                            (singleBrand) =>
                                                AppTableWidget.values(
                                              values: [
                                                AppTableSingleItem.int(
                                                  viewModel.orderedBrands
                                                          .indexOf(
                                                              singleBrand) +
                                                      1,
                                                  flexValue: Dimens()
                                                      .snoFlexValueTrending,
                                                  textAlignment:
                                                      TextAlign.center,
                                                ),
                                                AppTableSingleItem.string(
                                                  singleBrand.brand,
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
                                              const NeverScrollableScrollPhysics(),
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
                                              viewModel.orderedBrands.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppBarChartWidget(
                                  seriesBarData: viewModel.orderedBrandsBarData,
                                  xAxisTitle: 'Brands',
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
