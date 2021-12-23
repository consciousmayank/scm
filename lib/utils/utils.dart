import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/product_list_response.dart' as product_image;

Uint8List? getImageFromBase64String({required String? base64String}) {
  return base64String == null || base64String.length == 0
      ? null
      : Base64Codec()
          .decode((base64String.split(',')[1]).replaceAll("\\n", "").trim());
}

hSizedBox({required double height}) {
  return SizedBox(
    height: height,
  );
}

wSizedBox({required double width}) {
  return SizedBox(
    width: width,
  );
}

String getBase64String({required String value}) {
  var bytes = utf8.encode(value);
  return base64.encode(bytes);
}

Map<String, String> getAuthHeader({required String? token}) {
  return {"Authorization": "Bearer $token"};
}

PreferredSizeWidget appbarWidget({
  required BuildContext context,
  String? title,
  bool automaticallyImplyLeading = false,
  List<Widget>? options,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: !automaticallyImplyLeading
        ? Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              scmLogo,
              height: 40,
              width: 40,
            ),
          )
        : null,
    centerTitle: false,
    title: title == null
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (automaticallyImplyLeading)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(
                    scmLogo,
                    height: 40,
                    width: 40,
                  ),
                ),
              if (automaticallyImplyLeading) wSizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles(context: context).appbarTitle,
              ),
            ],
          ),
    actions: options,
  );
}

Widget buildRotatedText({
  required String text,
}) {
  return RotatedBox(
    quarterTurns: -1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
      ),
    ),
  );
}

NavigationRailDestination buildRotatedTextRailDestination({
  required String text,
  double padding = 8,
  required bool isTurned,
  int turn = -1,
}) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: isTurned ? 0 : turn,
        child: Text(text),
      ),
    ),
  );
}

NavigationRailDestination buildRotatedTextRailDestinationWithIcon({
  required String text,
  double padding = 8,
  required bool isTurned,
  required Widget icon,
  int turn = -1,
}) {
  return NavigationRailDestination(
    icon: icon,
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: isTurned ? 0 : turn,
        child: Text(text),
      ),
    ),
  );
}

void pickImagesMethod({
  required Function onImageUploadError,
  required Function({required List<Uint8List> imageList}) onImageUploadSuccess,
}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'png',
    ],
  );

  if (result != null) {
    if (kIsWeb) {
      Uint8List fileBytes = result.files.first.bytes!;
      if ((fileBytes.lengthInBytes / 1024) > 50) {
        onImageUploadError.call();
      } else {
        onImageUploadSuccess(imageList: [fileBytes]).call();
      }
    } else {
      File file = File(result.files.single.path!);
      Uint8List bytes = await file.readAsBytes();
      if ((bytes.lengthInBytes / 1024) > 50) {
        onImageUploadError.call();
      } else {
        onImageUploadSuccess(imageList: [bytes]).call();
      }
    }
  }
}

bool loadProductEntryModule(String userSelectedRole) {
  return userSelectedRole.isNotEmpty &&
          userSelectedRole == AuthenticatedUserRoles.ROLE_DEO.getStatusString ||
      userSelectedRole == AuthenticatedUserRoles.ROLE_SUPVR.getStatusString ||
      userSelectedRole == AuthenticatedUserRoles.ROLE_GD.getStatusString ||
      userSelectedRole == AuthenticatedUserRoles.ROLE_MANAGER.getStatusString;
}

bool loadSupplyModule(String userSelectedRole) {
  return userSelectedRole.isNotEmpty &&
      userSelectedRole == AuthenticatedUserRoles.ROLE_SUPPLY.getStatusString;
}

bool loadDemandModule(String userSelectedRole) {
  return userSelectedRole.isNotEmpty &&
      userSelectedRole == AuthenticatedUserRoles.ROLE_DEMAND.getStatusString;
}

List<T> copyList<T>(List<T>? items) {
  var newItems = <T>[];
  if (items != null) {
    newItems.addAll(items);
  }
  return newItems;
}

Uint8List? getProductImage({List<product_image.Image>? productImage}) {
  return productImage == null ||
          productImage.isEmpty ||
          productImage.first.image == null
      ? null
      : const Base64Codec().decode(
          (productImage.first.image!.split(',')[1])
              .replaceAll("\\n", "")
              .trim(),
        );
}

String getProductMeasurement({double? measurement, String? measurementUnit}) {
  double measureMent = measurement ?? 0;
  String unit = measurementUnit ?? '';

  return '${measureMent.toStringAsFixed(2)} $unit';
}
