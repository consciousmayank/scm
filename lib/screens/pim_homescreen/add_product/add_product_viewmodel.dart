import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/product_list_response.dart' as productImage;
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AddProductViewModel extends GeneralisedBaseViewModel {
  late final AddProductViewArguments arguments;
  FocusNode brandFocusNode = FocusNode();
  TextEditingController brandsController = TextEditingController();
  TextEditingController measurementController = TextEditingController();
  FocusNode measurementFocusNode = FocusNode();
  TextEditingController measurementUnitController = TextEditingController();
  FocusNode measurementUnitFocusNode = FocusNode();
  TextEditingController priceController = TextEditingController();
  FocusNode priceFocusNode = FocusNode();
  Product productToAdd = Product().empty();
  List<Uint8List> selectedFiles = [];
  int? selectedProductImageId;
  TextEditingController subTypeController = TextEditingController();
  FocusNode subTypeFocusNode = FocusNode();
  TextEditingController summaryController = TextEditingController();
  FocusNode summaryFocusNode = FocusNode();
  TextEditingController tagsController = TextEditingController();
  FocusNode tagsFocusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  TextEditingController typeController = TextEditingController();
  FocusNode typeFocusNode = FocusNode();

  final ProductApis _productApis = di<ProductApis>();

  void addFocusChangeListener() {
    typeFocusNode.addListener(() {});
  }

  void appendInTitle() {
    String brand = productToAdd.brand ?? '';
    String subType = productToAdd.subType ?? '';
    double measureMent = productToAdd.measurement ?? 0;
    String measurementUnit = productToAdd.measurementUnit ?? '';

    String title =
        '$brand $subType ${measureMent > 0 ? measureMent : ''} $measurementUnit';

    titleController.text = title.toUpperCase();
    productToAdd = productToAdd.copyWith(title: title.toUpperCase());
  }

  addProduct() async {
    setBusy(true);
    if (selectedFiles.isNotEmpty) {
      List<productImage.Image> images = [];
      for (var element in selectedFiles) {
        images.add(
          productImage.Image(
            id: selectedProductImageId,
            image: base64ImagePrefix +
                " " +
                base64Encode(element).replaceAll("\n", "").trim(),
            productId: null,
          ),
        );
      }

      productToAdd = productToAdd.copyWith(images: images);
    }
    ApiResponse apiResponse;

    if (arguments.productToEdit == null) {
      apiResponse = await _productApis.addProduct(
        product: productToAdd,
      );
    } else {
      apiResponse = await _productApis.updateProduct(
        product: productToAdd,
      );
    }

    if (apiResponse.isSuccessful()) {
      showInfoSnackBar(message: apiResponse.message);

      if (arguments.productToEdit != null &&
          arguments.onProductUpdated != null) {
        arguments.onProductUpdated!.call();
      }

      priceController.clear();
      measurementController.clear();
      measurementUnitController.clear();
      titleController.clear();
      tagsController.clear();
      summaryController.clear();
      selectedFiles.clear();
      productToAdd = productToAdd.copyWith(
        measurement: 0,
        price: 0,
        measurementUnit: '',
        title: '',
        tags: '',
        summary: '',
      );
    } else {
      showInfoSnackBar(message: apiResponse.message);
    }

    setBusy(false);
  }

  void showBrandsListDialogBox() async {
    DialogResponse? response = await dialogService.showCustomDialog(
      variant: DialogType.BRANDS_LIST_DIALOGBOX,
      data: BrandsDialogBoxViewArguments(
        title: brandDialogTitle,
      ),
      barrierDismissible: false,
    );

    if (response != null && response.confirmed) {
      BrandsDialogBoxViewOutArguments returnedArgs = response.data;
      brandsController.text = returnedArgs.selectedBrand.title!;
      typeFocusNode.requestFocus();
      productToAdd = productToAdd.copyWith(
        brand: returnedArgs.selectedBrand.title,
      );
      appendInTitle();
    }
  }

  void pickImages() async {
    pickImagesMethod(
      onImageUploadError: () {
        showErrorSnackBar(message: errorUploadedImageSize);
      },
      onImageUploadSuccess: ({required List<Uint8List> imageList}) {
        selectedFiles = imageList;
        notifyListeners();
      },
    );
  }

  init({required AddProductViewArguments arguments}) {
    this.arguments = arguments;
    if (arguments.productToEdit != null) {
      productToAdd = arguments.productToEdit!;
      brandsController.text = productToAdd.brand ?? '';
      measurementController.text = productToAdd.measurement != null
          ? productToAdd.measurement.toString()
          : '';
      priceController.text =
          productToAdd.price != null ? productToAdd.price.toString() : '';
      measurementUnitController.text = productToAdd.measurementUnit ?? '';
      subTypeController.text = productToAdd.subType ?? '';
      summaryController.text = productToAdd.summary ?? '';
      tagsController.text = productToAdd.tags ?? '';
      titleController.text = productToAdd.title ?? '';
      typeController.text = productToAdd.type ?? '';

      if (arguments.productToEdit!.images != null &&
          arguments.productToEdit!.images!.isNotEmpty) {
        selectedProductImageId = arguments.productToEdit!.images![0].id;

        selectedFiles.add(
          base64Decode(
            arguments.productToEdit!.images!.first.image!
                .replaceAll(base64ImagePrefix, '')
                .replaceAll(' ', ''),
          ),
        );
        notifyListeners();
      }
    }
  }

  void discardProduct() async {
    ApiResponse response = await _productApis.discardProduct(
      product: productToAdd,
    );

    if (response.isSuccessful()) {
      showInfoSnackBar(message: response.message);
      arguments.onProductUpdated!.call();
    } else {
      showErrorSnackBar(
        message: response.message,
      );
    }
  }
}
