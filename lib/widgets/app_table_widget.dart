import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

class AppTableWidget extends StatelessWidget {
  const AppTableWidget.header({
    Key? key,
    required this.values,
    this.isHeader = true,
    this.requiresPadding = true,
  }) : super(key: key);

  const AppTableWidget.values({
    Key? key,
    required this.values,
    this.isHeader = false,
    this.requiresPadding = true,
  }) : super(key: key);

  final bool isHeader, requiresPadding;
  final List<AppTableSingleItem> values;

  textValueChild({
    required bool isHeader,
    required AppTableSingleItem singleValue,
    required BuildContext context,
  }) {
    return Text(
      singleValue.getValue(),
      maxLines: singleValue.maxlines,
      overflow: TextOverflow.fade,
      textAlign: singleValue.textAlignment,
      style: isHeader && singleValue.textStyle == null
          ? Theme.of(context).textTheme.headline6?.copyWith(
                color: AppColors().primaryHeaderTextColor,
              )
          : singleValue.textStyle?.copyWith(
              color: isHeader
                  ? AppColors().primaryHeaderTextColor
                  : AppColors().black,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: values
            .map(
              (singleValue) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isHeader
                        ? Theme.of(context).primaryColorDark
                        : Colors.white,
                    border: Border.all(
                      color: isHeader
                          ? Theme.of(context).primaryColorDark
                          : Colors.grey.shade300,
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: requiresPadding
                        ? const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          )
                        : const EdgeInsets.all(0),
                    child: singleValue.customWidget ??
                        (singleValue.showToolTip
                            ? Tooltip(
                                preferBelow: false,
                                triggerMode: TooltipTriggerMode.tap,
                                message: singleValue.showToolTip
                                    ? singleValue.getValue()
                                    : null,
                                child: textValueChild(
                                  isHeader: isHeader,
                                  singleValue: singleValue,
                                  context: context,
                                ),
                              )
                            : textValueChild(
                                isHeader: isHeader,
                                singleValue: singleValue,
                                context: context,
                              )),
                  ),
                ),
                flex: singleValue.flexValue,
              ),
            )
            .toList());
  }
}

class AppTableSingleItem {
  const AppTableSingleItem.customWidget(
    this.customWidget, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.formatNumber = false,
    this.showToolTip = true,
  })  : intValue = null,
        doubleValue = null,
        stringValue = null,
        maxlines = null;

  const AppTableSingleItem.double(
    this.doubleValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.formatNumber = false,
    this.maxlines = 1,
    this.showToolTip = true,
  })  : intValue = null,
        customWidget = null,
        stringValue = null;

  const AppTableSingleItem.int(
    this.intValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.formatNumber = false,
    this.maxlines = 1,
    this.showToolTip = true,
  })  : doubleValue = null,
        customWidget = null,
        stringValue = null;

  const AppTableSingleItem.string(
    this.stringValue, {
    this.flexValue = 1,
    this.textAlignment,
    this.textStyle,
    this.maxlines = 1,
    this.showToolTip = true,
  })  : doubleValue = null,
        formatNumber = false,
        customWidget = null,
        intValue = null;

  final Widget? customWidget;
  final double? doubleValue;
  final int flexValue;
  final bool formatNumber;
  final int? intValue;
  final int? maxlines;
  final bool showToolTip;
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
