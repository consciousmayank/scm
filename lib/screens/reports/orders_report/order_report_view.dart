import 'package:flutter/material.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/order_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/to_date_widget.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_container_widget.dart';
import 'package:scm/widgets/app_dropdown_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/no_data_widget.dart';
import 'package:stacked/stacked.dart';

class OrderReportsView extends StatefulWidget {
  const OrderReportsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final OrderReportsViewArgs arguments;

  @override
  _OrderReportsViewState createState() => _OrderReportsViewState();
}

class _OrderReportsViewState extends State<OrderReportsView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const NotSupportedScreensView(),
      tablet: (BuildContext context) => const NotSupportedScreensView(),
      desktop: (BuildContext context) =>
          ViewModelBuilder<OrderReportsViewModel>.reactive(
        onModelReady: (model) => model.init(args: widget.arguments),
        builder: (context, model, child) => Scaffold(
          appBar: appbarWidget(
              context: context,
              title: ordersReportsPageTitle,
              automaticallyImplyLeading: true,
              options: [
                IconButton(
                  onPressed: model.getOrderReportsGroupByTypeApiStatus ==
                              ApiStatus.FETCHED &&
                          model.getConsolidatedOrderReportsApiStatus ==
                              ApiStatus.FETCHED &&
                          model.getOrderReportsGroupByBrandApiStatus ==
                              ApiStatus.FETCHED &&
                          model.getOrderReportsGroupBySubTypeApiStatus ==
                              ApiStatus.FETCHED
                      ? () {
                          model.writeOnPdf();
                        }
                      : null,
                  icon: const Icon(
                    Icons.picture_as_pdf_outlined,
                  ),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Card(
                    elevation: Dimens().getDefaultElevation,
                    shape: Dimens().getCardShape(),
                    color: AppColors().white,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OrderReportsDateWidget.dashboard(
                              toolTip: labelFromDateToolTip,
                              initialDate: model.dateTimeRange.start,
                              firstDate: getFirstDateForOrder(
                                  dateTime: model.dateTimeRange.start),
                              dateText: model.getFromDateText(),
                              onDateChanged: ({required DateTime date}) {
                                model.updateStartDateInDateRange(date);
                              },
                              hintText: labelToDate,
                            ),
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child: OrderReportsDateWidget.dashboard(
                              toolTip: labelToDateToolTip,
                              firstDate: model.dateTimeRange.start,
                              // initialDate: model.dateTimeRange.end,
                              dateText: model.getToDateText(),
                              onDateChanged: ({required DateTime date}) {
                                model.updateEndDateInDateRange(date);
                              },
                              hintText: labelFromDate,
                            ),
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child: AppTextField<String>.dropDown(
                              tooltTipText: labelSelectBrand,
                              hintText: labelSelectBrand,
                              labelText: labelSelectBrand,
                              dropDownItems: model.brandsList,
                              onDropDownItemSelected: (
                                  {required String? selectedValue}) {
                                if (selectedValue != null) {
                                  if (selectedValue == labelALL) {
                                    model.selectedType = labelALL;
                                  }
                                  model.selectedBrand = selectedValue;
                                  model.getOrderReports();
                                  model.notifyListeners();
                                }
                              },
                            ),
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child: AppTextField.dropDown(
                              tooltTipText: labelSelectType,
                              hintText: labelSelectType,
                              labelText: labelSelectType,
                              dropDownItems: model.typesList,
                              onDropDownItemSelected: (
                                  {required String? selectedValue}) {
                                if (selectedValue != null) {
                                  if (selectedValue == labelALL) {
                                    model.selectedType = labelALL;
                                  }
                                  model.selectedType = selectedValue;
                                  model.getOrderReports();
                                  model.notifyListeners();
                                }
                              },
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: hSizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: model.getOrderReportsGroupByBrandApiStatus ==
                                ApiStatus.LOADING
                            ? const LoadingReportsWidget(
                                loadingText:
                                    'Fetching Order Report group by Brands.',
                              )
                            : model.ordersReportGroupByBrandResponse
                                    .reportResultSet!.isEmpty
                                ? const NoDataWidget(
                                    text: labelNoData,
                                  )
                                : ReportWidget.groupByBrands(
                                    title:
                                        ordersReportsGroupByBrandsWidgetTitle,
                                    amountGrandTotal: model
                                        .getGrandTotalOfOrdersAmountGroupByBrand(),
                                    quantityGrandTotal: model
                                        .getGrandTotalOfOrdersQtyGroupByBrand(),
                                    reportResponse:
                                        model.ordersReportGroupByBrandResponse,
                                  ),
                        flex: 1,
                      ),
                      Expanded(
                        child: model.getOrderReportsGroupByTypeApiStatus ==
                                ApiStatus.LOADING
                            ? const LoadingReportsWidget(
                                loadingText:
                                    'Fetching Order Report group by Category.',
                              )
                            : model.ordersReportGroupByBrandResponse
                                    .reportResultSet!.isEmpty
                                ? const NoDataWidget(
                                    text: labelNoData,
                                  )
                                : ReportWidget.groupByCategory(
                                    title: ordersReportsGroupByTypeWidgetTitle,
                                    amountGrandTotal: model
                                        .getGrandTotalOfOrdersAmountGroupByType(),
                                    quantityGrandTotal: model
                                        .getGrandTotalOfOrdersQtyGroupByType(),
                                    reportResponse:
                                        model.ordersReportGroupByTypeResponse,
                                  ),
                        flex: 1,
                      ),
                      Expanded(
                        child: model.getOrderReportsGroupBySubTypeApiStatus ==
                                ApiStatus.LOADING
                            ? const LoadingReportsWidget(
                                loadingText:
                                    'Fetching Order Report group by Sub Category.',
                              )
                            : model.ordersReportGroupBySubTypeResponse
                                    .reportResultSet!.isEmpty
                                ? const NoDataWidget(
                                    text: labelNoData,
                                  )
                                : ReportWidget.groupBySubCategory(
                                    title:
                                        ordersReportsGroupBySubTypeWidgetTitle,
                                    amountGrandTotal: model
                                        .getGrandTotalOfOrdersAmountGroupBySubType(),
                                    quantityGrandTotal: model
                                        .getGrandTotalOfOrdersQtyGroupBySubType(),
                                    reportResponse: model
                                        .ordersReportGroupBySubTypeResponse,
                                  ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: hSizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  // child: OrdersConsilidatedReportWidget(),
                  child: model.getConsolidatedOrderReportsApiStatus ==
                          ApiStatus.LOADING
                      ? const LoadingReportsWidget(
                          loadingText: 'Fetching Consolidated Order Report.',
                        )
                      : model.consolidatedOrdersReportResponse.reportResultSet!
                              .isEmpty
                          ? const NoDataWidget(
                              text: labelNoData,
                            )
                          : ReportWidget.consolidated(
                              title: consolidatedOrdersReportsWidgetTitle,
                              amountGrandTotal: model
                                  .getGrandTotalOfConsolidatedOrdersAmount(),
                              quantityGrandTotal:
                                  model.getGrandTotalOfConsolidatedOrdersQty(),
                              reportResponse:
                                  model.consolidatedOrdersReportResponse,
                            ),
                ),
                SliverToBoxAdapter(
                  child: hSizedBox(
                    height: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => OrderReportsViewModel(),
      ),
    );
  }
}

class OrderReportsViewArgs {
  OrderReportsViewArgs({
    required this.orderStatus,
  });

  final OrderStatusTypes orderStatus;
}

class OptionsInput extends StatelessWidget {
  const OptionsInput({
    Key? key,
    required this.child,
    required this.hintText,
  })  : padding = null,
        super(key: key);

  const OptionsInput.noRightPadding({
    Key? key,
    required this.child,
    required this.hintText,
    this.padding = const EdgeInsets.only(
      left: 16,
      right: 2,
      top: 2,
      bottom: 2,
    ),
  }) : super(key: key);

  final Widget child;
  final double filterWidgetHeight = 40.0;
  final String hintText;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        AppContainerWidget.customFilledColor(
          padding: padding,
          filledColor: AppColors().white,
          child: SizedBox(
            height: filterWidgetHeight,
            child: child,
          ),
        ),
      ],
    );
  }
}

class LoadingReportsWidget extends StatelessWidget {
  const LoadingReportsWidget({
    Key? key,
    required this.loadingText,
  }) : super(key: key);

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Dimens().getCardShape(),
      elevation: Dimens().getDefaultElevation,
      color: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        margin: const EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.20,
        ),
        alignment: Alignment.center,
        child: LoadingWidgetWithText(
          text: loadingText,
        ),
      ),
    );
  }
}

// class NoDataForReportsWidget extends StatelessWidget {
//   const NoDataForReportsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: Dimens().getCardShape(),
//       elevation: Dimens().getDefaultElevation,
//       color: Colors.white,
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.5,
//         margin: const EdgeInsets.all(8),
//         padding: EdgeInsets.symmetric(
//           vertical: MediaQuery.of(context).size.height * 0.20,
//         ),
//         alignment: Alignment.center,
//         child: const Text('No Data'),
//       ),
//     );
//   }
// }
