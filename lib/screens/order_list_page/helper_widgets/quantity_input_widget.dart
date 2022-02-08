import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/app_textfield.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    required Key? key,
    required this.index,
    required this.quantity,
    required this.onChanged,
    required this.hint,
    // required this.focusNode,
    // required this.controller,
    required this.onRecieveFocus,
    this.currentQuantityTextFieldHavingFocus,
  }) : super(key: key);

  final Function({required String value}) onChanged;
  final Function({required Key? keyValue}) onRecieveFocus;
  final Key? currentQuantityTextFieldHavingFocus;
  // final TextEditingController controller;
  // final FocusNode focusNode;
  final String hint;

  final int index;
  final int quantity;

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  void initState() {
    super.initState();
    // // widget.controller.text = widget.quantity.toString();
    // widget.focusNode.addListener(() {
    //   if (widget.focusNode.hasFocus) {
    //     widget.onRecieveFocus(
    //       keyValue: widget.key,
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.currentQuantityTextFieldHavingFocus == widget.key) {
    //   FocusScope.of(context).requestFocus(widget.focusNode);
    // }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: AppTextField(
        inputDecoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            ),
        initialValue: widget.quantity == 0 ? '' : widget.quantity.toString(),
        // autoValidateMode: AutovalidateMode.always,
        formatter: <TextInputFormatter>[
          Dimens().numericTextInputFormatter,
        ],
        textFormFieldValidator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Quantity';
          }
          return null;
        },
        innerHintText: widget.hint,
        onTextChange: (value) {
          widget.onChanged(value: value);
        },
        onFieldSubmitted: (value) {
          widget.onChanged(value: value);
        },
      ),
    );
  }
}

class PriceWidget extends StatefulWidget {
  const PriceWidget({
    Key? key,
    required this.index,
    required this.price,
    required this.onChanged,
    // required this.focusNode,
    // required this.controller,
    required this.hint,
  }) : super(key: key);

  final Function({required String value}) onChanged;
  // final TextEditingController controller;
  // final FocusNode focusNode;
  final String hint;

  final int index;
  final double price;

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  @override
  void initState() {
    super.initState();
    // widget.controller.text = widget.price < 1 ? '' : widget.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: AppTextField(
        inputDecoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            ),
        formatter: <TextInputFormatter>[
          Dimens().numericTextInputFormatter,
        ],
        innerHintText: widget.hint,
        // autoValidateMode: AutovalidateMode.always,
        textFormFieldValidator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter price';
          }
          return null;
        },
        onTextChange: (value) {
          widget.onChanged(value: value);
        },
        onFieldSubmitted: (value) {
          widget.onChanged(value: value);
        },
      ),
    );
  }
}
