import 'package:flutter/material.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/address.dart' as demanders_address;
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/address/address_view.dart';

class AddressViewModel extends GeneralisedBaseViewModel {
  FocusNode addressLineOneFocusNode = FocusNode();
  FocusNode addressLineTwoFocusNode = FocusNode();
  late demanders_address.Address addressToSubmit;
  FocusNode addressTypeFocusNode = FocusNode();
  late final AddressViewArguments args;
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode houseNoFocusNode = FocusNode();
  FocusNode localityFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode nearByFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();

  init({required AddressViewArguments args}) {
    this.args = args;
    if (args.selectedAddress == null) {
      addressToSubmit = demanders_address.Address().empty();
      addressToSubmit = addressToSubmit.copyWith(id: null);
    } else {
      addressToSubmit = args.selectedAddress!;
    }

    addressToSubmit = addressToSubmit.copyWith(type: addressTypes.first);
  }

  void submitAddress() {
    if (addressToSubmit.type == null || addressToSubmit.type!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressTypeRequired,
      );
      return;
    } else if (addressToSubmit.addressLine1 == null ||
        addressToSubmit.addressLine1!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressLine1Required,
      );
      return;
    } else if (addressToSubmit.locality == null ||
        addressToSubmit.locality!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressLocalityRequired,
      );
      return;
    } else if (addressToSubmit.city == null || addressToSubmit.city!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressCityRequired,
      );
      return;
    } else if (addressToSubmit.state == null ||
        addressToSubmit.state!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressStateRequired,
      );
      return;
    } else if (addressToSubmit.country == null ||
        addressToSubmit.country!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressCountryRequired,
      );
      return;
    } else if (addressToSubmit.pincode == null ||
        addressToSubmit.pincode!.isEmpty) {
      showErrorSnackBar(
        message: labelErrorAddressPincodeRequired,
      );
      return;
    } else if (addressToSubmit.pincode != null &&
        addressToSubmit.pincode!.length < 6) {
      showErrorSnackBar(
        message: labelErrorAddressPincodeInvalid,
      );
      return;
    } else {
      args.onSubmit(address: addressToSubmit);
    }
  }
}
