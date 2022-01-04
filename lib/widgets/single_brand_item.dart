import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';

class SingleBrandItemWidget extends StatelessWidget {
  final Function({required Brand selectedItem}) onItemClicked;
  final Brand item;
  const SingleBrandItemWidget({
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
            imageDownloadString: item.title,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(4),
            child: Text(
              item.title ?? '',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
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
