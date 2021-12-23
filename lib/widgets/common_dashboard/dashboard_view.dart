import 'package:flutter/material.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_order_list_widget.dart';
import 'package:scm/widgets/common_dashboard/dashboard_viewmodel.dart';
import 'package:scm/widgets/common_dashboard/order_info_widget.dart';
import 'package:scm/widgets/common_dashboard/ordered_brands_widget.dart';
import 'package:scm/widgets/common_dashboard/ordered_types.dart';
import 'package:scm/widgets/page_bar_widget.dart';
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
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageBarWidget(title: 'DashBoard'),
            ),
            OrderInfoWidget(),
            OrderedBrands(),
            OrderedTypesWidget(),
            DashboardOrderListWidget(),
            SliverToBoxAdapter(
              child: AppFooterWidget(),
            )
          ],
        ),
      ),
      viewModelBuilder: () => CommonDashboardViewModel(),
    );
  }
}

class CommonDashboardViewArguments {}
