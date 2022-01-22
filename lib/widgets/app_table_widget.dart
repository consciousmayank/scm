import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scm/app/dimens.dart';

class AppTableWidget extends StatelessWidget {
  const AppTableWidget.header({
    Key? key,
    required this.values,
    this.isHeader = true,
  }) : super(key: key);

  const AppTableWidget.values({
    Key? key,
    required this.values,
    this.isHeader = false,
  }) : super(key: key);

  final bool isHeader;
  final List<AppTableSingleItem> values;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: values
            .map(
              (singleValue) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isHeader
                        ? Theme.of(context).colorScheme.background
                        : Colors.white,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.background,
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      singleValue.getValue(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: singleValue.textAlignment,
                      style: singleValue.textStyle,
                    ),
                  ),
                ),
                flex: singleValue.flexValue,
              ),
            )
            .toList()

        // [
        //   Expanded(
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: isHeader
        //             ? Theme.of(context).colorScheme.background
        //             : Colors.white,
        //         border: Border.all(
        //           color: Theme.of(context).colorScheme.background,
        //           width: 0.5,
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Text(
        //           values[0],
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //     flex: 1,
        //   ),
        //   Expanded(
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: isHeader
        //             ? Theme.of(context).colorScheme.background
        //             : Colors.white,
        //         border: Border.all(
        //           color: Theme.of(context).colorScheme.background,
        //           width: 0.5,
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Text(
        //           values[1],
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //     flex: 4,
        //   ),
        //   Expanded(
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: isHeader
        //             ? Theme.of(context).colorScheme.background
        //             : Colors.white,
        //         border: Border.all(
        //           color: Theme.of(context).colorScheme.background,
        //           width: 0.5,
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Text(
        //           values[2],
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //     flex: 3,
        //   ),
        // ],
        );
  }
}

class AppTableSingleItem {
  const AppTableSingleItem.double(
    this.doubleValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.formatNumber = false,
  })  : intValue = null,
        stringValue = null;

  const AppTableSingleItem.int(
    this.intValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.formatNumber = false,
  })  : doubleValue = null,
        stringValue = null;

  const AppTableSingleItem.string(
    this.stringValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
  })  : doubleValue = null,
        formatNumber = false,
        intValue = null;

  final double? doubleValue;
  final int flexValue;
  final bool formatNumber;
  final int? intValue;
  final String? stringValue;
  final TextAlign? textAlignment;
  final TextStyle? textStyle;

  getValue() {
    var format = NumberFormat.currency(locale: 'HI');
    if (intValue == null && doubleValue == null) {
      return stringValue ?? '--';
    } else if (stringValue == null && doubleValue == null) {
      return intValue != null
          ? formatNumber
              ? format.format(intValue).replaceAll('INR', '')
              : intValue.toString()
          : '--';
    } else if (stringValue == null && intValue == null) {
      return doubleValue != null
          ? formatNumber
              ? format.format(doubleValue).replaceAll('INR', '')
              : doubleValue?.toStringAsFixed(2)
          : '--';
    } else {
      return '--';
    }
  }
}
