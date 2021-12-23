import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/product_statuses.dart';
import 'package:scm/screens/pim_homescreen/dashboard/product_status_bar_chart/bar_chart_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/dashboard_sub_views_title_text.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/src/painting/text_style.dart' as text_style;

class BarChartBasedOnProductStatusesView extends StatefulWidget {
  const BarChartBasedOnProductStatusesView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final BarChartBasedOnProductStatusesViewArguments arguments;

  @override
  _BarChartBasedOnProductStatusesViewState createState() =>
      _BarChartBasedOnProductStatusesViewState();
}

class _BarChartBasedOnProductStatusesViewState
    extends State<BarChartBasedOnProductStatusesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BarChartBasedOnProductStatusesViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: model.seriesBarData.isNotEmpty
                            ? Card(
                                color: Colors.white,
                                shape: Dimens().getCardShape(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          DashboardSubViewsTitleWidget(
                                            titleText: labelBarchart(
                                              productStatus: model
                                                  .selectedProductStatus
                                                  .getStatusFirstWordCapitalisedString,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              wSizedBox(width: 4),
                                              //Created
                                              FilterChip(
                                                label: Text(ProductStatuses
                                                    .CREATED.getStatusString),
                                                labelStyle:
                                                    text_style.TextStyle(
                                                  color:
                                                      model.selectedProductStatus ==
                                                              ProductStatuses
                                                                  .CREATED
                                                          ? Colors.black
                                                          : Colors.white,
                                                ),
                                                selected: model
                                                        .selectedProductStatus ==
                                                    ProductStatuses.CREATED,
                                                onSelected: (bool selected) {
                                                  if (selected) {
                                                    model.selectedProductStatus =
                                                        ProductStatuses.CREATED;
                                                    model.notifyListeners();
                                                    model.getBarChartData();
                                                  }
                                                },
                                                selectedColor: Theme.of(context)
                                                    .primaryColorLight,
                                                checkmarkColor: Colors.black,
                                              ),
                                              wSizedBox(width: 4),
                                              // //Processed
                                              // FilterChip(
                                              //   label: Text(ProductStatuses
                                              //       .PROCESSED.getStatusString),
                                              //   labelStyle:
                                              //       text_style.TextStyle(
                                              //     color:
                                              //         model.selectedProductStatus ==
                                              //                 ProductStatuses
                                              //                     .PROCESSED
                                              //             ? Colors.black
                                              //             : Colors.white,
                                              //   ),
                                              //   selected: model
                                              //           .selectedProductStatus ==
                                              //       ProductStatuses.PROCESSED,
                                              //   onSelected: (bool selected) {
                                              //     if (selected) {
                                              //       model.selectedProductStatus =
                                              //           ProductStatuses
                                              //               .PROCESSED;
                                              //       model.notifyListeners();
                                              //       model.getBarChartData();
                                              //     }
                                              //   },
                                              //   selectedColor: Theme.of(context)
                                              //       .primaryColorLight,
                                              //   checkmarkColor: Colors.black,
                                              // ),
                                              // wSizedBox(width: 4),
                                              //Published
                                              FilterChip(
                                                label: Text(ProductStatuses
                                                    .PUBLISHED.getStatusString),
                                                labelStyle:
                                                    text_style.TextStyle(
                                                  color:
                                                      model.selectedProductStatus ==
                                                              ProductStatuses
                                                                  .PUBLISHED
                                                          ? Colors.black
                                                          : Colors.white,
                                                ),
                                                selected: model
                                                        .selectedProductStatus ==
                                                    ProductStatuses.PUBLISHED,
                                                onSelected: (bool selected) {
                                                  if (selected) {
                                                    model.selectedProductStatus =
                                                        ProductStatuses
                                                            .PUBLISHED;
                                                    model.notifyListeners();
                                                    model.getBarChartData();
                                                  }
                                                },
                                                selectedColor: Theme.of(context)
                                                    .primaryColorLight,
                                                checkmarkColor: Colors.black,
                                              ),
                                              wSizedBox(width: 4),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Flexible(
                                        child: charts.BarChart(
                                          model.seriesBarData,
                                          animate: true,
                                          domainAxis: charts.OrdinalAxisSpec(
                                            // renderSpec:
                                            //     charts.SmallTickRendererSpec(
                                            //         labelRotation: 60),
                                            viewport: charts.OrdinalViewport(
                                              model.uniqueDates.last
                                                  .split('-')[0],
                                              7,
                                            ),
                                          ),
                                          barRendererDecorator: charts
                                              .BarLabelDecorator<String>(),
                                          behaviors: [
                                            charts.ChartTitle(
                                              '${model.args.productStatus.getStatusString} Records',
                                              innerPadding: 10,
                                              outerPadding: 20,
                                              titleStyleSpec:
                                                  const charts.TextStyleSpec(
                                                fontSize: 14,
                                              ),
                                              behaviorPosition:
                                                  charts.BehaviorPosition.start,
                                              titleOutsideJustification: charts
                                                  .OutsideJustification.middle,
                                            ),
                                            charts.ChartTitle('Date',
                                                innerPadding: 10,
                                                outerPadding: 20,
                                                titleStyleSpec:
                                                    const charts.TextStyleSpec(
                                                  fontSize: 14,
                                                ),
                                                behaviorPosition: charts
                                                    .BehaviorPosition.bottom,
                                                titleOutsideJustification:
                                                    charts.OutsideJustification
                                                        .middle),
                                            charts.SlidingViewport(),
                                            charts.PanAndZoomBehavior(),
                                          ],
                                          primaryMeasureAxis:
                                              charts.NumericAxisSpec(
                                            tickProviderSpec:
                                                //     StaticNumericTickProviderSpec(
                                                //   model.listOfTicks,
                                                // ),
                                                const BasicNumericTickProviderSpec(
                                              zeroBound: true,
                                              // desiredTickCount: 10,
                                              desiredMinTickCount: 10,
                                            ),
                                            //to show axis line
                                            showAxisLine: true,
                                            //to show labels
                                            renderSpec:
                                                charts.GridlineRendererSpec(
                                                    labelStyle: const charts
                                                        .TextStyleSpec(
                                                      fontSize: 10,
                                                      color: charts
                                                          .MaterialPalette
                                                          .black,
                                                    ),
                                                    lineStyle:
                                                        charts.LineStyleSpec(
                                                      color: charts
                                                          .MaterialPalette
                                                          .gray
                                                          .shadeDefault,
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       height: 15,
                    //       width: 15,
                    //       color: AppColors().primaryColor.shade400,
                    //     ),
                    //     wSizedBox(width: 10),
                    //     Text(
                    //       "(Total Records: ${model.}, Avg: ${(viewModel.totalKmG / viewModel.kmReportListData.length).toStringAsFixed(0)})",
                    //       // "data to be shown",
                    //       style: AppTextStyles(context: context).appbarTitle,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
      ),
      viewModelBuilder: () => BarChartBasedOnProductStatusesViewModel(),
    );
  }
}

class BarChartBasedOnProductStatusesViewArguments {
  BarChartBasedOnProductStatusesViewArguments({
    this.productStatus = ProductStatuses.PUBLISHED,
  });

  final ProductStatuses productStatus;
}
