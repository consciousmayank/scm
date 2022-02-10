import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

enum ButtonType { FULL, SMALL, NONE }

class AppTextField<T> extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppTextField({
    this.tooltTipText,
    this.obscureText,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
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
    this.textFormFieldValidator,
    this.buttonType = ButtonType.NONE,
    this.buttonLabelText,
    this.buttonIcon,
    this.onButtonPressed,
    this.errorText = '',
    this.showCounter = false,
    this.maxCounterValue = 0,
    this.maxCharacters,
    this.enteredCount = 0,
  })  : isDropDown = false,
        dropDownItems = null,
        onDropDownItemSelected = null,
        dropDownFieldValidator = null;

  AppTextField.dropDown({
    required this.tooltTipText,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.hintText,
    this.textAlignment = TextAlign.start,
    this.enabled = true,
    this.autoFocus = false,
    this.inputDecoration,
    this.formatter,
    this.labelText,
    this.dropDownFieldValidator,
    this.errorText = '',
    required this.dropDownItems,
    required this.onDropDownItemSelected,
    this.focusNode,
    this.helperText,
    this.initialValue,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTextChange,
  })  : isDropDown = true,
        showRupeesSymbol = false,
        textCapitalization = TextCapitalization.none,
        textInputAction = TextInputAction.none,
        textStyle = null,
        obscureText = null,
        innerHintText = null,
        buttonType = ButtonType.NONE,
        buttonLabelText = null,
        buttonIcon = null,
        onButtonPressed = null,
        showCounter = false,
        maxCharacters = null,
        maxCounterValue = 0,
        enteredCount = 0,
        maxLines = 1,
        autoValidateMode = AutovalidateMode.disabled,
        controller = null,
        keyboardType = TextInputType.text,
        textFormFieldValidator = null;

  const AppTextField.withCounter({
    this.tooltTipText,
    this.obscureText,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
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
    this.textFormFieldValidator,
    this.buttonType = ButtonType.NONE,
    this.buttonLabelText,
    this.buttonIcon,
    this.onButtonPressed,
    this.errorText = '',
    this.showCounter = true,
    required this.maxCharacters,
    required this.maxCounterValue,
    required this.enteredCount,
  })  : isDropDown = false,
        dropDownItems = null,
        onDropDownItemSelected = null,
        dropDownFieldValidator = null;

  final Function({required T? selectedValue})? onDropDownItemSelected;
  final bool autoFocus;
  final AutovalidateMode autoValidateMode;
  final Widget? buttonIcon;
  final String? buttonLabelText;
  final ButtonType buttonType;
  final TextEditingController? controller;
  final FormFieldValidator<T>? dropDownFieldValidator;
  final List<T>? dropDownItems;
  final int enteredCount;
  final String? errorText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? formatter;
  final String? hintText;
  final String? initialValue;
  final String? innerHintText;
  final InputDecoration? inputDecoration;
  final bool enabled, isDropDown;
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
  final FormFieldValidator<String>? textFormFieldValidator;
  final TextInputAction textInputAction;
  final TextStyle? textStyle;
  final String? helperText, tooltTipText; //required only in create consignment

  @override
  Widget build(BuildContext context) {
    if (isDropDown) {
      return Tooltip(
        message: tooltTipText,
        preferBelow: true,
        child: DropdownButtonFormField<T>(
          dropdownColor: AppColors().white,
          focusNode: focusNode,
          decoration: inputDecoration ??
              const InputDecoration()
                  .applyDefaults(Theme.of(context).inputDecorationTheme)
                  .copyWith(
                    label: labelText != null ? Text(labelText!) : null,
                    labelStyle: Theme.of(context).textTheme.subtitle2,
                    hintText: innerHintText,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.grey.shade400),
                    floatingLabelBehavior: floatingLabelBehavior,
                  ),
          hint: Text(hintText ?? ''),
          validator: dropDownFieldValidator,
          items: dropDownItems?.map<DropdownMenuItem<T>>(
            (T location) {
              return DropdownMenuItem<T>(
                child: Text(
                  location is String ? location : location.toString(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColors().black,
                      ),
                ),
                value: location,
              );
            },
          ).toList(),
          onChanged: (value) {
            onDropDownItemSelected!(selectedValue: value);
          },
        ),
      );
    } else {
      return Tooltip(
        message: helperText,
        preferBelow: true,
        child: AppInkwell.withBorder(
          borderderRadius: Dimens().getBorderRadius(),
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
                child: TextFormField(
                  maxLength: maxCharacters,
                  obscureText: obscureText ?? false,
                  style: textStyle,

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
                  decoration: inputDecoration ??
                      const InputDecoration()
                          .applyDefaults(Theme.of(context).inputDecorationTheme)
                          .copyWith(
                            suffixIcon: buttonType == ButtonType.SMALL
                                ? AppInkwell.withBorder(
                                    borderderRadius: Dimens().getBorderRadius(),
                                    child: buttonIcon!,
                                    onTap: () => onButtonPressed!(),
                                  )
                                : null,
                            label: labelText != null ? Text(labelText!) : null,
                            labelStyle: Theme.of(context).textTheme.subtitle2,
                            hintText: innerHintText,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey.shade400),
                            floatingLabelBehavior: floatingLabelBehavior,
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
                  validator: textFormFieldValidator,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
