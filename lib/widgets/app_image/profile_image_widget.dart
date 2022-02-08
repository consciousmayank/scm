import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_image/app_image_viewmodel.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    this.imageUrlString,
    this.profileImageHeight = 40,
    this.profileImageWidth = 40,
    this.elevation = 10,
  })  : borderDerRadius = null,
        imageDownloadString = null,
        isForCatalog = false,
        supplierId = null,
        productId = null,
        super(key: key);

  const ProfileImageWidget.downloadImage({
    Key? key,
    required this.imageDownloadString,
    this.profileImageHeight = 40,
    this.profileImageWidth = 40,
    this.elevation = 0,
  })  : borderDerRadius = null,
        productId = null,
        supplierId = null,
        isForCatalog = false,
        imageUrlString = null,
        super(key: key);

  const ProfileImageWidget.downloadImageWithCurvedBorders({
    Key? key,
    required this.imageDownloadString,
    this.profileImageHeight = 40,
    this.profileImageWidth = 40,
    this.elevation = 0,
    required this.borderDerRadius,
  })  : imageUrlString = null,
        supplierId = null,
        productId = null,
        isForCatalog = false,
        super(key: key);

  const ProfileImageWidget.productImage({
    Key? key,
    required this.profileImageHeight,
    required this.profileImageWidth,
    required this.elevation,
    required this.productId,
    required this.borderDerRadius,
    required this.isForCatalog,
    required this.supplierId,
  })  : imageDownloadString = null,
        imageUrlString = null,
        super(key: key);

  const ProfileImageWidget.withCurvedBorder({
    Key? key,
    this.imageUrlString,
    this.profileImageHeight = 40,
    this.profileImageWidth = 40,
    required this.elevation,
    required this.borderDerRadius,
  })  : imageDownloadString = null,
        productId = null,
        supplierId = null,
        isForCatalog = false,
        super(key: key);

  const ProfileImageWidget.withNoElevation({
    Key? key,
    this.imageUrlString,
    this.profileImageHeight = 40,
    this.profileImageWidth = 40,
    this.elevation,
  })  : borderDerRadius = null,
        productId = null,
        supplierId = null,
        imageDownloadString = null,
        isForCatalog = false,
        super(key: key);

  final BorderRadiusGeometry? borderDerRadius;
  final double? elevation;
  final String? imageDownloadString;
  final String? imageUrlString;
  final bool? isForCatalog;
  final int? productId;
  final double? profileImageHeight, profileImageWidth;
  final int? supplierId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppImageViewModel>.reactive(
      onModelReady: (model) => model.init(
        imageUrlString: imageUrlString,
        imageDownloadString: imageDownloadString,
        productId: productId,
        supplierId: supplierId,
        isForCatalog: isForCatalog,
      ),
      viewModelBuilder: () => AppImageViewModel(),
      builder: (context, model, child) => Card(
        elevation: elevation,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderDerRadius ??
              BorderRadius.circular(
                profileImageHeight ?? 40,
              ),
        ),
        child: model.isBusy
            ? Center(
                child: imageDownloadString == null && imageUrlString == null
                    ? const LoadingWidget()
                    : const LoadingWidget(),
              )
            : model.image == null
                ? Image.asset(
                    defaultProductImage,
                    height: profileImageHeight ?? 40,
                    width: profileImageWidth,
                  )
                // : Image.asset(profileIcoBlue)
                : Image.memory(
                    const Base64Codec().decode(
                      (model.image!.split(',')[1]).replaceAll("\\n", "").trim(),
                    ),
                    height: profileImageHeight ?? 40,
                    width: profileImageWidth,
                    fit: BoxFit.contain,
                  ),
      ),
    );
  }
}
