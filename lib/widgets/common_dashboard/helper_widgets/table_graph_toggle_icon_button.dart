import 'package:flutter/material.dart';

class AppIconToggleButton extends StatefulWidget {
  const AppIconToggleButton({
    required this.icons,
    required this.selected,
    this.stateContained = true,
    this.canUnToggle = false,
    this.multipleSelectionsAllowed = false,
    Key? key,
  }) : super(key: key);

  final Function({required int newValue}) selected;
  final bool canUnToggle;
  final List<Widget> icons;
  final bool multipleSelectionsAllowed;
  final bool stateContained;

  @override
  _AppIconToggleButtonState createState() => _AppIconToggleButtonState();
}

class _AppIconToggleButtonState extends State<AppIconToggleButton> {
  late List<bool> isSelected = [];

  @override
  void initState() {
    widget.icons.forEach(
      (e) => widget.icons.indexOf(e) == 0
          ? isSelected.add(true)
          : isSelected.add(false),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            color: Colors.black.withOpacity(0.60),
            selectedColor: selectedColor,
            selectedBorderColor: selectedColor,
            fillColor: selectedColor.withOpacity(0.08),
            splashColor: selectedColor.withOpacity(0.12),
            hoverColor: selectedColor.withOpacity(0.04),
            borderRadius: BorderRadius.circular(4.0),
            isSelected: isSelected,
            highlightColor: Colors.transparent,
            onPressed: (index) {
              // send callback
              widget.selected(newValue: index);
              // if you wish to have state:
              if (widget.stateContained) {
                if (!widget.multipleSelectionsAllowed) {
                  final selectedIndex = isSelected[index];
                  isSelected = isSelected.map((e) => e = false).toList();
                  if (widget.canUnToggle) {
                    isSelected[index] = selectedIndex;
                  }
                }
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              }
            },
            children: widget.icons,
          ),
        ],
      ),
    );
  }
}
