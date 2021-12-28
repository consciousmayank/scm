import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/image.dart' as image_widget;
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
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

  void performChecksOnData({required AddProductViewModel model}) {
    if (model.productToAdd.brand == null || model.productToAdd.brand!.isEmpty) {
      //check if brand is empty
      model.showErrorSnackBar(
          message: productBrandRequiredErrorMessage,
          onSnackBarOkButton: () {
            model.showBrandsListDialogBox();
          });
    } else if (model.productToAdd.type == null ||
        model.productToAdd.type!.isEmpty) {
      //check if type is empty
      model.showErrorSnackBar(
          message: productTypeRequiredErrorMessage,
          onSnackBarOkButton: model.typeFocusNode.requestFocus);
    } else if (model.productToAdd.subType == null ||
        model.productToAdd.subType!.isEmpty) {
      //check if sub-type is empty
      model.showErrorSnackBar(
          message: productSubTypeRequiredErrorMessage,
          onSnackBarOkButton: model.subTypeFocusNode.requestFocus);
    } else if (model.productToAdd.measurementUnit == null ||
        model.productToAdd.measurementUnit!.isEmpty) {
      //check if measurementUnit is empty
      model.showErrorSnackBar(
          message: productMeasurementUnitRequiredErrorMessage,
          onSnackBarOkButton: model.measurementFocusNode.requestFocus);
    } else if (model.productToAdd.title == null ||
        model.productToAdd.title!.isEmpty) {
      //check if title is empty
      model.showErrorSnackBar(
          message: productTitleRequiredErrorMessage,
          onSnackBarOkButton: model.measurementUnitFocusNode.requestFocus);
    } else if (model.productToAdd.tags == null ||
        model.productToAdd.tags!.isEmpty) {
      //check if tags is empty
      model.showErrorSnackBar(
          message: productTagsRequiredErrorMessage,
          onSnackBarOkButton: model.tagsFocusNode.requestFocus);
    } else if (model.productToAdd.summary == null ||
        model.productToAdd.summary!.isEmpty) {
      //check if summary is empty
      model.showErrorSnackBar(
          message: productSummaryRequiredErrorMessage,
          onSnackBarOkButton: model.summaryFocusNode.requestFocus);
    } else if (model.productToAdd.tags == null ||
        model.productToAdd.tags!.length < 15) {
      //check if tag length is less then 15 is empty
      model.showErrorSnackBar(
          message: productTagsLengthErrorMessage,
          onSnackBarOkButton: model.tagsFocusNode.requestFocus);
    } else if (model.productToAdd.measurement == null ||
        model.productToAdd.measurement! == 0) {
      //check if measurement value is 0
      model.showErrorSnackBar(
        message: productMeasurementRequiredErrorMessage,
        onSnackBarOkButton: model.brandFocusNode.requestFocus,
      );
    } else {
      model.addProduct();
    }
  }

  void performCheckOnImage({required AddProductViewModel model}) {
    if (model.selectedFiles.isEmpty) {
      model.showErrorSnackBar(
        message: productImageRequiredErrorMessage,
        onSnackBarOkButton: () {
          model.pickImages();
        },
      );
    } else {
      model.addProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProductViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    PageBarWidget(
                      title: arguments.productToEdit == null
                          ? addProductPageTitle
                          : updateProductPageTitle,
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
                            onTextChange: (value) => model.productToAdd =
                                model.productToAdd.copyWith(
                              brand: value.toUpperCase().trim(),
                            ),
                          ),
                          flex: 1,
                        ),
                        wSizedBox(width: 10),
                        Expanded(
                          child: AppTextField(
                            formatter: <TextInputFormatter>[
                              Dimens()
                                  .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                            ],
                            hintText: labelType,
                            controller: model.typeController,
                            focusNode: model.typeFocusNode,
                            onFieldSubmitted: (value) {
                              model.subTypeFocusNode.requestFocus();
                              // model.appendInTitle(); as per jayki
                            },
                            onTextChange: (value) => model.productToAdd =
                                model.productToAdd.copyWith(
                              type: value.toUpperCase().trim(),
                            ),
                          ),
                          flex: 1,
                        ),
                        wSizedBox(width: 10),
                        Expanded(
                          child: AppTextField(
                            formatter: <TextInputFormatter>[
                              Dimens()
                                  .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                            ],
                            hintText: labelSubType,
                            controller: model.subTypeController,
                            focusNode: model.subTypeFocusNode,
                            onFieldSubmitted: (value) {
                              model.priceFocusNode.requestFocus();
                              model.appendInTitle();
                            },
                            onTextChange: (value) => model.productToAdd =
                                model.productToAdd.copyWith(
                              subType: value.toUpperCase().trim(),
                            ),
                          ),
                          flex: 1,
                        ),
                        wSizedBox(width: 10),
                        Expanded(
                          child: AppTextField(
                            formatter: <TextInputFormatter>[
                              Dimens().numericWithDecimalFormatter,
                            ],
                            hintText: labelPrice,
                            controller: model.priceController,
                            focusNode: model.priceFocusNode,
                            onFieldSubmitted: (value) {
                              model.measurementFocusNode.requestFocus();
                            },
                            onTextChange: (value) => model.productToAdd =
                                model.productToAdd.copyWith(
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
                            formatter: <TextInputFormatter>[
                              Dimens().numericWithDecimalFormatter,
                            ],
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
                              model.appendInTitle();
                            },
                          ),
                          flex: 1,
                        ),
                        wSizedBox(width: 10),
                        Expanded(
                          child: AppTextField(
                            formatter: <TextInputFormatter>[
                              Dimens()
                                  .alphaNumericWithSpaceSlashHyphenUnderScoreFormatter,
                            ],
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
                              model.appendInTitle();
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
                            maxCharacters: Dimens().maxTagsLength,
                            maxCounterValue: 15,
                            enteredCount: model.productToAdd.tags == null
                                ? 0
                                : model.productToAdd.tags!.length,
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
                    // model.isDeoSuperVisor() || model.isDeoGd()
                    // ?
                    SizedBox(
                      height: 420,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wSizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: AppTextField.withCounter(
                              maxCharacters: Dimens().maxSummaryLength,
                              maxCounterValue: Dimens().maxTagsLength,
                              enteredCount: model.productToAdd.summary == null
                                  ? 0
                                  : model.productToAdd.summary!.length,
                              helperText: labelSummaryHelperText,
                              hintText: labelSummary,
                              keyboardType: TextInputType.multiline,
                              controller: model.summaryController,
                              focusNode: model.summaryFocusNode,
                              maxLines: 11,
                              onTextChange: (value) {
                                model.productToAdd =
                                    model.productToAdd.copyWith(
                                  summary: value.toUpperCase().trim(),
                                );
                                model.notifyListeners();
                              },
                            ),
                          ),
                          wSizedBox(width: 10),
                          Expanded(
                            child: model.selectedFiles.isNotEmpty
                                ? Column(
                                    children: [
                                      const Text('Image'),
                                      hSizedBox(height: 8),
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          image_widget.Image.memory(
                                            model.selectedFiles.elementAt(0),
                                          ),
                                          AppInkwell(
                                            onTap: () {
                                              model.selectedFiles.removeAt(0);
                                              model.notifyListeners();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          // if (model.isDeoGd())
                                          //   Positioned(
                                          //     right: 1,
                                          //     bottom: 1,
                                          //     child: AppInkwell(
                                          //       onTap: () {
                                          //         model.downloadImage(
                                          //             image: model
                                          //                 .selectedFiles.first);
                                          //       },
                                          //       child: Container(
                                          //         padding: const EdgeInsets.all(
                                          //           10,
                                          //         ),
                                          //         decoration: BoxDecoration(
                                          //           color: Colors.black
                                          //               .withOpacity(0.5),
                                          //           borderRadius:
                                          //               const BorderRadius.only(
                                          //             bottomLeft:
                                          //                 Radius.circular(20),
                                          //           ),
                                          //         ),
                                          //         child: const Icon(
                                          //           Icons.download,
                                          //           color: Colors.white,
                                          //           size: 25,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: TextButton.icon(
                                      style: AppTextButtonsStyles()
                                          .textButtonStyle,
                                      onPressed: () {
                                        model.pickImages();
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                      label: const Text(
                                        labelAddImage,
                                      ),
                                    ),
                                  ),
                            flex: 1,
                          ),
                          wSizedBox(width: 10),
                        ],
                      ),
                    ),
                    // : Row(
                    //     children: [
                    //       wSizedBox(width: 10),
                    //       Expanded(
                    //         flex: 1,
                    //         child: AppTextField.withCounter(
                    //           maxCharacters: Dimens().maxSummaryLength,
                    //           maxCounterValue: Dimens().minSummaryLength,
                    //           enteredCount:
                    //               model.productToAdd.summary == null
                    //                   ? 0
                    //                   : model.productToAdd.summary!.length,
                    //           helperText: labelSummaryHelperText,
                    //           hintText: labelSummary,
                    //           keyboardType: TextInputType.multiline,
                    //           controller: model.summaryController,
                    //           focusNode: model.summaryFocusNode,
                    //           maxLines: 11,
                    //           onTextChange: (value) {
                    //             model.productToAdd =
                    //                 model.productToAdd.copyWith(
                    //               summary: value.toUpperCase().trim(),
                    //             );
                    //             model.notifyListeners();
                    //           },
                    //         ),
                    //       ),
                    //       wSizedBox(width: 10),
                    //     ],
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: Dimens().buttonHeight,
                              child: TextButton(
                                clipBehavior: Clip.antiAlias,
                                onPressed: () {
                                  if (model.isDeoGd()) {
                                    performCheckOnImage(model: model);
                                  } else {
                                    performChecksOnData(model: model);
                                  }
                                },
                                child: Text(arguments.productToEdit == null
                                    ? buttonLabelAddProduct
                                    : buttonLabelUpdateProduct),
                                style: AppTextButtonsStyles().textButtonStyle,
                              ),
                            ),
                            flex: 2,
                          ),
                          if (model.isDeoSuperVisor()) wSizedBox(width: 8),
                          if (model.isDeoSuperVisor() &&
                              arguments.showDiscardProductButton)
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: Dimens().buttonHeight,
                                child: TextButton(
                                  clipBehavior: Clip.antiAlias,
                                  onPressed: () {
                                    model.discardProduct();
                                  },
                                  child: const Text(buttonLabelDiscardProduct),
                                  style: AppTextButtonsStyles().textButtonStyle,
                                ),
                              ),
                              flex: 1,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      viewModelBuilder: () => AddProductViewModel(),
    );
  }
}

class AddProductViewArguments {
  AddProductViewArguments({
    this.productToEdit,
    this.onProductUpdated,
    this.showDiscardProductButton = false,
  });

  final Function()? onProductUpdated;
  final Product? productToEdit;
  final showDiscardProductButton;
}
