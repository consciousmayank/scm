import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/styles.dart';

enum ButtonType { FULL, SMALL, NONE }

class AppTextField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppTextField(
      {this.obscureText,
      this.innerHintText,
      this.textInputAction = TextInputAction.next,
      this.helperText = '',
      this.showRupeesSymbol = false,
      this.controller,
      this.textStyle,
      this.focusNode,
      this.hintText,
      this.initialValue,
      this.textAlignment = TextAlign.start,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onTextChange,
      this.enabled = true,
      this.autoFocus = false,
      this.maxLines = 1,
      this.inputDecoration,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.formatter,
      this.labelText,
      this.validator,
      this.buttonType = ButtonType.NONE,
      this.buttonLabelText,
      this.buttonIcon,
      this.onButtonPressed,
      this.errorText = '',
      this.showCounter = false,
      this.maxCounterValue = 0,
      this.maxCharacters,
      this.enteredCount = 0});

  const AppTextField.withCounter(
      {this.obscureText,
      this.innerHintText,
      this.textInputAction = TextInputAction.next,
      this.helperText = '',
      this.showRupeesSymbol = false,
      this.controller,
      this.textStyle,
      this.focusNode,
      this.hintText,
      this.initialValue,
      this.textAlignment = TextAlign.start,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onTextChange,
      this.enabled = true,
      this.autoFocus = false,
      this.maxLines = 1,
      this.inputDecoration,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.formatter,
      this.labelText,
      this.validator,
      this.buttonType = ButtonType.NONE,
      this.buttonLabelText,
      this.buttonIcon,
      this.onButtonPressed,
      this.errorText = '',
      this.showCounter = true,
      required this.maxCharacters,
      required this.maxCounterValue,
      required this.enteredCount});

  final bool autoFocus;
  final AutovalidateMode autoValidateMode;
  final Widget? buttonIcon;
  final String? buttonLabelText;
  final ButtonType buttonType;
  final TextEditingController? controller;
  final bool enabled;
  final int enteredCount;
  final String? errorText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? formatter;
  final String? helperText; //required only in create consignment
  final String? hintText;
  final String? initialValue;
  final String? innerHintText;
  final InputDecoration? inputDecoration;
  final TextInputType keyboardType;
  final String? labelText;
  final int? maxCharacters;
  final int maxCounterValue;
  final int maxLines;
  final bool? obscureText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onTextChange;
  final bool showCounter;
  final bool showRupeesSymbol;
  final TextAlign textAlignment;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonType == ButtonType.FULL ? onButtonPressed?.call : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (hintText != null && helperText != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              children: [
                hintText != null
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          hintText ?? '',
                          style: AppTextStyles(context: context)
                              .appTextFieldHintStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Container(),
                helperText != null
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          helperText ?? '',
                          style: AppTextStyles(context: context)
                              .appTextFieldHelperStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Container(),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 2),
            child: Stack(
              children: [
                TextFormField(
                  maxLength: maxCharacters,
                  obscureText: obscureText ?? false,
                  style: textStyle ??
                      AppTextStyles(context: context).appTextFieldTextStyle,

                  enableInteractiveSelection: true,
                  initialValue: initialValue,
                  autovalidateMode: autoValidateMode,
                  textAlign: textAlignment,
                  onEditingComplete: onEditingComplete,
                  maxLines: maxLines,
                  onChanged: onTextChange,
                  textCapitalization: textCapitalization,
                  inputFormatters: formatter,
                  enabled: enabled,
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: autoFocus,
                  decoration: const InputDecoration()
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        hintText: innerHintText,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        counterText: showCounter
                            ? enteredCount == maxCharacters
                                ? 'Max Characters Limit Reached'
                                : '$enteredCount/$maxCharacters'
                            : null,
                        counterStyle: enteredCount < maxCounterValue ||
                                enteredCount == maxCharacters
                            ? AppTextStyles(context: context)
                                .getCounterTextStyle
                                .copyWith(color: Colors.red)
                            : AppTextStyles(context: context)
                                .getCounterTextStyle
                                .copyWith(color: Colors.green),
                      ),

                  // textFieldDecoration(
                  //   showRupeesSymbol: showRupeesSymbol,
                  //   errorText: errorText,
                  //   maxLines: maxLines,
                  //   context: context,
                  // ),
                  keyboardType: keyboardType,
                  onFieldSubmitted: onFieldSubmitted,
                  validator: validator,
                ),
                buttonType == ButtonType.NONE
                    ? Container()
                    : Positioned(
                        top: 10,
                        bottom: 10,
                        right: 14,
                        child: InkWell(
                          onTap: buttonType == ButtonType.SMALL
                              ? () => onButtonPressed?.call()
                              : null,
                          child: buttonIcon,
                        ),
                      ),
                errorText != null
                    ? Positioned(
                        left: 19,
                        bottom: 0,
                        child: Text(
                          errorText ?? '',
                          style: AppTextStyles(context: context)
                              .appTextFieldErrorTextStyle,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
