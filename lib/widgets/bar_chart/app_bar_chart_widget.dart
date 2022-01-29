import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scm/app/appcolors.dart';
import 'package:scm/widgets/app_pop_up_menu_widget.dart';

class AppBarChartWidget extends StatelessWidget {
  const AppBarChartWidget({
    Key? key,
    this.title,
    required this.xAxisTitle,
    required this.yAxisTitle,
    required this.seriesBarData,
    required this.onClickOfOrderReportsOption,
  }) : super(key: key);

  final Function onClickOfOrderReportsOption;
  final List<charts.Series<Object, String>> seriesBarData;
  final String? title;
  final String yAxisTitle, xAxisTitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          Flexible(
            child: charts.BarChart(
              seriesBarData,
              animate: true,
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(
                  '',
                  4,
                ),
              ),
              barRendererDecorator: charts.BarLabelDecorator<String>(),
              behaviors: [
                charts.ChartTitle(
                  yAxisTitle,
                  innerPadding: 10,
                  outerPadding: 20,
                  titleStyleSpec: const charts.TextStyleSpec(
                    fontSize: 14,
                  ),
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middle,
                ),
                charts.ChartTitle(
                  xAxisTitle,
                  innerPadding: 10,
                  outerPadding: 20,
                  titleStyleSpec: const charts.TextStyleSpec(
                    fontSize: 14,
                  ),
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middle,
                ),
                charts.SlidingViewport(),
                charts.PanAndZoomBehavior(),
              ],
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: const BasicNumericTickProviderSpec(
                  zeroBound: true,
                  desiredMinTickCount: 10,
                ),
                //to show axis line
                showAxisLine: true,
                //to show labels
                renderSpec: charts.GridlineRendererSpec(
                    labelStyle: const charts.TextStyleSpec(
                      fontSize: 10,
                      color: charts.MaterialPalette.black,
                    ),
                    lineStyle: charts.LineStyleSpec(
                      color: charts.MaterialPalette.gray.shadeDefault,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
