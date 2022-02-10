import 'package:flutter/material.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProductItemButtons extends ViewModelWidget<ProductListItem2ViewModel> {
  const ProductItemButtons({
    Key? key,
    required this.isForCatalog,
    required this.isSupplier,
    required this.isProductInCatalog,
    required this.isProductInCart,
  }) : super(key: key);

  final bool isForCatalog, isSupplier, isProductInCatalog, isProductInCart;

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return isForCatalog
        ? const RemoveProductWidget()
        : isSupplier
            //check if product is in catalog

            ? isProductInCatalog
                ? const RemoveProductWidget()
                : const AddProductWidget()
            : isProductInCart
                ? const Flexible(
                    child: UpdateProductWidget(),
                    flex: 1,
                  )
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       const Flexible(
                //         child: RemoveProductWidget(
                //           reverseStyle: true,
                //         ),
                //         flex: 1,
                //       ),
                //       wSizedBox(width: 4),
                //       const Flexible(
                //         child: UpdateProductWidget(),
                //         flex: 1,
                //       ),
                //     ],
                //   )

                : const AddProductWidget();
  }
}
