import 'package:flutter/material.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

class OrderItemRowWidget extends StatelessWidget {
  const OrderItemRowWidget({
    Key? key,
    required this.label,
    required this.value,
  })  : labelStyle = labelTextStyle,
        valueStyle = valueTextStyle,
        noValue = false,
        padding = const EdgeInsets.all(8.0),
        super(key: key);

  const OrderItemRowWidget.customPadding({
    Key? key,
    required this.label,
    required this.value,
    required this.padding,
  })  : labelStyle = labelTextStyle,
        valueStyle = valueTextStyle,
        noValue = false,
        super(key: key);

  const OrderItemRowWidget.noValueWithLabelStyle({
    Key? key,
    required this.label,
    required this.labelStyle,
  })  : value = '',
        padding = const EdgeInsets.all(0.0),
        noValue = true,
        valueStyle = valueTextStyle,
        super(key: key);

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle valueTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  final bool noValue;
  final EdgeInsets padding;
  final String? label, value;
  final TextStyle? labelStyle, valueStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NullableTextWidget(
            stringValue: label,
            maxLines: 2,
            textStyle: labelStyle ??
                Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
          ),
          noValue
              ? Container()
              : NullableTextWidget(
                  stringValue: value,
                  textStyle: valueStyle ??
                      Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                ),
        ],
      ),
    );
  }
}
