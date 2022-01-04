import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

class SingleCategoryItemWidget extends StatelessWidget {
  final Function({required String selectedItem}) onItemClicked;
  final String item;
  const SingleCategoryItemWidget({
    Key? key,
    required this.onItemClicked,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInkwell.withBorder(
      borderDerRadius: BorderRadius.circular(
        Dimens().suppliersListItemImageCiircularRaduis,
      ),
      onTap: () => onItemClicked(selectedItem: item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImageWidget.downloadImageWithCurvedBorders(
            borderDerRadius: BorderRadius.circular(
              Dimens().suppliersListItemImageCiircularRaduis,
            ),
            profileImageSize: 100,
            imageDownloadString: item,
          ),
          Container(
            width: double.infinity,
            child: NullableTextWidget(
              stringValue: item,
              textAlign: TextAlign.center,
              maxLines: 1,
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens().suppliersListItemImageCiircularRaduis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
