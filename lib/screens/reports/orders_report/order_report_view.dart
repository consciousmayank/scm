import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/brand_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/orders_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/subtype_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/to_date_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/type_report_widget.dart';
import 'package:scm/screens/reports/orders_report/order_reports_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_container_widget.dart';
import 'package:scm/widgets/app_dropdown_widget.dart';
import 'package:stacked/stacked.dart';

class OrderReportsView extends StatefulWidget {
  final OrderReportsViewArgs arguments;
  const OrderReportsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  @override
  _OrderReportsViewState createState() => _OrderReportsViewState();
}

class _OrderReportsViewState extends State<OrderReportsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderReportsViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        appBar: appbarWidget(
          context: context,
          title: ordersReportsPageTitle,
          automaticallyImplyLeading: true,
        ),
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
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        OptionsInput.noRightPadding(
                          hintText: labelFromDate,
                          child: OrderReportsDateWidget(
                            initialDate: model.dateTimeRange.start,
                            firstDate: model.dateTimeRange.start.subtract(
                              const Duration(
                                days: 180,
                              ),
                            ),
                            dateText: model.getFromDateText(),
                            onDateChanged: ({required DateTime date}) {
                              model.updateStartDateInDateRange(date);
                            },
                          ),
                        ),
                        OptionsInput.noRightPadding(
                          hintText: labelToDate,
                          child: OrderReportsDateWidget(
                            firstDate: model.dateTimeRange.start,
                            // initialDate: model.dateTimeRange.end,
                            dateText: model.getToDateText(),
                            onDateChanged: ({required DateTime date}) {
                              model.updateEndDateInDateRange(date);
                            },
                          ),
                        ),
                        OptionsInput(
                          hintText: orderFiltersStatusOptionLabel,
                          child: Center(
                            child: AppDropDown<String>(
                              selectedOption: getApiToAppOrderStatus(
                                status: model.selectedOrderStatus,
                              ),
                              items: model.orderStatuses
                                  .map(
                                    (e) => getApiToAppOrderStatus(
                                      status: e,
                                    ),
                                  )
                                  .toList(),
                              onItemSelected: ({required String item}) {
                                model.selectedOrderStatus =
                                    getAppToApiOrderStatus(
                                  status: item,
                                );
                                model.getOrderReports();
                                model.notifyListeners();
                              },
                              hintText: orderFiltersStatusOptionLabel,
                            ),
                          ),
                        ),
                        if (model.getOrderReportsGroupByBrandApiStatus ==
                                ApiStatus.FETCHED &&
                            model.ordersReportGroupByBrandResponse != null &&
                            model.ordersReportGroupByBrandResponse
                                    ?.reportResultSet !=
                                null &&
                            model.ordersReportGroupByBrandResponse!
                                .reportResultSet!.isNotEmpty)
                          if (model.getOrderReportsGroupByBrandApiStatus ==
                                  ApiStatus.FETCHED &&
                              model.ordersReportGroupByBrandResponse != null &&
                              model.ordersReportGroupByBrandResponse
                                      ?.reportResultSet !=
                                  null &&
                              model.ordersReportGroupByBrandResponse!
                                  .reportResultSet!.isNotEmpty)
                            OptionsInput(
                              hintText: labelSelectBrand,
                              child: Center(
                                child: AppDropDown<String>(
                                  selectedOption: model.selectedBrand,
                                  items: model.brandsList,
                                  onItemSelected: ({required String item}) {
                                    if (item == labelALL) {
                                      model.selectedType = labelALL;
                                    }
                                    model.selectedBrand = item;
                                    model.getOrderReports();
                                    model.notifyListeners();
                                  },
                                  hintText: labelSelectBrand,
                                ),
                              ),
                            ),
                        if (model.getOrderReportsGroupByTypeApiStatus ==
                                ApiStatus.FETCHED &&
                            model.ordersReportGroupByTypeResponse != null &&
                            model.ordersReportGroupByTypeResponse
                                    ?.reportResultSet !=
                                null &&
                            model.ordersReportGroupByTypeResponse!
                                .reportResultSet!.isNotEmpty)
                          if (model.getOrderReportsGroupByTypeApiStatus ==
                                  ApiStatus.FETCHED &&
                              model.ordersReportGroupByTypeResponse != null &&
                              model.ordersReportGroupByTypeResponse
                                      ?.reportResultSet !=
                                  null &&
                              model.ordersReportGroupByTypeResponse!
                                  .reportResultSet!.isNotEmpty)
                            OptionsInput(
                              hintText: labelSelectType,
                              child: Center(
                                child: AppDropDown<String>(
                                  selectedOption: model.selectedType,
                                  items: model.typesList,
                                  onItemSelected: ({required String item}) {
                                    model.selectedType = item;
                                    model.getOrderReports();
                                    model.notifyListeners();
                                  },
                                  hintText: labelSelectType,
                                ),
                              ),
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
                child: getValueForScreenType(
                    context: context,
                    mobile: getMobileViewOfbrandTypeSubtypeReport(
                      context: context,
                      model: model,
                    ),
                    tablet: getTabletViewOfbrandTypeSubtypeReport(
                      context: context,
                      model: model,
                    ),
                    desktop: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: BrandReportWidget(),
                          flex: 1,
                        ),
                        Expanded(
                          child: TypeReportWidget(),
                          flex: 1,
                        ),
                        Expanded(
                          child: SubTypeReportWidget(),
                          flex: 1,
                        ),
                      ],
                    )),
              ),
              SliverToBoxAdapter(
                child: hSizedBox(
                  height: 16,
                ),
              ),
              const SliverToBoxAdapter(
                child: OrdersConsilidatedReportWidget(),
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
    );
  }

  getMobileViewOfbrandTypeSubtypeReport({
    required BuildContext context,
    required OrderReportsViewModel model,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              child: const BrandReportWidget(),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              child: const TypeReportWidget(),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              child: const SubTypeReportWidget(),
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }

  getTabletViewOfbrandTypeSubtypeReport({
    required BuildContext context,
    required OrderReportsViewModel model,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              child: const BrandReportWidget(),
              width: MediaQuery.of(context).size.width * 0.80,
            ),
            SizedBox(
              child: const TypeReportWidget(),
              width: MediaQuery.of(context).size.width * 0.80,
            ),
            SizedBox(
              child: const SubTypeReportWidget(),
              width: MediaQuery.of(context).size.width * 0.80,
            )
          ],
        ),
      ),
    );
  }
}

class OrderReportsViewArgs {}

class OptionsInput extends StatelessWidget {
  final double filterWidgetHeight = 40.0;

  final Widget child;
  final double width;
  final String hintText;
  final EdgeInsets? padding;
  const OptionsInput({
    Key? key,
    required this.child,
    required this.hintText,
  })  : width = 300,
        padding = null,
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
  })  : width = 300,
        super(key: key);

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
        AppContainerWidget(
          padding: padding,
          child: SizedBox(
            width: width,
            height: filterWidgetHeight,
            child: child,
          ),
        ),
      ],
    );
  }
}
