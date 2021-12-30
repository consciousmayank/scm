import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/utils/strings.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    this.elevation = 10,
  })  : borderDerRadius = null,
        super(key: key);

  const ProfileImageWidget.withCurvedBorder({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    required this.elevation,
    required this.borderDerRadius,
  }) : super(key: key);

  const ProfileImageWidget.withNoElevation({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
    this.elevation,
  })  : borderDerRadius = null,
        super(key: key);

  final BorderRadiusGeometry? borderDerRadius;
  final double? elevation;
  final String? imageUrlString;
  final double? profileImageSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderDerRadius ??
            BorderRadius.circular(
              profileImageSize ?? 40,
            ),
      ),
      child: imageUrlString == null
          ? Image.asset(profileIconBlue, height: profileImageSize ?? 40)
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
