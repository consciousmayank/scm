import 'package:flutter/material.dart';
import 'package:scm/screens/pim_homescreen/dashboard/pim_dashboard_viewmodel.dart';
import 'package:scm/screens/pim_homescreen/dashboard/product_status_bar_chart/bar_chart_view.dart';
import 'package:scm/screens/pim_homescreen/dashboard/statistics/pim_supervisor_statistics_view.dart';
import 'package:scm/screens/pim_homescreen/dashboard/statistics/pim_supervisor_statistics_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

import 'userwise_products_created/userwise_products_created_view.dart';

class PimDashboardView extends StatefulWidget {
  const PimDashboardView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PimDashboardViewArguments arguments;

  @override
  _PimDashboardViewState createState() => _PimDashboardViewState();
}

class _PimDashboardViewState extends State<PimDashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PimDashboardViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            const PageBarWidget(
              title: supervisorHomePageTitle,
            ),
            Flexible(
              child: Row(
                children: [
                  //Left sided Created, Processed, Published, and Total Cards.
                  Expanded(
                    child: PimSupervisorStatisticsView(
                      arguments: PimSupervisorStatisticsViewArguments(),
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      controller: ScrollController(
                        keepScrollOffset: true,
                      ),
                      slivers: [
                        //Top Daily work summary.
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: UserwiseProductsCreatedView(
                                arguments:
                                    UserwiseProductsCreatedViewArguments(),
                              ),
                            ),
                          ),
                        ),
                        //Bar chart as per product status. Created/Published.
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 500,
                            child: BarChartBasedOnProductStatusesView(
                              arguments:
                                  BarChartBasedOnProductStatusesViewArguments(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => PimDashboardViewModel(),
    );
  }
}

class PimDashboardViewArguments {}
