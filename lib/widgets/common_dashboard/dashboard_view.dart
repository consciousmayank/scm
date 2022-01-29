import 'package:flutter/material.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_order_list_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/common_dashboard/order_info_widget.dart';
import 'package:scm/widgets/common_dashboard/ordered_brands_widget.dart';
import 'package:scm/widgets/common_dashboard/ordered_subtypes_widget.dart';
import 'package:scm/widgets/common_dashboard/ordered_types.dart';
import 'package:stacked/stacked.dart';

class CommonDashboardView extends StatefulWidget {
  const CommonDashboardView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CommonDashboardViewArguments arguments;

  @override
  _CommonDashboardViewState createState() => _CommonDashboardViewState();
}

class _CommonDashboardViewState extends State<CommonDashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommonDashboardViewModel>.reactive(
      onModelReady: (model) => model.init(
          args: widget.arguments, barColor: Theme.of(context).primaryColorDark),
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            OrderInfoWidget(
              onClickOfOrderTile: (
                  {required String clickedOrderStatus, int? count}) {
                if (count != null && count > 0) {
                  widget.arguments.onClickOfOrderTile!(
                      clickedOrderStatus: clickedOrderStatus);
                } else {
                  model.showErrorSnackBar(
                    message: noOrderInState(
                      state: clickedOrderStatus,
                    ),
                  );
                }
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 8,
                  right: 8,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      labelOrderReport.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          model.getDateTimeText(),
                        ),
                        wSizedBox(
                          width: 16,
                        ),
                        Tooltip(
                          message: 'Change Date',
                          preferBelow: true,
                          child: AppButton.outline(
                            buttonBg: Theme.of(context).primaryColor,
                            suffix: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              selectDateRange(
                                context: context,
                                initialDateTimeRange: model.dateTimeRange,
                              ).then((value) {
                                if (value != null) {
                                  model.dateTimeRange = value;
                                  model.getOrderReports();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const OrderedBrands(),
            const OrderedTypesWidget(),
            const OrderedSubTypeWidget(),
            DashboardOrderListWidget(
              onClickOfOrder: ({required Order clickedOrder}) {
                widget.arguments.onClickOfOrder!(clickedOrder: clickedOrder);
              },
            ),
            const SliverToBoxAdapter(
              child: AppFooterWidget(),
            )
          ],
        ),
      ),
      viewModelBuilder: () => CommonDashboardViewModel(),
    );
  }
}

class CommonDashboardViewArguments {
  CommonDashboardViewArguments({
    this.onClickOfOrderTile,
    this.onClickOfOrder,
  });

  final Function({required String clickedOrderStatus})? onClickOfOrderTile;
  final Function({
    required Order clickedOrder,
  })? onClickOfOrder;
}
