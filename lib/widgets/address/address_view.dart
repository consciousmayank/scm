import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/address_actions.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/address/address_viewmodel.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:scm/model_classes/address.dart' as demanders_address;

class AddressView extends StatefulWidget {
  const AddressView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AddressViewArguments arguments;

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressViewModel>.reactive(
      onModelReady: (model) => model.init(
        args: widget.arguments,
      ),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Address Type
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 2,
                        bottom: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors().primaryColor[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors().primaryColor[900]!,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select'),
                        value: model.addressToSubmit.type!.isNotEmpty
                            ? model.addressToSubmit.type
                            : addressTypes.first,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors().primaryColor.shade900,
                        ),
                        iconSize: 30,
                        underline: Container(),
                        onChanged: (String? value) {
                          model.addressToSubmit =
                              model.addressToSubmit.copyWith(
                            type: value,
                          );
                        },
                        items: addressTypes.map<DropdownMenuItem<String>>(
                          (String location) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: AppColors().black,
                                    ),
                              ),
                              value: location,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    hSizedBox(height: 10),
                    //Address Line 1
                    AppTextField(
                      initialValue: model.addressToSubmit.addressLine1,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          addressLine1: value,
                        );
                      },
                      keyboardType: TextInputType.streetAddress,
                      hintText:
                          'Line 1 - Flat, House no., Building, Company, Apartment',
                      formatter: <TextInputFormatter>[
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.addressLineOneFocusNode,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.addressLineOneFocusNode,
                          nextFocus: model.addressLineTwoFocusNode,
                        );
                      },
                    ),
                    hSizedBox(height: 10),
                    //Address Line 2
                    AppTextField(
                      initialValue: model.addressToSubmit.addressLine2,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          addressLine2: value,
                        );
                      },
                      keyboardType: TextInputType.streetAddress,
                      hintText:
                          'Line 2 - Area, Colony, Street, Sector, Village',
                      // validator: FormValidators().addressValidator,
                      formatter: [
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.addressLineTwoFocusNode,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.addressLineTwoFocusNode,
                          nextFocus: model.localityFocusNode,
                        );
                      },
                    ),
                    hSizedBox(height: 10),
                    //Locality
                    AppTextField(
                      initialValue: model.addressToSubmit.locality,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          locality: value,
                        );
                      },
                      keyboardType: TextInputType.streetAddress,
                      hintText: 'Locality',
                      formatter: [
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.localityFocusNode,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.localityFocusNode,
                          nextFocus: model.nearByFocusNode,
                        );
                      },
                    ),
                    hSizedBox(height: 10),
                    //Near By
                    AppTextField(
                      initialValue: model.addressToSubmit.nearby,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          nearby: value,
                        );
                      },
                      keyboardType: TextInputType.streetAddress,
                      hintText: 'Near By - Landmark e.g. near Clock Tower',
                      formatter: [
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.nearByFocusNode,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.nearByFocusNode,
                          nextFocus: model.cityFocusNode,
                        );
                      },
                    ),
                    hSizedBox(height: 10),
                    //City
                    AppTextField(
                      initialValue: model.addressToSubmit.city,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          city: value,
                        );
                      },
                      keyboardType: TextInputType.name,
                      hintText: 'City',
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.cityFocusNode,
                          nextFocus: model.stateFocusNode,
                        );
                      },
                      formatter: [
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.cityFocusNode,
                    ),
                    hSizedBox(height: 10),
                    //State
                    AppTextField(
                      initialValue: model.addressToSubmit.state,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          state: value,
                        );
                      },
                      keyboardType: TextInputType.name,
                      hintText: 'State',
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.stateFocusNode,
                          nextFocus: model.countryFocusNode,
                        );
                      },
                      formatter: [
                        Dimens()
                            .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                      ],
                      focusNode: model.stateFocusNode,
                    ),
                    hSizedBox(height: 10),
                    //Country
                    AppTextField(
                      initialValue: model.addressToSubmit.country,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          country: value,
                        );
                      },
                      keyboardType: TextInputType.name,
                      hintText: 'Country',
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                          context: context,
                          currentFocus: model.countryFocusNode,
                          nextFocus: model.pinCodeFocusNode,
                        );
                      },
                      formatter: [
                        Dimens().alphabeticFormatter,
                      ],
                      focusNode: model.countryFocusNode,
                    ),
                    hSizedBox(height: 10),
                    //Pin Code
                    AppTextField(
                      maxCharacters: 6,
                      initialValue: model.addressToSubmit.pincode,
                      onTextChange: (value) {
                        model.addressToSubmit = model.addressToSubmit.copyWith(
                          pincode: value,
                        );
                      },
                      keyboardType: TextInputType.number,
                      hintText: 'PinCode',
                      formatter: [
                        Dimens().numericTextInputFormatter,
                      ],
                      focusNode: model.pinCodeFocusNode,
                      onFieldSubmitted: (_) {
                        model.pinCodeFocusNode.unfocus();
                      },
                    ),
                    hSizedBox(height: 10),
                    //Submite Button
                    SizedBox(
                      height: AppBar().preferredSize.height,
                      child: TextButton(
                        style: AppTextButtonsStyles(
                          context: context,
                        ).textButtonStyle,
                        onPressed: () {
                          model.submitAddress();
                        },
                        child: const Text(
                          labelSubmit,
                        ),
                      ),
                    ),
                  ],
                ),

                // AppButton(onTap: (){}, buttonText: 'Add Address')
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AddressViewModel(),
    );
  }
}

class AddressViewArguments {
  AddressViewArguments({
    this.selectedAddress,
    required this.onSubmit,
  });

  final Function({required demanders_address.Address address}) onSubmit;
  final demanders_address.Address? selectedAddress;
}
