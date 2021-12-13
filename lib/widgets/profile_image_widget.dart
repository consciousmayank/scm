import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    Key? key,
    this.imageUrlString,
    this.profileImageSize,
  }) : super(key: key);

  final String? imageUrlString;
  final double? profileImageSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
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
