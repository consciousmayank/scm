import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

class SingleCategoryItemWidget extends StatelessWidget {
  const SingleCategoryItemWidget({
    Key? key,
    required this.onItemClicked,
    required this.item,
  }) : super(key: key);

  final Function({required Type selectedItem}) onItemClicked;
  final Type item;

  @override
  Widget build(BuildContext context) {
    return AppInkwell.withBorder(
      borderderRadius: BorderRadius.circular(
        Dimens().suppliersListItemImageCircularRaduis,
      ),
      onTap: () => onItemClicked(selectedItem: item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImageWidget.downloadImageWithCurvedBorders(
            borderDerRadius: BorderRadius.circular(
              Dimens().suppliersListItemImageCircularRaduis,
            ),
            profileImageHeight: 100,
            profileImageWidth: 100,
            imageDownloadString: item.type,
          ),
          Container(
            width: double.infinity,
            child: NullableTextWidget(
              stringValue: item.type,
              textAlign: TextAlign.center,
              maxLines: 1,
              textStyle: Theme.of(context).textTheme.bodyText1,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens().suppliersListItemImageCircularRaduis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
