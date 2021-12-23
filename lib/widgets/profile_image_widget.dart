import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    this.elevation = 10,
  }) : super(key: key);

  const ProfileImageWidget.withNoElevation({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    this.elevation,
  }) : super(key: key);

  final double? elevation;
  final String? imageUrlString;
  final double? profileImageSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          profileImageSize ?? 40,
        ),
      ),
      child: imageUrlString == null
          ? Image.asset(profileIconBlue)
          // : Image.asset(profileIconBlue)
          : Image.memory(
              const Base64Codec().decode(
                  (imageUrlString!.split(',')[1]).replaceAll("\\n", "").trim()),
              height: profileImageSize != null ? profileImageSize! : 40,
              fit: BoxFit.fill,
              width: profileImageSize != null ? profileImageSize! : 40,
            ),
    );
  }
}
