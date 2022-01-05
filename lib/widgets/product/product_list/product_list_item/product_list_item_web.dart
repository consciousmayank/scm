import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/add_product_button.dart' as add;
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:flutter/src/widgets/image.dart' as image_widget;

class ProductListItemWeb extends StatelessWidget {
  const ProductListItemWeb({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductListItemWebArguments arguments;

  @override
  Widget build(BuildContext context) {
    return AppInkwell.withBorder(
      onTap: () => arguments.onProductClick(),
      borderDerRadius: BorderRadius.circular(
        Dimens().suppliersListItemImageCiircularRaduis,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: (arguments.image == null || arguments.image!.isEmpty)
                ? image_widget.Image.asset(productDefaultImage)
                : image_widget.Image.memory(
                    arguments.image!,
                    fit: BoxFit.cover,
                  ),
          ),
          Expanded(
            child: Column(
              children: [
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimens().defaultBorder / 2),
                        color: AppColors().productListItemWebCategoryBg,
                        border: Border.all(
                          color:
                              AppColors().productListItemWebCategoryContainerBg,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Text(
                          arguments.productCategory ?? '--',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
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
                        style: AppTextButtonsStyles(
                          context: context,
                        ).textButtonStyleForProductListItem,
                        onPressed: arguments.onAddButtonClick,
                        // onPressed: arguments.onProductClick,
                        child: const Text('Add'),
                        // child: const Text('View'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListItemWebArguments {
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

  final void Function() onProductClick;
  final bool? hideAddProductButton;
  final bool? hideDeleteProductButton;
  final Uint8List? image;
  final double? measurement;
  final String? measurementUnit;
  final GestureTapCallback? onAddButtonClick;
  final GestureTapCallback? onDeleteButtonClick;
  final String? productCategory;
  final int? productId;
  final double? productPrice;
  final String? productTitle;
}
