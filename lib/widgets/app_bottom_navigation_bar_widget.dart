import 'package:flutter/material.dart';
import 'package:scm/app/apptheme.dart';
import 'package:scm/app/styles.dart';

class AppBottomNavigationBarWidget extends StatefulWidget {
  const AppBottomNavigationBarWidget({
    Key? key,
    required this.options,
    required this.selectedIndex,
    required this.onSingleOptionClicked,
  }) : super(key: key);

  final Function(int) onSingleOptionClicked;
  final List<BottomNavigationBarItem> options;
  final int selectedIndex;

  @override
  _AppBottomNavigationBarWidgetState createState() =>
      _AppBottomNavigationBarWidgetState();
}

class _AppBottomNavigationBarWidgetState
    extends State<AppBottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: widget.options,
      type: BottomNavigationBarType.fixed,

      selectedIconTheme: const IconThemeData(
        color: Colors.yellow,
        size: 25,
      ),
      selectedItemColor: Theme.of(context).colorScheme.primaryVariant,
      selectedLabelStyle: AppTextStyles(context: context)
          .mobileBottomNavigationSelectedLAbelStyle,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade200,
        size: 20,
      ),
      unselectedItemColor: Colors.grey.shade400,
      unselectedLabelStyle: AppTextStyles(context: context)
          .mobileBottomNavigationUnSelectedLAbelStyle,
      currentIndex: widget.selectedIndex,
      iconSize: 30,
      onTap: (value) {
        widget.onSingleOptionClicked(value);
      },
      // elevation: 5,
    );
  }
}
