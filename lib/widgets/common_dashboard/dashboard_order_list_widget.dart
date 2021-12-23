import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/order_list_widget.dart';
import 'package:stacked/stacked.dart';

class DashboardOrderListWidget
    extends ViewModelWidget<CommonDashboardViewModel> {
  const DashboardOrderListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CommonDashboardViewModel viewModel) {
    return viewModel.orderListApi == ApiStatus.LOADING
        ? const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: LoadingWidgetWithText(
                  text: 'Fetching Orders,',
                ),
              ),
            ),
          )
        : SliverToBoxAdapter(
            child: SizedBox(
              height: Dimens().dashboardOrderListCardHeight,
              child: OrderListWidget.dashboard(
                label: labelRecentOrders,
                isScrollable: false,
                isSupplyRole: viewModel.preferences.getSelectedUserRole() ==
                    AuthenticatedUserRoles.ROLE_SUPPLY.getStatusString,
                orders: viewModel.orderList.orders!,
              ),
            ),
          );
  }
}
