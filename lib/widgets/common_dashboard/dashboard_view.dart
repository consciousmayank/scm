import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/to_date_widget.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
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
                    clickedOrderStatus: clickedOrderStatus,
                  );
                } else {
                  model.showInfoSnackBar(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        labelOrderReport.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.125,
                      child: OrderReportsDateWidget.dashboard(
                        toolTip: labelFromDateToolTip,
                        hintText: labelFromDate,
                        initialDate: model.dateTimeRange.start,
                        firstDate: getFirstDateForOrder(
                          dateTime: model.dateTimeRange.start,
                        ),
                        dateText: model.getFromDateText(),
                        onDateChanged: ({required DateTime date}) {
                          model.updateStartDateInDateRange(date);
                        },
                      ),
                    ),
                    wSizedBox(width: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.125,
                      child: OrderReportsDateWidget.dashboard(
                        toolTip: labelToDateToolTip,
                        hintText: labelToDate,
                        firstDate: model.dateTimeRange.start,
                        // initialDate: model.dateTimeRange.end,
                        dateText: model.getToDateText(),
                        onDateChanged: ({required DateTime date}) {
                          model.updateEndDateInDateRange(date);
                        },
                      ),
                    ),
                    wSizedBox(width: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.125,
                      child: AppTextField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        initialValue: 'Order Report',
                        helperText: 'Open Order Report',
                        buttonType: ButtonType.FULL,
                        enabled: false,
                        onButtonPressed: () => model.takeToOrderReportsPage(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const OrderedBrands(),
            const OrderedTypesWidget(),
            const OrderedSubTypeWidget(),
            DashboardOrderListWidget(
              onClickOfOrder: ({required Order clickedOrder}) {
                widget.arguments.onClickOfOrder!(
                  clickedOrder: clickedOrder,
                  clickedOrderStatus: clickedOrder.status!,
                );
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
    required String clickedOrderStatus,
  })? onClickOfOrder;
}
