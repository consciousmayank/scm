import 'package:flutter/material.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/bar_chart/app_bar_chart_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/common_dashboard/table_items_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class OrderedBrands extends ViewModelWidget<CommonDashboardViewModel> {
  const OrderedBrands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CommonDashboardViewModel viewModel) {
    return viewModel.orderedBrandsApi == ApiStatus.LOADING
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Top 5 Ordered Brands',
                                style: Theme.of(context).textTheme.headline6,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const TopOrderedBrandsCategoryTable.header(),
                            ...viewModel.orderedBrands
                                .map(
                                  (singleBrand) =>
                                      TopOrderedBrandsCategoryTable.values(
                                    values: [
                                      '${viewModel.orderedBrands.indexOf(singleBrand) + 1}',
                                      '${singleBrand.brand}',
                                      '${singleBrand.count}',
                                    ],
                                  ),
                                )
                                .toList()
                          ],
                        ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppBarChartWidget(
                          title: 'Order Report',
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
