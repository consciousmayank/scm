import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';

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
    leading: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Image.asset(
        testLogo,
        height: 40,
        width: 40,
        color: AppColors().white,
      ),
    ),
    centerTitle: false,
    title: title == null
        ? Container()
        : Text(
            title,
            style: AppTextStyles(context: context).appbarTitle,
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

NavigationRailDestination buildRotatedTextRailDestination(
    {required String text, double padding = 8, required bool isTurned}) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: isTurned ? 0 : -1,
        child: Text(text),
      ),
    ),
  );
}
