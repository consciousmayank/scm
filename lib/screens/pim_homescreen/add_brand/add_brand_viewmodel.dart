import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';
import 'package:scm/utils/strings.dart';

class AddBrandViewModel extends GeneralisedBaseViewModel {
  TextEditingController brandTitleController = TextEditingController();
  FocusNode brandTitleFocusNode = FocusNode();
  Brand brandToAdd = Brand.empty();
  List<Uint8List> selectedFiles = [];

  final BrandsApi _brandsApi = di<BrandsApi>();

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

  void addBrand() async {
    if (selectedFiles.isNotEmpty) {
      List<String> images = [];
      for (var element in selectedFiles) {
        images.add(
          'data:image/jpeg;base64, ' +
              base64Encode(element).replaceAll("\n", "").trim(),
        );
      }

      brandToAdd = brandToAdd.copyWith(image: images.first);
    }

    ApiResponse response = await _brandsApi.addBrand(brand: brandToAdd);

    if (response.statusCode == 201) {
      showInfoSnackBar(message: 'Brand added successfully');
      brandTitleController.clear();
      selectedFiles.clear();
      brandToAdd = Brand.empty();
    } else {
      showErrorSnackBar(message: 'Brand not added. please try again');
    }
    notifyListeners();
  }
}
