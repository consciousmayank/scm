import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class OrderInfoWidget extends ViewModelWidget<CommonDashboardViewModel> {
  const OrderInfoWidget({
    Key? key,
  }) : super(key: key);

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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 5 / 1,
            ),
            delegate: SliverChildListDelegate.fixed(
              [
                OrderInfoTile(
                  title: 'New Orders',
                  value: viewModel.orderInfo.created.toString(),
                  icon: scmLogo,
                ),
                OrderInfoTile(
                  title: 'In Process',
                  value: viewModel.orderInfo.processing.toString(),
                  icon: scmLogo,
                ),
                OrderInfoTile(
                  title: 'In Transit',
                  value: viewModel.orderInfo.intransit.toString(),
                  icon: scmLogo,
                ),
                OrderInfoTile(
                  title: 'Delivered',
                  value: viewModel.orderInfo.delivered.toString(),
                  icon: scmLogo,
                ),
                OrderInfoTile(
                  title: 'Cancelled',
                  value: viewModel.orderInfo.cancelled.toString(),
                  icon: scmLogo,
                ),
                OrderInfoTile(
                  title: 'Total Orders',
                  value: viewModel.orderInfo.all.toString(),
                  icon: scmLogo,
                ),
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
  }) : super(key: key);

  final String title, value, icon;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors().dashboardOrderInfoTileTitleBg,
                        ),
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
              backgroundColor: AppColors().dashboardOrderInfoTileTitleBg,
              child: Image.asset(
                icon,
                height: 40,
                width: 40,
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
    );
  }
}
