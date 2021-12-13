import 'package:flutter/cupertino.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
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

  void appendInTitle(String value) {
    value = value.toUpperCase();
    titleController.text = titleController.text.trim() + " " + value;
    productToAdd = productToAdd.copyWith(title: titleController.text.trim());
  }

  addProduct() async {
    setBusy(true);
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
      productToAdd = Product().empty();
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
      appendInTitle(returnedArgs.selectedBrand.title!);
      typeFocusNode.requestFocus();
      productToAdd = productToAdd.copyWith(
        brand: returnedArgs.selectedBrand.title,
      );
    }
  }
}
