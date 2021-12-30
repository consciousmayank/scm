import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    Key? key,
    required this.status,
    required this.statusColor,
    required this.statusStyle,
  })  : padding = const EdgeInsets.all(8.0),
        isCompact = false,
        isDropdown = false,
        super(key: key);

  const OrderStatusWidget.compact({
    Key? key,
    required this.status,
    required this.statusColor,
    required this.statusStyle,
  })  : padding = const EdgeInsets.all(2),
        isCompact = true,
        isDropdown = false,
        super(key: key);

  const OrderStatusWidget.dropdown({
    Key? key,
    required this.status,
    required this.statusColor,
    required this.statusStyle,
  })  : padding = const EdgeInsets.all(2),
        isCompact = false,
        isDropdown = true,
        super(key: key);

  final bool isCompact;
  final bool isDropdown;
  final EdgeInsets padding;
  final String? status;
  final Color statusColor;
  final TextStyle statusStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isDropdown
            ? null
            : BorderRadius.only(
                topLeft: isCompact
                    ? const Radius.circular(
                        0,
                      )
                    : Radius.circular(
                        Dimens().defaultBorder,
                      ),
                bottomLeft: Radius.circular(
                  Dimens().defaultBorder,
                ),
                bottomRight: isCompact
                    ? Radius.circular(
                        Dimens().defaultBorder,
                      )
                    : const Radius.circular(
                        0,
                      ),
              ),
        color: statusColor,
      ),
      padding: padding,
      child: NullableTextWidget(
        stringValue: status,
        textStyle: statusStyle,
      ),
    );
  }
}
