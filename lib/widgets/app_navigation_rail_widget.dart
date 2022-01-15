import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';

class AppNavigationRailWidget extends StatefulWidget {
  const AppNavigationRailWidget({
    Key? key,
    required this.currentIndex,
    required this.onNavigationIndexChanged,
    required this.destinations,
    this.leading,
  }) : super(key: key);

  final Function(int) onNavigationIndexChanged;
  final int currentIndex;
  final List<NavigationRailDestination> destinations;
  final Widget? leading;

  @override
  _AppNavigationRailWidgetState createState() =>
      _AppNavigationRailWidgetState();
}

class _AppNavigationRailWidgetState extends State<AppNavigationRailWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      leading: widget.leading,
      extended: false,
      groupAlignment: 1.0,
      selectedIndex: widget.currentIndex,
      onDestinationSelected: (int index) {
        widget.onNavigationIndexChanged(index);
      },
      destinations: widget.destinations,
    );
  }
}
