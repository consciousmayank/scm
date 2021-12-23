import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/add_product_button.dart' as add;

class ProductListItemMobile extends StatelessWidget {
  final ProductListItemMobileArguments arguments;

  const ProductListItemMobile({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  Widget buildProductPriceAndButton({
    required bool? hideProductAddButton,
    required bool? hideProductDeleteButton,
    required BuildContext context,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (arguments.measurementUnit != null &&
                arguments.measurementUnit != null &&
                arguments.measurement != 0.0)
              Text(
                '${arguments.measurement.toString()} ${arguments.measurementUnit}',
                style: AppTextStyles(context: context)
                    .appTextFieldTextStyle!
                    .copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
              ),
            // Text(
            //   '\u{20B9} ${productPrice.toString()}',
            //   style: AppTextStyles.robotoMedium14Black.copyWith(
            //     fontWeight: FontWeight.w600,
            //     fontSize: 16,
            //   ),
            // ),
          ],
        ),
        if (hideProductAddButton == false)
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: buildAddProductButton(),
          ),
        if (hideProductDeleteButton == false)
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: buildDeleteProductButton(),
          ),
      ],
    );
  }

  Widget buildAddProductButton() => add.AddProductButton(
        onTap: arguments.onAddButtonClick,
        buttonText: 'ADD',
        // appButtonTypes: AppButtonTypes.LARGE,
      );

  Widget buildDeleteProductButton() => add.AddProductButton(
        onTap: arguments.onDeleteButtonClick,
        buttonText: 'REMOVE',
        // appButtonTypes: AppButtonTypes.LARGE,
      );

  Widget buildProductCategory({
    required BuildContext context,
  }) =>
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'CATEGORY: ',
                style: AppTextStyles(context: context)
                    .appTextFieldTextStyle!
                    .copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    )),
            TextSpan(
              text: arguments.productCategory!,
              style: AppTextStyles(context: context)
                  .appTextFieldTextStyle!
                  .copyWith(
                    fontWeight: FontWeight.w600,
                    // color: AppColors.categoryColor
                  ),
            ),
          ],
        ),
      );

  Widget buildProductTitle({
    required BuildContext context,
  }) {
    return Text(
      arguments.productTitle!,
      style: AppTextStyles(context: context).appTextFieldTextStyle!.copyWith(
            fontWeight: FontWeight.w600,
          ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: InkWell(
          onTap: arguments.onProductClick,
          // splashColor: AppColors.primaryColor[100],
          splashColor: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  // height: 100,
                  // color: Colors.amber,
                  child: (arguments.image == null || arguments.image!.isEmpty)
                      ? Image.asset(productDefaultImage)
                      : Image.memory(
                          arguments.image!,
                          fit: BoxFit.cover,
                          // height: size == 0 ? double.infinity : size,
                          // width: size == 0 ? double.infinity : size,
                        ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  // color: Colors.lightGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildProductTitle(context: context),
                      hSizedBox(height: 8),
                      buildProductCategory(context: context),
                      // hSizedBox(2),
                      Text(
                        'ID: ${arguments.productId}',
                        style: AppTextStyles(context: context)
                            .appbarTitle!
                            .copyWith(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                      ),
                      buildProductPriceAndButton(
                        context: context,
                        hideProductAddButton: arguments.hideAddProductButton,
                        hideProductDeleteButton:
                            arguments.hideDeleteProductButton,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListItemMobileArguments {
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

  ProductListItemMobileArguments({
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
