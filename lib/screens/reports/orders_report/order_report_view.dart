import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/brand_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/orders_report_widget.dart';
import 'package:scm/screens/reports/orders_report/helper_widgets/subtype_report_widget.dart';
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          OptionsInput(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    model.getDateText(),
                                  ),
                                ),
                                AppButton.outline(
                                  title: 'Select Date/s',
                                  leading: const Icon(Icons.calendar_today),
                                  onTap: () async {
                                    DateTimeRange? newDateTimeRange =
                                        await showDateRangePicker(
                                      saveText: orderFiltersDurationDateLabel,
                                      context: context,
                                      firstDate: DateTime.now().subtract(
                                        const Duration(
                                          days: 365,
                                        ),
                                      ),
                                      lastDate: DateTime.now(),
                                      initialDateRange: model.dateTimeRange,
                                      builder: (context, child) {
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 50.0),
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    getValueForScreenType(
                                                      context: context,
                                                      mobile: 0.95,
                                                      tablet: 0.85,
                                                      desktop: 0.65,
                                                    ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    getValueForScreenType(
                                                      context: context,
                                                      mobile: 0.95,
                                                      tablet: 0.65,
                                                      desktop: 0.35,
                                                    ),
                                                child: child,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    model.updateDateRange(newDateTimeRange);
                                  },
                                ),
                              ],
                            ),
                          ),
                          wSizedBox(width: 16),
                          OptionsInput.small(
                            child: Center(
                              child: AppDropDown<String>(
                                  selectedOption: model.selectedOrderStatus,
                                  items: model.orderStatuses,
                                  onItemSelected: ({required String item}) {
                                    model.selectedOrderStatus = item;
                                    model.getOrderReports();
                                    model.notifyListeners();
                                  },
                                  hintText: 'Select Order Status'),
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
                            wSizedBox(width: 16),
                          if (model.getOrderReportsGroupByBrandApiStatus ==
                                  ApiStatus.FETCHED &&
                              model.ordersReportGroupByBrandResponse != null &&
                              model.ordersReportGroupByBrandResponse
                                      ?.reportResultSet !=
                                  null &&
                              model.ordersReportGroupByBrandResponse!
                                  .reportResultSet!.isNotEmpty)
                            OptionsInput.small(
                              child: Center(
                                child: AppDropDown<String>(
                                    selectedOption: model.selectedBrand,
                                    items: model.brandsList,
                                    onItemSelected: ({required String item}) {
                                      model.selectedBrand = item;
                                      model.getOrderReports();
                                      model.notifyListeners();
                                    },
                                    hintText: 'Select Brands'),
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
                            wSizedBox(width: 16),
                          if (model.getOrderReportsGroupByTypeApiStatus ==
                                  ApiStatus.FETCHED &&
                              model.ordersReportGroupByTypeResponse != null &&
                              model.ordersReportGroupByTypeResponse
                                      ?.reportResultSet !=
                                  null &&
                              model.ordersReportGroupByTypeResponse!
                                  .reportResultSet!.isNotEmpty)
                            OptionsInput.small(
                              child: Center(
                                child: AppDropDown<String>(
                                    selectedOption: model.selectedType,
                                    items: model.typesList,
                                    onItemSelected: ({required String item}) {
                                      model.selectedType = item;
                                      model.getOrderReports();
                                      model.notifyListeners();
                                    },
                                    hintText: 'Select Type'),
                              ),
                            ),
                        ],
                      ),
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
                  children: const [
                    Expanded(child: BrandReportWidget(), flex: 1),
                    Expanded(child: TypeReportWidget(), flex: 1),
                    Expanded(child: SubTypeReportWidget(), flex: 1),
                  ],
                ),
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
}

class OrderReportsViewArgs {}

const filterWidgetHeight = 60.0;

class OptionsInput extends StatelessWidget {
  final Widget child;
  final double width;
  const OptionsInput({
    Key? key,
    required this.child,
  })  : width = 500,
        super(key: key);

  const OptionsInput.small({
    Key? key,
    required this.child,
  })  : width = 200,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainerWidget(
      child: SizedBox(
        width: width,
        height: filterWidgetHeight,
        child: child,
      ),
    );
  }
}
