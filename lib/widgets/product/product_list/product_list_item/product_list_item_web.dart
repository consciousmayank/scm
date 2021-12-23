import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/add_product_button.dart' as add;
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';

class ProductListItemWeb extends StatelessWidget {
  final ProductListItemWebArguments arguments;
  const ProductListItemWeb({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInkwell(
      onTap: () => arguments.onProductClick(),
      child: Container(
        height: Dimens().productListItemWebHeight,
        width: Dimens().productListItemWebWidth,
        decoration: BoxDecoration(
          color: AppColors().white,
          borderRadius: BorderRadius.circular(Dimens().defaultBorder / 2),
        ),
        child: Column(
          children: [
            hSizedBox(height: 4),
            Flexible(
              flex: 5,
              child: (arguments.image == null || arguments.image!.isEmpty)
                  ? Image.asset(productDefaultImage)
                  : Image.memory(
                      arguments.image!,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                arguments.productTitle ?? '--',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            hSizedBox(height: 8),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimens().defaultBorder / 2),
                    color: AppColors().productListItemWebCategoryBg,
                    border: Border.all(
                      color: AppColors().productListItemWebCategoryContainerBg,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      arguments.productCategory ?? '--',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getProductMeasurement(
                        measurement: arguments.measurement,
                        measurementUnit: arguments.measurementUnit,
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    clipBehavior: Clip.antiAlias,
                    style: AppTextButtonsStyles()
                        .textButtonStyleForProductListItem,
                    // onPressed: arguments.onAddButtonClick,
                    onPressed: arguments.onProductClick,
                    // child: const Text('Add'),
                    child: const Text('View'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductListItemWebArguments {
  final String? productTitle;
  final String? productCategory;
  final double? productPrice;
  final GestureTapCallback? onAddButtonClick;
  final GestureTapCallback? onDeleteButtonClick;
  final void Function() onProductClick;
  final Uint8List? image;
  final bool? hideAddProductButton;
  final bool? hideDeleteProductButton;
  final double? measurement;
  final String? measurementUnit;
  final int? productId;

  ProductListItemWebArguments({
    required this.productTitle,
    required this.productCategory,
    required this.productPrice,
    required this.onAddButtonClick,
    required this.onProductClick,
    required this.image,
    this.hideAddProductButton = false,
    this.hideDeleteProductButton = false,
    this.onDeleteButtonClick,
    required this.productId,
    required this.measurementUnit,
    required this.measurement,
  });
}
