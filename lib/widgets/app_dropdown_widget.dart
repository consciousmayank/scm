import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.dropDownItems,
    required this.onDropDownItemSelected,
    required this.hintText,
    this.selectedOption,
    this.focusNode,
    this.labelText,
    this.innerHintText,
    this.dropDownFieldValidator,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
  }) : super(key: key);

  final Function({
    required T selectedDropdownOption,
  }) onDropDownItemSelected;

  final FormFieldValidator<T>? dropDownFieldValidator;
  final List<T> dropDownItems;
  final FloatingLabelBehavior floatingLabelBehavior;
  final FocusNode? focusNode;
  final String hintText;
  final String? labelText, innerHintText;
  final T? selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: dropDownFieldValidator,
      focusNode: focusNode,
      decoration: const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
            label: labelText != null ? Text(labelText!) : null,
            labelStyle: Theme.of(context).textTheme.subtitle2,
            hintText: innerHintText,
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.grey.shade400),
            floatingLabelBehavior: floatingLabelBehavior,
          ),
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
      onChanged: (T? value) {
        if (value != null) {
          onDropDownItemSelected(selectedDropdownOption: value);
        }
      },
      items: dropDownItems.map<DropdownMenuItem<T>>(
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
