import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/app.locator.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';

class AddBrandViewModel extends GeneralisedBaseViewModel {
  List<Brand> addedProductList = [];
  TextEditingController brandTitleController = TextEditingController();
  FocusNode brandTitleFocusNode = FocusNode();
  Brand brandToAdd = Brand.empty();
  List<Uint8List> selectedFiles = [];

  final BrandsApi _brandsApi = locator<BrandsApi>();

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

  void addBrand() async {
    if (selectedFiles.isNotEmpty) {
      List<String> images = [];
      for (var element in selectedFiles) {
        images.add(
          base64ImagePrefix +
              ' ' +
              base64Encode(element).replaceAll("\n", "").trim(),
        );
      }

      brandToAdd = brandToAdd.copyWith(image: images.first);
    }

    Brand response = await _brandsApi.addBrand(
      brand: brandToAdd.copyWith(
        title: brandToAdd.title!.toUpperCase(),
      ),
    );

    if (response.id != null && response.id! > 0) {
      addedProductList.add(response);
      showInfoSnackBar(message: 'Brand added successfully');
      brandTitleController.clear();
      selectedFiles.clear();
      brandToAdd = Brand.empty();
    } else {
      showErrorSnackBar(message: 'Brand not added. please try again');
    }
    notifyListeners();
  }

  void updateBrand({required Brand selectedBrand}) {
    brandToAdd = selectedBrand;
    brandTitleController.text = selectedBrand.title ?? '';
    if (selectedBrand.image != null && selectedBrand.image!.isNotEmpty) {
      selectedFiles.clear();
      selectedFiles.add(
        base64Decode(
          selectedBrand.image!
              .replaceAll(base64ImagePrefix, '')
              .replaceAll(' ', ''),
        ),
      );
    } else {
      selectedFiles.clear();
    }
    notifyListeners();
  }
}
