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
    this.profileImageSize,
    this.elevation = 10,
  })  : borderDerRadius = null,
        imageDownloadString = null,
        super(key: key);

  const ProfileImageWidget.downloadImage({
    Key? key,
    required this.imageDownloadString,
    this.profileImageSize,
    this.elevation = 0,
  })  : borderDerRadius = null,
        imageUrlString = null,
        super(key: key);

  const ProfileImageWidget.downloadImageWithCurvedBorders({
    Key? key,
    required this.imageDownloadString,
    this.profileImageSize,
    this.elevation = 0,
    required this.borderDerRadius,
  })  : imageUrlString = null,
        super(key: key);

  const ProfileImageWidget.withCurvedBorder({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    required this.elevation,
    required this.borderDerRadius,
  })  : imageDownloadString = null,
        super(key: key);

  const ProfileImageWidget.withNoElevation({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    this.elevation,
  })  : borderDerRadius = null,
        imageDownloadString = null,
        super(key: key);

  final BorderRadiusGeometry? borderDerRadius;
  final double? elevation;
  final String? imageDownloadString;
  final String? imageUrlString;
  final double? profileImageSize;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppImageViewModel>.reactive(
      onModelReady: (model) => model.init(
        imageUrlString: imageUrlString,
        imageDownloadString: imageDownloadString,
      ),
      viewModelBuilder: () => AppImageViewModel(),
      builder: (context, model, child) => Card(
        elevation: elevation,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderDerRadius ??
              BorderRadius.circular(
                profileImageSize ?? 40,
              ),
        ),
        child: model.isBusy
            ? const SizedBox(
                child: LoadingWidget(),
                height: 40,
                width: 40,
              )
            : model.image == null
                ? Image.asset(defaultProductImage,
                    height: profileImageSize ?? 40)
                // : Image.asset(profileIconBlue)
                : Image.memory(
                    const Base64Codec().decode((model.image!.split(',')[1])
                        .replaceAll("\\n", "")
                        .trim()),
                    height: profileImageSize != null ? profileImageSize! : 40,
                    fit: BoxFit.fill,
                    width: profileImageSize != null ? profileImageSize! : 40,
                  ),
      ),
    );
  }
}
