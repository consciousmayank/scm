import 'package:flutter/material.dart';
import 'package:scm/screens/supply_module_screens/dashboard/supply_dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SupplyDashboardView extends StatefulWidget {
  final SupplyDashboardViewArguments arguments;
  const SupplyDashboardView({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  @override
  _SupplyDashboardViewState createState() => _SupplyDashboardViewState();
}

class _SupplyDashboardViewState extends State<SupplyDashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SupplyDashboardViewModel>.reactive(
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: Text('This is the Dashboard of Supply Modeule.'),
        ),
      ),
      viewModelBuilder: () => SupplyDashboardViewModel(),
    );
  }
}

class SupplyDashboardViewArguments {}
