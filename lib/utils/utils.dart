import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/model_classes/product_list_response.dart' as product_image;
import 'package:scm/utils/strings.dart';

Uint8List? getImageFromBase64String({required String? base64String}) {
  return base64String == null || base64String.isEmpty
      ? null
      : const Base64Codec()
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
        child: Text(
          text,
        ),
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

String getApiToAppOrderStatus({
  String? status,
}) {
  if (status == null) {
    return OrderStatusTypes.NONE.apiToAppTitles;
  } else if (status == OrderStatusTypes.CREATED.apiToAppTitles) {
    return OrderStatusTypes.NEW_ORDER.apiToAppTitles;
  } else if (status == OrderStatusTypes.PROCESSING.apiToAppTitles) {
    return OrderStatusTypes.UNDER_PROCESS.apiToAppTitles;
  } else if (status == OrderStatusTypes.INTRANSIT.apiToAppTitles) {
    return OrderStatusTypes.SHIPPED.apiToAppTitles;
  } else {
    return status.toUpperCase();
  }
}

String getAppToApiOrderStatus({
  String? status,
}) {
  if (status == null) {
    return '';
  } else if (status == OrderStatusTypes.NEW_ORDER.apiToAppTitles) {
    return OrderStatusTypes.CREATED.apiToAppTitles;
  } else if (status == OrderStatusTypes.UNDER_PROCESS.apiToAppTitles) {
    return OrderStatusTypes.PROCESSING.apiToAppTitles;
  } else if (status == OrderStatusTypes.SHIPPED.apiToAppTitles) {
    return OrderStatusTypes.INTRANSIT.apiToAppTitles;
  } else {
    return status.toUpperCase();
  }
}

Color getBorderColor({required String? status}) {
  if (status == null) {
    return Colors.transparent;
  } else if (status == OrderStatusTypes.PROCESSING.apiToAppTitles ||
      status == OrderStatusTypes.UNDER_PROCESS.apiToAppTitles) {
    return OrderStatusTypes.PROCESSING.displayColor;
  } else if (status == OrderStatusTypes.CREATED.apiToAppTitles ||
      status == OrderStatusTypes.NEW_ORDER.apiToAppTitles) {
    return OrderStatusTypes.CREATED.displayColor;
  } else if (status == OrderStatusTypes.CANCELLED.apiToAppTitles) {
    return OrderStatusTypes.CANCELLED.displayColor;
  } else if (status == OrderStatusTypes.DELIVERED.apiToAppTitles) {
    return OrderStatusTypes.DELIVERED.displayColor;
  } else if (status == OrderStatusTypes.INTRANSIT.apiToAppTitles ||
      status == OrderStatusTypes.SHIPPED.apiToAppTitles) {
    return OrderStatusTypes.INTRANSIT.displayColor;
  } else {
    return Colors.transparent;
  }
}

String? checkImageUrl({String? imageUrl}) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return null;
  } else {
    if (!imageUrl.contains(base64ImagePrefix)) {
      imageUrl = base64ImagePrefix + imageUrl;
    }
  }
  return imageUrl;
}

void fieldFocusChange({
  required BuildContext context,
  required FocusNode currentFocus,
  required FocusNode nextFocus,
}) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

double getAmountGrandTotalOfOrderReport(
    {required OrdersReportResponse? reportResponse}) {
  if (reportResponse == null || reportResponse.reportResultSet == null) {
    return 0;
  } else if (reportResponse.reportResultSet!.isEmpty) {
    return 0;
  } else {
    return reportResponse.reportResultSet!.fold(
      0,
      (previousValue, element) => previousValue + element.itemAmount!,
    );
  }
}

int getQuantityGrandTotalOfOrderReport(
    {required OrdersReportResponse? reportResponse}) {
  if (reportResponse == null || reportResponse.reportResultSet == null) {
    return 0;
  } else if (reportResponse.reportResultSet!.isEmpty) {
    return 0;
  } else {
    return reportResponse.reportResultSet!.fold(
      0,
      (previousValue, element) => previousValue + element.itemQuantity!,
    );
  }
}

Future<DateTimeRange?> selectDateRange({
  required BuildContext context,
  required DateTimeRange initialDateTimeRange,
}) async {
  DateTimeRange? picked = await showDateRangePicker(
    helpText: "Please Select Start and End Date",
    confirmText: 'Confirm Text',
    saveText: 'Select Date',
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    firstDate: DateTime.now().subtract(
      const Duration(
        days: 365,
      ),
    ),
    lastDate: DateTime.now(),
    initialDateRange: initialDateTimeRange,
    builder: (context, child) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height *
                  getValueForScreenType(
                    context: context,
                    mobile: 0.95,
                    tablet: 0.85,
                    desktop: 0.65,
                  ),
              width: MediaQuery.of(context).size.width *
                  getValueForScreenType(
                    context: context,
                    mobile: 0.95,
                    tablet: 0.65,
                    desktop: 0.35,
                  ),
              child: child,
            ),
          ),
        ],
      );
    },
  );

  return picked;
}

DateTime getFirstDateForOrder({DateTime? dateTime}) {
  int numberOfAllowedDays = 180;

  return dateTime == null
      ? DateTime.now().subtract(
          Duration(
            days: numberOfAllowedDays,
          ),
        )
      : dateTime.subtract(
          Duration(
            days: numberOfAllowedDays,
          ),
        );
}

String getAddressString({required Address? address}) {
  if (address == null) {
    return '';
  }
  return '${address.addressLine1}, ${address.addressLine2}, \n${address.locality} ${address.nearby}, \n${address.city}, ${address.state}, ${address.country}, ${address.pincode}';
}
