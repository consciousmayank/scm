// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_filter_duration_type.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/to_date_widget.dart';
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class OrderFiltersView extends ViewModelWidget<OrderListPageViewModel> {
  const OrderFiltersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    OrderFiltersDurationType _selectedDurationType =
        viewModel.selectedOrderDuration;
    String _selectedOrderStatus = viewModel.selectedOrderStatus;

    return Card(
      shape: Dimens().getCardShape(),
      color: AppColors().white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const PageBarWidget(
              title: orderFiltersTitle,
            ),
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Column(
                  children: const [
                    TabBar(
                      tabs: [
                        Tab(
                          text: orderFiltersStatusOptionLabel,
                        ),
                        Tab(
                          text: orderFiltersDurationOptionLabel,
                        ),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          OrderStatusesView(),
                          OrderDurationsView(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 1,
            ),
            Container(
              color: Theme.of(context).primaryColorLight,
              height: 0.5,
              width: double.infinity,
            ),
            hSizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                SizedBox(
                  height: Dimens().buttonHeight,
                  width: Dimens().buttonHeight * 2,
                  child: AppButton(
                    buttonBg: AppColors().buttonRedColor,
                    title: 'Cancel',
                    onTap: () {
                      viewModel.indexForList = 0;
                      viewModel.selectedOrderDuration = _selectedDurationType;
                      viewModel.selectedOrderStatus = _selectedOrderStatus;
                      viewModel.notifyListeners();
                    },
                  ),
                ),
                wSizedBox(width: 16),
                SizedBox(
                  width: Dimens().buttonHeight * 2,
                  height: Dimens().buttonHeight,
                  child: AppButton(
                    buttonBg: AppColors().buttonGreenColor,
                    title: 'Apply',
                    onTap: () {
                      viewModel.indexForList = 0;
                      viewModel.notifyListeners();
                      viewModel.getOrderList();
                      viewModel.log.wtf(
                          'Selected Order Status : ${viewModel.selectedOrderStatus}');
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusesView extends ViewModelWidget<OrderListPageViewModel> {
  const OrderStatusesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Column(
      children: viewModel.orderStatusList
          .map(
            (singleStatus) => RadioListTile(
              title: Text(
                singleStatus,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: viewModel.selectedOrderStatus == singleStatus
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
              ),
              value: singleStatus,
              groupValue: viewModel.selectedOrderStatus,
              onChanged: (value) {
                viewModel.selectedOrderStatus = value as String;
                viewModel.notifyListeners();
              },
              selected: viewModel.selectedOrderStatus == singleStatus,
            ),
          )
          .toList(),
    );
  }
}

class OrderDurationsView extends ViewModelWidget<OrderListPageViewModel> {
  const OrderDurationsView({
    Key? key,
  }) : super(key: key);

  buildOptions(
      {required BuildContext context,
      required OrderListPageViewModel viewModel}) {
    return OrderFiltersDurationType.values
        .map(
          (singleOrderDurationType) => RadioListTile(
            title: Text(
              singleOrderDurationType.getNames,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: viewModel.selectedOrderDuration ==
                            singleOrderDurationType
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
            ),
            value: singleOrderDurationType,
            groupValue: viewModel.selectedOrderDuration,
            onChanged: (value) {
              viewModel.selectedOrderDuration =
                  value as OrderFiltersDurationType;
              viewModel.notifyListeners();
            },
            selected:
                viewModel.selectedOrderDuration == singleOrderDurationType,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Column(
      children: [
        ...buildOptions(
          context: context,
          viewModel: viewModel,
        ),
        viewModel.selectedOrderDuration == OrderFiltersDurationType.CUSTOM
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: OrderReportsDateWidget.dashboard(
                            toolTip: labelFromDateToolTip,
                            hintText: labelFromDate,
                            initialDate: viewModel.dateTimeRange.start,
                            firstDate: getFirstDateForOrder(
                              dateTime: viewModel.dateTimeRange.start,
                            ),
                            dateText: viewModel.getFromDateText(),
                            onDateChanged: ({required DateTime date}) {
                              viewModel.updateStartDateInDateRange(date);
                            },
                          ),

                          // AppTextField(
                          //   controller: TextEditingController(
                          //     text: DateTimeToStringConverter.ddMMMMyy(
                          //       date: viewModel.dateTimeRange.end,
                          //     ).convert(),
                          //   ),
                          //   enabled: false,
                          //   hintText: 'To Date',
                          // ),
                        ),
                        wSizedBox(width: 4),
                        Expanded(
                          flex: 1,
                          child: OrderReportsDateWidget.dashboard(
                            toolTip: labelToDateToolTip,
                            hintText: labelToDate,
                            firstDate: viewModel.dateTimeRange.start,
                            // initialDate: model.dateTimeRange.end,
                            dateText: viewModel.getToDateText(),
                            onDateChanged: ({required DateTime date}) {
                              viewModel.updateEndDateInDateRange(date);
                            },
                          ),

                          // AppTextField(
                          //   controller: TextEditingController(
                          //     text: DateTimeToStringConverter.ddMMMMyy(
                          //       date: viewModel.dateTimeRange.start,
                          //     ).convert(),
                          //   ),
                          //   enabled: false,
                          //   hintText: 'From Date',
                          // ),
                        ),
                      ],
                    ),
                    hSizedBox(height: 8),
                    // SizedBox(
                    //   height: Dimens().buttonHeight,
                    //   child: AppButton(
                    //     buttonBg: AppColors().buttonGreenColor,
                    //     onTap: () async {
                    //       DateTimeRange? newDateTimeRange =
                    //           await showDateRangePicker(
                    //         saveText: orderFiltersDurationDateLabel,
                    //         context: context,
                    //         firstDate: DateTime.now().subtract(
                    //           const Duration(
                    //             days: 365,
                    //           ),
                    //         ),
                    //         lastDate: DateTime.now(),
                    //         initialDateRange: viewModel.dateTimeRange,
                    //         builder: (context, child) {
                    //           return Column(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.only(top: 50.0),
                    //                 child: SizedBox(
                    //                   height:
                    //                       MediaQuery.of(context).size.height *
                    //                           getValueForScreenType(
                    //                             context: context,
                    //                             mobile: 0.95,
                    //                             tablet: 0.85,
                    //                             desktop: 0.65,
                    //                           ),
                    //                   width: MediaQuery.of(context).size.width *
                    //                       getValueForScreenType(
                    //                         context: context,
                    //                         mobile: 0.95,
                    //                         tablet: 0.65,
                    //                         desktop: 0.35,
                    //                       ),
                    //                   child: child,
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       );

                    //       viewModel.updateDateRange(newDateTimeRange);
                    //     },
                    //     title: orderFiltersDurationDateLabel,
                    //   ),
                    // ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
