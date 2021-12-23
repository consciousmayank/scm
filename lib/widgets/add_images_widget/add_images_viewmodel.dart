import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';

class AddImagesViewModel extends GeneralisedBaseViewModel {
  List<Uint8List> selectedFiles = [];

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
}
