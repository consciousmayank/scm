import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item_mobile.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item_web.dart';

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductListItemArguments arguments;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (productListItemMobileContext) => ProductListItemMobile(
        arguments: widget.arguments.getproductListItemMobileArguments(),
      ),
      desktop: (productListItemWebContext) => ProductListItemWeb(
        arguments: widget.arguments.getProductListItemWebArguments(),
      ),
      tablet: (productListItemWebContext) => ProductListItemWeb(
        arguments: widget.arguments.getProductListItemWebArguments(),
      ),
    );
  }
}

class ProductListItemArguments {
  ProductListItemArguments({
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

  getproductListItemMobileArguments() => ProductListItemMobileArguments(
        productTitle: productTitle,
        productCategory: productCategory,
        productPrice: productPrice,
        onAddButtonClick: onAddButtonClick,
        onProductClick: onProductClick,
        image: image,
        productId: productId,
        measurementUnit: measurementUnit,
        measurement: measurement,
        hideAddProductButton: hideAddProductButton,
        hideDeleteProductButton: hideDeleteProductButton,
        onDeleteButtonClick: onDeleteButtonClick,
      );

  getProductListItemWebArguments() => ProductListItemWebArguments(
        productTitle: productTitle,
        productCategory: productCategory,
        productPrice: productPrice,
        onAddButtonClick: onAddButtonClick,
        onProductClick: onProductClick,
        image: image,
        productId: productId,
        measurementUnit: measurementUnit,
        measurement: measurement,
        hideAddProductButton: hideAddProductButton,
        hideDeleteProductButton: hideDeleteProductButton,
        onDeleteButtonClick: onDeleteButtonClick,
      );
}
