import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
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
  const OrderReportsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final OrderReportsViewArgs arguments;

  @override
  _OrderReportsViewState createState() => _OrderReportsViewState();
}

class _OrderReportsViewState extends State<OrderReportsView> {
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
                      child: Row(
                        children: [
                          Expanded(
                            child: OptionsInput.noRightPadding(
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
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child: OptionsInput.noRightPadding(
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
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child: OptionsInput(
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
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child:
                                // (model.getOrderReportsGroupByBrandApiStatus ==
                                //         ApiStatus.FETCHED &&
                                //     model.ordersReportGroupByBrandResponse != null &&
                                //     model.ordersReportGroupByBrandResponse
                                //             ?.reportResultSet !=
                                //         null &&
                                //     model.ordersReportGroupByBrandResponse!
                                //         .reportResultSet!.isNotEmpty)
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
                            flex: 1,
                          ),
                          wSizedBox(width: 8),
                          Expanded(
                            child:
                                //  if (model.getOrderReportsGroupByTypeApiStatus ==
                                //         ApiStatus.FETCHED &&
                                //     model.ordersReportGroupByTypeResponse != null &&
                                //     model.ordersReportGroupByTypeResponse
                                //             ?.reportResultSet !=
                                //         null &&
                                //     model.ordersReportGroupByTypeResponse!
                                //         .reportResultSet!.isNotEmpty)
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
      ),
    );
  }
}

class OrderReportsViewArgs {}

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
