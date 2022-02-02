import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/enums/payment_type.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/delivery_details_dialog_box/delivery_details_dialog_box_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeliveryDetailsDialogBoxView extends StatefulWidget {
  const DeliveryDetailsDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _DeliveryDetailsDialogBoxViewState createState() =>
      _DeliveryDetailsDialogBoxViewState();
}

class _DeliveryDetailsDialogBoxViewState
    extends State<DeliveryDetailsDialogBoxView> {
  FocusNode deliverByFocusNode = FocusNode();
  TextEditingController deliverByTextController = TextEditingController();
  FocusNode deliveryAmountFocusNode = FocusNode();
  TextEditingController deliveryAmountTextController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  FocusNode remarkFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DeliveryDetilasDialogBoxViewArguments arguments =
        widget.request.data as DeliveryDetilasDialogBoxViewArguments;
    return ViewModelBuilder<DeliveryDetailsDialogBoxViewModel>.reactive(
      viewModelBuilder: () => DeliveryDetailsDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          contentPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.25,
            right: MediaQuery.of(context).size.width * 0.25,
            top: 20,
            bottom: 20,
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Type",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        "Make sure you select one of the options below.",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledRadio(
                            label: "FULL",
                            value: 0,
                            groupValue: model.paymentTypeGroupValue as int,
                            onChanged: (value) {
                              model.paymentType =
                                  PaymentType.FULL.getPaymentValue;
                              model.paymentTypeGroupValue = value;
                              model.showCustomAmount = false;
                              deliveryAmountTextController.text =
                                  arguments.amount.toString();
                              model.notifyListeners();
                            }),
                      ),
                      Expanded(
                        child: LabeledRadio(
                            label: "PARTIAL",
                            value: 1,
                            groupValue: model.paymentTypeGroupValue as int,
                            onChanged: (value) {
                              model.paymentType =
                                  PaymentType.PARTIAL.getPaymentValue;
                              model.paymentTypeGroupValue = value;
                              model.showCustomAmount = true;
                              deliveryAmountTextController.text = "";
                              model.notifyListeners();
                            }),
                      ),
                      Expanded(
                        child: LabeledRadio(
                            label: "NONE",
                            value: 2,
                            groupValue: model.paymentTypeGroupValue as int,
                            onChanged: (value) {
                              model.paymentType =
                                  PaymentType.NONE.getPaymentValue;
                              model.paymentTypeGroupValue = value;
                              deliveryAmountTextController.text = "0.0";
                              model.showCustomAmount = false;
                              model.notifyListeners();
                            }),
                      ),
                    ],
                  ),
                  hSizedBox(height: 10),
                  model.showCustomAmount == true
                      ? AppTextField(
                          hintText: "Amount",
                          innerHintText: "Enter The Amount",
                          enabled: true,
                          keyboardType: TextInputType.number,
                          textFormFieldValidator: (value) {
                            if (value == null) {
                              return 'Required';
                            } else if (value.isEmpty) {
                              return 'Required';
                            } else if (double.parse(value) == 0 &&
                                model.paymentType == "PARTIAL") {
                              return 'Cannot be 0';
                            }
                          },
                          controller: deliveryAmountTextController,
                        )
                      : AppTextField(
                          hintText: "Amount",
                          innerHintText: "Enter The Amount",
                          enabled: false,
                          keyboardType: TextInputType.number,
                          // maxLines: 2,
                          // keyboardType: TextInputType.streetAddress,
                          // hintText: 'e.g. NAME, VEHICLE NO.',
                          // onFieldSubmitted: (_) {
                          //   // fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode);
                          // },
                          textFormFieldValidator: (value) {
                            if (value == null) {
                              return 'Required';
                            } else if (value.isEmpty) {
                              return 'Required';
                            } else if (double.parse(value) == 0 &&
                                model.paymentType == "PARTIAL") {
                              return 'Cannot be 0';
                            }
                          },
                          // formatter: [
                          //   TextFieldInputFormatter().,
                          // ],
                          controller: deliveryAmountTextController,
                          // focusNode: deliveryAmountFocusNode,
                        ),
                  hSizedBox(height: 10),
                  AppTextField(
                    keyboardType: TextInputType.name,
                    hintText: 'Delivered By',
                    innerHintText: 'e.g. VIKAS, UK07CA8178',
                    textFormFieldValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter deliver by';
                      }
                      return null;
                    },
                    controller: deliverByTextController,
                    focusNode: deliverByFocusNode,
                  ),
                  hSizedBox(height: 10),
                  AppTextField(
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    hintText: "Remarks (If Any)",
                    textFormFieldValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter deliver by';
                      }
                      return null;
                    },
                    controller: remarkController,
                    focusNode: remarkFocusNode,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: AppButton(
                      buttonBg: AppColors().buttonGreenColor,
                      onTap: () {
                        if (model.paymentType == null ||
                            model.paymentType!.isEmpty) {
                          model.showErrorSnackBar(
                            message: "Please select payment type",
                          );
                        } else if (_formKey.currentState!.validate()) {
                          String deliverBy =
                              "Payment Type : ${model.paymentType};Amount : ${deliveryAmountTextController.text};Deliver By : ${deliverByTextController.text};Remarks : ${remarkController.text}";

                          widget.completer(
                            DialogResponse(
                              confirmed: true,
                              data: DeliveryDetilasDialogBoxViewOutArguments(
                                deliveredBy: deliverBy,
                              ),
                            ),
                          );
                        }
                      },
                      title: 'DELIVER ORDER',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryDetilasDialogBoxViewArguments {
  DeliveryDetilasDialogBoxViewArguments({
    required this.title,
    required this.amount,
  });

  final double amount;
  final String title;
}

class DeliveryDetilasDialogBoxViewOutArguments {
  DeliveryDetilasDialogBoxViewOutArguments({required this.deliveredBy});

  final String deliveredBy;
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final int groupValue;
  final String label;
  final ValueChanged<int> onChanged;
  final int value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       width: 0.5,
        //       color: AppColors.shadesOfBlack[200] as Color,
        //     ),
        //   ),
        // ),
        child: Row(
          children: <Widget>[
            Radio(
              groupValue: groupValue,
              value: value,
              onChanged: (int? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
