import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/product/product_details/product_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductAddToCartDialogBoxView extends StatefulWidget {
  final Function(DialogResponse) completer;
  final DialogRequest request;

  const ProductAddToCartDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  _ProductAddToCartDialogBoxViewState createState() =>
      _ProductAddToCartDialogBoxViewState();
}

class _ProductAddToCartDialogBoxViewState
    extends State<ProductAddToCartDialogBoxView> {
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductAddToCartDialogBoxViewArguments arguments =
        widget.request.data as ProductAddToCartDialogBoxViewArguments;

    int productCount = di<AppPreferences>()
            .getDemandersCart()
            .cartItems!
            .firstWhere(
              (element) => element.itemId == arguments.productId,
              orElse: () => CartItem(),
            )
            .itemQuantity ??
        0;

    quantityController.text = productCount.toString();

    return CenteredBaseDialog(
      arguments: CenteredBaseDialogArguments(
        contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.20,
          right: MediaQuery.of(context).size.width * 0.20,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.25,
        ),
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: Column(
          children: [
            Flexible(
              child: ProductDetailView(
                arguments: ProductDetailViewArguments(
                  productId: arguments.productId,
                  product: null,
                ),
              ),
            ),
            hSizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    hintText: 'Product Quantity',
                    controller: quantityController,
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        sendFeedBack(
                          productId: arguments.productId!,
                          productCount: productCount,
                          isConfirmed: true,
                        );
                      } else {
                        di<SnackbarService>().showCustomSnackBar(
                          message: 'Please enter a valid quantity',
                          variant: SnackbarType.ERROR,
                        );
                      }
                    },
                  ),
                  flex: 2,
                ),
                wSizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (quantityController.text.trim().isNotEmpty &&
                          int.parse(quantityController.text.trim()) > 0) {
                        sendFeedBack(
                          productId: arguments.productId!,
                          productCount: productCount,
                          isConfirmed: true,
                        );
                      } else {
                        di<SnackbarService>().showCustomSnackBar(
                          message: 'Please enter a valid quantity',
                          variant: SnackbarType.ERROR,
                        );
                      }
                    },
                    child: const Text('Add To Cart'),
                    style: AppTextButtonsStyles().textButtonStyle,
                  ),
                  flex: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void sendFeedBack({
    required int productId,
    required int productCount,
    bool isConfirmed = false,
  }) {
    widget.completer(
      DialogResponse(
        confirmed: true,
        data: ProductAddToCartDialogBoxViewOutArguments(
            productId: productId,
            quantity: int.parse(quantityController.text),
            cartItem: productCount > 0
                ? di<AppPreferences>()
                    .getDemandersCart()
                    .cartItems!
                    .firstWhere(
                      (element) => element.itemId == productId,
                      orElse: () => CartItem(),
                    )
                    .copyWith(itemQuantity: int.parse(quantityController.text))
                : null),
      ),
    );
  }
}

class ProductAddToCartDialogBoxViewArguments {
  final String title;
  final int? productId, supplierId;

  ProductAddToCartDialogBoxViewArguments({
    required this.title,
    required this.productId,
    required this.supplierId,
  });
}

class ProductAddToCartDialogBoxViewOutArguments {
  final int productId, quantity;
  final CartItem? cartItem;
  ProductAddToCartDialogBoxViewOutArguments({
    required this.productId,
    required this.quantity,
    required this.cartItem,
  });
}
