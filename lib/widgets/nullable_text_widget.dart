import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';

class NullableTextWidget extends StatelessWidget {
  const NullableTextWidget({
    Key? key,
    this.text,
    this.selectable = false,
    this.textColorWhilePressing = Colors.black,
    this.textStyle,
    this.decoration,
    this.maxLines = 4,
  }) : super(key: key);

  const NullableTextWidget.selectable({
    this.selectable = true,
    Key? key,
    this.text,
    this.textStyle,
    this.decoration,
    this.textColorWhilePressing = Colors.black,
    this.maxLines = 4,
  }) : super(key: key);

  const NullableTextWidget.withDecoration({
    Key? key,
    required this.decoration,
    this.text,
    this.selectable = false,
    this.textStyle,
    required this.textColorWhilePressing,
    this.maxLines = 4,
  }) : super(key: key);

  final BoxDecoration? decoration;
  final int maxLines;
  final bool selectable;
  final String? text;
  final Color textColorWhilePressing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    text != null
        ? textStyle != null
            ? textStyle!.copyWith(
                color: textColorWhilePressing,
              )
            : AppTextStyles(context: context).getNormalTableTextStyle.copyWith(
                  color: textColorWhilePressing,
                )
        : AppTextStyles(context: context).getNormalTableNoValueTextStyle;

    return Container(
      decoration: decoration,
      padding: const EdgeInsets.all(
        4,
      ),
      child: selectable
          ? SelectableText(
              text ?? '--',
              style: textStyle,
              maxLines: 4,
            )
          : Text(
              text ?? '--',
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
    );
  }
}
