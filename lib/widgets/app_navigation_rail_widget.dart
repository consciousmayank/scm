import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';

class AppNavigationRailWidget extends StatefulWidget {
  const AppNavigationRailWidget({
    Key? key,
    required this.currentIndex,
    required this.onNavigationIndexChanged,
    required this.destinations,
  }) : super(key: key);

  final Function(int) onNavigationIndexChanged;
  final int currentIndex;
  final List<NavigationRailDestination> destinations;

  @override
  _AppNavigationRailWidgetState createState() =>
      _AppNavigationRailWidgetState();
}

class _AppNavigationRailWidgetState extends State<AppNavigationRailWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: false,
      groupAlignment: 1.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedLabelTextStyle:
          AppTextStyles(context: context).navigationRailSelectedLabelTextStyle,
      unselectedLabelTextStyle: AppTextStyles(context: context)
          .navigationRailUnSelectedLabelTextStyle,
      selectedIconTheme: const IconThemeData(
        color: Colors.yellow,
        size: 25,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade200,
        size: 20,
      ),
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (int index) {
        widget.onNavigationIndexChanged(index);
      },
      labelType: NavigationRailLabelType.all,
      destinations: widget.destinations,
    );
  }
}
