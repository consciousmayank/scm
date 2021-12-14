import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/generalised_base_view_model.dart';

class AddImagesViewModel extends GeneralisedBaseViewModel {
  List<Uint8List> selectedFiles = [];

  void pickImages() async {
    if (kIsWeb) {
      selectedFiles =
          await ImagePickerWeb.getMultiImages(outputType: ImageType.bytes)
              as List<Uint8List>;
    } else {
      snackBarService.showSnackbar(
          message: 'Please add image Picker functionality for mobiles also.');
    }

    notifyListeners();
  }
}
