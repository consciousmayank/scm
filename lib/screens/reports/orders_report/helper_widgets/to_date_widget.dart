import 'package:flutter/material.dart';
import 'package:scm/widgets/app_button.dart';

class OrderReportsDateWidget extends StatelessWidget {
  const OrderReportsDateWidget({
    Key? key,
    required this.dateText,
    required this.onDateChanged,
    this.firstDate,
    this.initialDate,
  }) : super(key: key);

  final Function({required DateTime date}) onDateChanged;
  final String dateText;
  final DateTime? initialDate, firstDate;

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
      firstDate: firstDate ??
          DateTime.now().subtract(
            const Duration(
              days: 2,
            ),
          ),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      onDateChanged(date: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
