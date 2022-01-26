import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.hintText,
    required this.selectedOption,
  }) : super(key: key);

  final Function({required T item}) onItemSelected;
  final String hintText;
  final List<T> items;
  final T? selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      dropdownColor: AppColors().white,
      isExpanded: true,
      hint: Text(
        hintText,
        style: Theme.of(context).textTheme.button?.copyWith(
              color: AppColors().white,
            ),
      ),
      value: selectedOption,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).colorScheme.primary,
      ),
      iconSize: 30,
      underline: Container(),
      onChanged: (T? value) {
        if (value != null) {
          onItemSelected(item: value);
        }
      },
      items: items.map<DropdownMenuItem<T>>(
        (T location) {
          return DropdownMenuItem<T>(
            child: Text(
              location is String ? location : location.toString(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors().black,
                  ),
            ),
            value: location,
          );
        },
      ).toList(),
    );
  }
}
