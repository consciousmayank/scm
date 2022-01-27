import 'package:flutter/material.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/routes/routes.dart';
import 'package:scm/widgets/delivery_details_dialog_box/delivery_details_dialog_box.dart';
import 'package:stacked/stacked.dart';

class DeliveryDetailsDialogBoxViewModel extends GeneralisedBaseViewModel {
  DeliveryDetilasDialogBoxViewArguments? _inputArgs;
  String? _paymentType;
  int? _paymentTypeGroupValue = -1;
  bool? _showCustomAmount = false;
  TextEditingController _totalAmountController = TextEditingController();

  // List<String>? paymentType = ["FULL","PARTIAL","NONE"];
  DeliveryDetilasDialogBoxViewArguments? get inputArgs => _inputArgs;

  bool? get showCustomAmount => _showCustomAmount;

  set showCustomAmount(bool? value) {
    _showCustomAmount = value;
    notifyListeners();
  }

  set inputArgs(DeliveryDetilasDialogBoxViewArguments? value) {
    _inputArgs = value;
    notifyListeners();
  }

  int? get paymentTypeGroupValue => _paymentTypeGroupValue;

  set paymentTypeGroupValue(int? value) {
    _paymentTypeGroupValue = value;
    notifyListeners();
  }

  String? get paymentType => _paymentType;

  set paymentType(String? value) {
    _paymentType = value;
    notifyListeners();
  }

  TextEditingController get totalAmountController => _totalAmountController;

  set totalAmountController(TextEditingController value) {
    _totalAmountController = value;
    notifyListeners();
  }
}
