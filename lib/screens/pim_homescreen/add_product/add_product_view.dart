import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AddProductViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProductViewModel>.reactive(
      // onModelReady: (model) => model.showBrandsListDialogBox(),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                children: [
                  const PageBarWidget(
                    title: addProductPageTitle,
                    subTitle: addProductPageSubTitle,
                  ),
                  Row(
                    children: [
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          enabled: false,
                          buttonType: ButtonType.FULL,
                          onButtonPressed: () {
                            model.showBrandsListDialogBox();
                          },
                          keyboardType: TextInputType.text,
                          buttonIcon: const Icon(Icons.arrow_drop_down),
                          hintText: labelBrands,
                          controller: model.brandsController,
                          focusNode: model.brandFocusNode,
                          onTextChange: (value) =>
                              model.productToAdd = model.productToAdd.copyWith(
                            brand: value.toUpperCase().trim(),
                          ),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelType,
                          controller: model.typeController,
                          focusNode: model.typeFocusNode,
                          onFieldSubmitted: (value) {
                            model.subTypeFocusNode.requestFocus();
                            model.appendInTitle(value);
                          },
                          onTextChange: (value) =>
                              model.productToAdd = model.productToAdd.copyWith(
                            type: value.toUpperCase().trim(),
                          ),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelSubType,
                          controller: model.subTypeController,
                          focusNode: model.subTypeFocusNode,
                          onFieldSubmitted: (value) {
                            model.priceFocusNode.requestFocus();
                            model.appendInTitle(value);
                          },
                          onTextChange: (value) =>
                              model.productToAdd = model.productToAdd.copyWith(
                            subType: value.toUpperCase().trim(),
                          ),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelPrice,
                          controller: model.priceController,
                          focusNode: model.priceFocusNode,
                          onFieldSubmitted: (value) {
                            model.measurementFocusNode.requestFocus();
                          },
                          onTextChange: (value) =>
                              model.productToAdd = model.productToAdd.copyWith(
                            price: double.parse(
                              value,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelMeasurement,
                          controller: model.measurementController,
                          focusNode: model.measurementFocusNode,
                          onTextChange: (value) {
                            model.productToAdd = model.productToAdd.copyWith(
                              measurement: double.parse(
                                value,
                              ),
                            );
                          },
                          onFieldSubmitted: (value) {
                            model.measurementUnitFocusNode.requestFocus();
                            model.appendInTitle(value);
                          },
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelMeasurementUnit,
                          controller: model.measurementUnitController,
                          focusNode: model.measurementUnitFocusNode,
                          onTextChange: (value) {
                            model.productToAdd = model.productToAdd.copyWith(
                              measurementUnit: value.toUpperCase().trim(),
                            );
                          },
                          onFieldSubmitted: (value) {
                            model.titleFocusNode.requestFocus();
                            model.appendInTitle(value);
                          },
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField(
                          hintText: labelTitle,
                          controller: model.titleController,
                          focusNode: model.titleFocusNode,
                          onTextChange: (value) {
                            model.productToAdd = model.productToAdd.copyWith(
                              title: value.toUpperCase().trim(),
                            );
                          },
                          onFieldSubmitted: (value) =>
                              model.tagsFocusNode.requestFocus(),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField.withCounter(
                          maxCounterValue: 15,
                          enteredCount: model.productToAdd.tags!.length,
                          hintText: labelTags,
                          controller: model.tagsController,
                          focusNode: model.tagsFocusNode,
                          onTextChange: (value) {
                            model.productToAdd = model.productToAdd.copyWith(
                              tags: value.toUpperCase().trim(),
                            );
                            model.notifyListeners();
                          },
                          onFieldSubmitted: (value) =>
                              model.summaryFocusNode.requestFocus(),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      wSizedBox(width: 10),
                      Expanded(
                        child: AppTextField.withCounter(
                          maxCounterValue: 120,
                          enteredCount: model.productToAdd.summary!.length,
                          helperText: labelSummaryHelperText,
                          hintText: labelSummary,
                          controller: model.summaryController,
                          focusNode: model.summaryFocusNode,
                          maxLines: 10,
                          onTextChange: (value) {
                            model.productToAdd = model.productToAdd.copyWith(
                              summary: value.toUpperCase().trim(),
                            );
                            model.notifyListeners();
                          },
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 10),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: Dimens().buttonHeight,
                      child: TextButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {
                          if (model.productToAdd.brand!.isEmpty) {
                            //check if brand is empty
                            model.showErrorSnackBar(
                                message: productBrandRequiredErrorMessage,
                                onSnackBarOkButton: () {
                                  model.showBrandsListDialogBox();
                                });
                          } else if (model.productToAdd.type!.isEmpty) {
                            //check if type is empty
                            model.showErrorSnackBar(
                                message: productTypeRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.typeFocusNode.requestFocus);
                          } else if (model.productToAdd.subType!.isEmpty) {
                            //check if sub-type is empty
                            model.showErrorSnackBar(
                                message: productSubTypeRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.subTypeFocusNode.requestFocus);
                          } else if (model
                              .productToAdd.measurementUnit!.isEmpty) {
                            //check if measurementUnit is empty
                            model.showErrorSnackBar(
                                message:
                                    productMeasurementUnitRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.measurementFocusNode.requestFocus);
                          } else if (model.productToAdd.title!.isEmpty) {
                            //check if title is empty
                            model.showErrorSnackBar(
                                message: productTitleRequiredErrorMessage,
                                onSnackBarOkButton: model
                                    .measurementUnitFocusNode.requestFocus);
                          } else if (model.productToAdd.tags!.isEmpty) {
                            //check if tags is empty
                            model.showErrorSnackBar(
                                message: productTagsRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.tagsFocusNode.requestFocus);
                          } else if (model.productToAdd.summary!.isEmpty) {
                            //check if summary is empty
                            model.showErrorSnackBar(
                                message: productSummaryRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.summaryFocusNode.requestFocus);
                          } else if (model.productToAdd.tags!.length < 15) {
                            //check if tag length is less then 15 is empty
                            model.showErrorSnackBar(
                                message: productTagsLengthErrorMessage,
                                onSnackBarOkButton:
                                    model.tagsFocusNode.requestFocus);
                          } else if (model.productToAdd.measurement! == 0) {
                            //check if measurement value is 0
                            model.showErrorSnackBar(
                                message: productMeasurementRequiredErrorMessage,
                                onSnackBarOkButton:
                                    model.brandFocusNode.requestFocus);
                          } else {
                            model.addProduct();
                          }
                        },
                        child: const Text('Add Product'),
                        style: AppTextButtonsStyles().textButtonStyle,
                      ),
                    ),
                  )
                ],
              ),
      ),
      viewModelBuilder: () => AddProductViewModel(),
    );
  }
}

class AddProductViewArguments {}
