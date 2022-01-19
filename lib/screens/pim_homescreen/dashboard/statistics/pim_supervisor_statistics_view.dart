import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/pim_supervisor_dashboard_statistics_response.dart';
import 'package:scm/screens/pim_homescreen/dashboard/statistics/pim_supervisor_statistics_view.dart';
import 'package:scm/screens/pim_homescreen/dashboard/statistics/pim_supervisor_statistics_viewmodel.dart';
import 'package:scm/widgets/dashboard_sub_views_title_text.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';

class PimSupervisorStatisticsView extends StatefulWidget {
  const PimSupervisorStatisticsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PimSupervisorStatisticsViewArguments arguments;

  @override
  _PimSupervisorStatisticsViewState createState() =>
      _PimSupervisorStatisticsViewState();
}

class _PimSupervisorStatisticsViewState
    extends State<PimSupervisorStatisticsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PimSupervisorStatisticsViewModel>.reactive(
      onModelReady: (model) => model.getStatistics(),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: LoadingWidgetWithText(
                    text: 'Fetching Stats',
                  ),
                ),
              )
            : ListView(
                children: [
                  StatsCard(
                    title: 'Created',
                    stats: model.statistics.created,
                  ),
                  StatsCard(
                    title: 'Processed',
                    stats: model.statistics.processed,
                  ),
                  StatsCard(
                    title: 'Published',
                    stats: model.statistics.published,
                  ),
                  StatsCard(
                      title: 'Total', stats: model.getStatisticsGrandTotal()),
                ],
              ),
      ),
      viewModelBuilder: () => PimSupervisorStatisticsViewModel(),
    );
  }
}

class PimSupervisorStatisticsViewArguments {}

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    this.stats,
    required this.title,
  }) : super(key: key);

  final Created? stats;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Dimens().getCardShape(),
      elevation: Dimens().getDefaultElevation,
      color: Colors.white,
      child: stats != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardSubViewsTitleWidget(
                  titleText: title,
                ),
                const DottedDivider.noPadding(),
                StatsCardDataRow(
                  label: 'Products',
                  value: stats!.products,
                ),
                StatsCardDataRow(
                  label: 'Brands',
                  value: stats!.brands,
                ),
                StatsCardDataRow(
                  label: 'Types',
                  value: stats!.types,
                ),
              ],
            )
          : const NullableTextWidget(
              stringValue: 'No Data',
            ),
    );
  }
}

class StatsCardDataRow extends StatelessWidget {
  const StatsCardDataRow({Key? key, required this.label, this.value})
      : super(key: key);

  final String label;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value != null ? value.toString() : '0',
          ),
        ],
      ),
    );
  }
}
