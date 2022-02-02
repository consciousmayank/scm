import 'package:flutter/material.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';

class OrderReportsDateWidget extends StatelessWidget {
  const OrderReportsDateWidget({
    Key? key,
    required this.dateText,
    required this.onDateChanged,
    this.firstDate,
    this.initialDate,
  })  : isDashboard = false,
        hintText = null,
        toolTip = null,
        super(key: key);

  const OrderReportsDateWidget.dashboard({
    Key? key,
    required this.dateText,
    required this.onDateChanged,
    this.firstDate,
    this.initialDate,
    required this.toolTip,
    required this.hintText,
  })  : isDashboard = true,
        super(key: key);

  final Function({required DateTime date}) onDateChanged;
  final String dateText;
  final DateTime? initialDate, firstDate;
  final bool isDashboard;
  final String? hintText, toolTip;

  selectDate({
    required BuildContext context,
  }) async {
    DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: Theme.of(context).colorScheme,
          ),
          child: child!,
        );
      },
      helpText: 'Select Date',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Expiration Date',
      fieldHintText: 'Year/Month/Day',
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? getFirstDateForOrder(),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      onDateChanged(date: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isDashboard
        ? AppTextField(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: hintText,
            controller: TextEditingController(text: dateText),
            buttonType: ButtonType.FULL,
            enabled: false,
            onButtonPressed: () => selectDate(context: context),
          )
        : Row(
            children: [
              Expanded(
                child: Text(
                  dateText,
                ),
              ),
              AppButton.outline(
                suffix: const Icon(Icons.calendar_today),
                onTap: () => selectDate(context: context),
              ),
            ],
          );
  }
}
