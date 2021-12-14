import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/product_list_response.dart' as productImage;
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AddProductViewModel extends GeneralisedBaseViewModel {
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
            id: null,
            image: 'data:image/jpeg;base64, ' +
                base64Encode(element).replaceAll("\n", "").trim(),
            productId: null,
          ),
        );
      }

      productToAdd = productToAdd.copyWith(images: images);
    }
    ApiResponse apiResponse = await _productApis.addProduct(
      product: productToAdd,
    );

    if (apiResponse.isSuccessful()) {
      showInfoSnackBar(message: apiResponse.message);
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
    if (kIsWeb) {
      Uint8List selectedFile =
          await ImagePickerWeb.getImage(outputType: ImageType.bytes)
              as Uint8List;

      if ((selectedFile.lengthInBytes / 1024) > 50) {
        showErrorSnackBar(message: errorUploadedImageSize);
        return;
      }

      selectedFiles.add(selectedFile);
    } else {
      snackBarService.showSnackbar(
          message: 'Please add image Picker functionality for mobiles also.');
    }

    notifyListeners();
  }
}
