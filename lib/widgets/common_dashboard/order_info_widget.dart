import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:scm/app/string_extensions.dart';

class OrderInfoWidget extends ViewModelWidget<CommonDashboardViewModel> {
  const OrderInfoWidget({
    Key? key,
    required this.onClickOfOrderTile,
  }) : super(key: key);

  final Function({
    required String clickedOrderStatus,
    required int? count,
  }) onClickOfOrderTile;

  @override
  Widget build(BuildContext context, CommonDashboardViewModel viewModel) {
    return viewModel.orderInfoApi == ApiStatus.LOADING
        ? const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: LoadingWidgetWithText(
                  text: 'Fetching Order Info,',
                ),
              ),
            ),
          )
        : SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              mainAxisExtent: Dimens().orderInfoTilesHeight,
            ),
            delegate: SliverChildListDelegate.fixed(
              [
                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus:
                            OrderStatusTypes.NEW_ORDER.apiToAppTitles,
                        count: viewModel.orderInfo.created);
                  },
                  child: OrderInfoTile.dashboard(
                    title: OrderStatusTypes.NEW_ORDER.apiToAppTitles
                        .capitalizeFirstLetter(),
                    value: viewModel.orderInfo.created.toString(),
                    icon: newProductIcon,
                    iconColor: getBorderColor(
                      status: OrderStatusTypes.CREATED.apiToAppTitles,
                    ),
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus:
                            OrderStatusTypes.UNDER_PROCESS.apiToAppTitles,
                        count: viewModel.orderInfo.processing);
                  },
                  child: OrderInfoTile.dashboard(
                    title: OrderStatusTypes.UNDER_PROCESS.apiToAppTitles
                        .capitalizeFirstLetter(),
                    value: viewModel.orderInfo.processing.toString(),
                    icon: newProductIcon,
                    iconColor: getBorderColor(
                      status: OrderStatusTypes.UNDER_PROCESS.apiToAppTitles,
                    ),
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                // OrderInfoTile(
                //   title: 'In Process',
                //   value: viewModel.orderInfo.processing.toString(),
                //   icon: scmLogo,
                // ),

                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus:
                            OrderStatusTypes.SHIPPED.apiToAppTitles,
                        count: viewModel.orderInfo.intransit);
                  },
                  child: OrderInfoTile.dashboard(
                    title: OrderStatusTypes.SHIPPED.apiToAppTitles
                        .capitalizeFirstLetter(),
                    value: viewModel.orderInfo.intransit.toString(),
                    icon: newProductIcon,
                    iconColor: getBorderColor(
                      status: OrderStatusTypes.SHIPPED.apiToAppTitles,
                    ),
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                // OrderInfoTile(
                //   title: 'In Transit',
                //   value: viewModel.orderInfo.intransit.toString(),
                //   icon: scmLogo,
                // ),
                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus:
                            OrderStatusTypes.DELIVERED.apiToAppTitles,
                        count: viewModel.orderInfo.delivered);
                  },
                  child: OrderInfoTile.dashboard(
                    title: OrderStatusTypes.DELIVERED.apiToAppTitles
                        .capitalizeFirstLetter(),
                    value: viewModel.orderInfo.delivered.toString(),
                    icon: newProductIcon,
                    iconColor: getBorderColor(
                      status: OrderStatusTypes.DELIVERED.apiToAppTitles,
                    ),
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                // OrderInfoTile(
                //   title: 'Delivered',
                //   value: viewModel.orderInfo.delivered.toString(),
                //   icon: scmLogo,
                // ),

                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus:
                            OrderStatusTypes.CANCELLED.apiToAppTitles,
                        count: viewModel.orderInfo.cancelled);
                  },
                  child: OrderInfoTile.dashboard(
                    title: OrderStatusTypes.CANCELLED.apiToAppTitles
                        .capitalizeFirstLetter(),
                    value: viewModel.orderInfo.cancelled.toString(),
                    icon: newProductIcon,
                    iconColor: getBorderColor(
                      status: OrderStatusTypes.CANCELLED.apiToAppTitles,
                    ),
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                // OrderInfoTile(
                //   title: 'Cancelled',
                //   value: viewModel.orderInfo.cancelled.toString(),
                //   icon: scmLogo,
                // ),

                AppInkwell.withBorder(
                  borderderRadius: BorderRadius.circular(8),
                  onTap: () {
                    onClickOfOrderTile(
                        clickedOrderStatus: 'ALL',
                        count: viewModel.orderInfo.all);
                  },
                  child: OrderInfoTile.dashboard(
                    title: 'Total Orders',
                    value: viewModel.orderInfo.all.toString(),
                    icon: newProductIcon,
                    iconColor: Colors.black,
                    titleTextStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                // OrderInfoTile(
                //   title: 'Total Orders',
                //   value: viewModel.orderInfo.all.toString(),
                //   icon: scmLogo,
                // ),
              ],
            ),
          );
  }
}

class OrderInfoTile extends StatelessWidget {
  const OrderInfoTile({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  })  : titleTextStyle = null,
        iconColor = Colors.white,
        super(key: key);

  const OrderInfoTile.dashboard({
    Key? key,
    required this.title,
    required this.titleTextStyle,
    required this.value,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final String title, value, icon;
  final Color iconColor;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: Dimens().getCardShape(),
        elevation: Dimens().getDefaultElevation,
        color: AppColors().white,
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titleTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors().black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              CircleAvatar(
                radius: 30,
                backgroundColor:
                    Theme.of(context).colorScheme.background.withAlpha(
                          50,
                        ),
                child: Image.asset(
                  icon,
                  height: 30,
                  width: 30,
                  color: iconColor,
                ),
              ),

              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: AppColors().dashboardOrderInfoTileTitleBg,
              //       borderRadius: BorderRadius.circular(
              //         100,
              //       ),
              //     ),
              //     child: Image.asset(
              //       icon,
              //       height: 40,
              //       width: 40,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
