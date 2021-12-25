import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/app_textfield.dart';

class QuantityWidget extends StatefulWidget {
  final Function({required String value}) onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int quantity;
  final int index;
  final String hint;
  const QuantityWidget(
      {Key? key,
      required this.index,
      required this.quantity,
      required this.onChanged,
      required this.hint,
      required this.focusNode,
      required this.controller})
      : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.quantity.toString();
    // widget.focusNode.addListener(() {
    //   if (!widget.focusNode.hasFocus) {
    //     widget.onChanged(value: widget.controller.text);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      formatter: <TextInputFormatter>[
        Dimens().getNumericTextInputFormatter,
      ],
      innerHintText: widget.hint,

      // autoFocus: true,
      // onTextChange: (value) {
      //   onChanged(value: value);
      // },
      onFieldSubmitted: (value) {
        widget.onChanged(value: value);
      },
    );
  }
}

class PriceWidget extends StatefulWidget {
  final Function({required String value}) onChanged;
  final double price;
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  const PriceWidget({
    Key? key,
    required this.index,
    required this.price,
    required this.onChanged,
    required this.focusNode,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.price.toString();
    // widget.focusNode.addListener(() {
    //   if (!widget.focusNode.hasFocus) {
    //     widget.onChanged(value: widget.controller.text);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      formatter: <TextInputFormatter>[
        Dimens().getNumericTextInputFormatter,
      ],
      innerHintText: widget.hint,
      controller: widget.controller,
      focusNode: widget.focusNode,
      // autoFocus: true,
      // onTextChange: (value) {
      //   onChanged(value: value);
      // },
      onFieldSubmitted: (value) {
        widget.onChanged(value: value);
      },
    );
  }
}