import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';

class NullableTextWidget extends StatelessWidget {
  const NullableTextWidget({
    Key? key,
    this.stringValue,
    this.selectable = false,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.decoration,
    this.maxLines = 4,
  })  : intValue = null,
        doubleValue = null,
        super(key: key);

  const NullableTextWidget.int({
    Key? key,
    required this.intValue,
    this.selectable = false,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.decoration,
    this.maxLines = 4,
  })  : stringValue = null,
        doubleValue = null,
        super(key: key);
  const NullableTextWidget.double(
      {Key? key,
      required this.doubleValue,
      this.selectable = false,
      this.textStyle,
      this.decoration,
      this.maxLines = 4,
      this.textAlign = TextAlign.left})
      : stringValue = null,
        intValue = null,
        super(key: key);

  const NullableTextWidget.selectable(
      {this.selectable = true,
      Key? key,
      this.stringValue,
      this.textStyle,
      this.decoration,
      this.maxLines = 4,
      this.textAlign = TextAlign.left})
      : intValue = null,
        doubleValue = null,
        super(key: key);

  final BoxDecoration? decoration;
  final int maxLines;
  final bool selectable;
  final String? stringValue;
  final int? intValue;
  final double? doubleValue;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      padding: const EdgeInsets.all(
        4,
      ),
      child: selectable
          ? SelectableText(
              getValue() ?? '--',
              style: textStyle ??
                  AppTextStyles(context: context)
                      .getNormalTableNoValueTextStyle,
              maxLines: maxLines,
              textAlign: textAlign,
            )
          : Text(
              getValue() ?? '--',
              style: textStyle ??
                  AppTextStyles(context: context)
                      .getNormalTableNoValueTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              textAlign: textAlign,
            ),
    );
  }

  getValue() {
    if (intValue == null && doubleValue == null) {
      return stringValue;
    } else if (stringValue == null && doubleValue == null) {
      return intValue != null ? intValue.toString() : '--';
    } else if (stringValue == null && intValue == null) {
      return doubleValue != null ? doubleValue.toString() : '--';
    } else {
      return '--';
    }
  }
}
