import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

const labelTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const valueTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

class LabelValueDataShowWidget extends StatelessWidget {
  const LabelValueDataShowWidget({
    Key? key,
    required this.label,
    required this.value,
  })  : labelStyle = labelTextStyle,
        valueStyle = valueTextStyle,
        isRow = true,
        super(key: key);

  const LabelValueDataShowWidget.column({
    Key? key,
    required this.label,
    required this.value,
  })  : labelStyle = labelTextStyle,
        valueStyle = valueTextStyle,
        isRow = false,
        super(key: key);

  const LabelValueDataShowWidget.columnWithTextStyles({
    Key? key,
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
  })  : isRow = false,
        super(key: key);

  const LabelValueDataShowWidget.rowWithTextStyles({
    Key? key,
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
  })  : isRow = true,
        super(key: key);

  final bool isRow;
  final String? label;
  final String? value;
  final TextStyle labelStyle, valueStyle;

  @override
  Widget build(BuildContext context) {
    return isRow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NullableTextWidget(
                stringValue: label,
                textStyle: labelStyle,
              ),
              NullableTextWidget(
                stringValue: value,
                textStyle: valueStyle,
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NullableTextWidget(
                stringValue: label,
                textStyle: labelStyle,
              ),
              NullableTextWidget(
                stringValue: value,
                textStyle: valueStyle,
              ),
            ],
          );
  }
}
