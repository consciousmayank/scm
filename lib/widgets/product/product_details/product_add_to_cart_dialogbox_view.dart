import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
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
  const ProductAddToCartDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _ProductAddToCartDialogBoxViewState createState() =>
      _ProductAddToCartDialogBoxViewState();
}

class _ProductAddToCartDialogBoxViewState
    extends State<ProductAddToCartDialogBoxView> {
  TextEditingController quantityController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    ProductAddToCartDialogBoxViewArguments arguments =
        widget.request.data as ProductAddToCartDialogBoxViewArguments;

    int productCount = arguments.quantity ??
        di<AppPreferences>()
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
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AppTextField(
                      autoFocus: true,
                      formatter: <TextInputFormatter>[
                        Dimens().numericTextInputFormatter,
                      ],
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
                    child: SizedBox(
                      height: Dimens().buttonHeight,
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
                        child: Text(productCount == 0
                            ? 'Add To Cart'
                            : 'Update Quantity'),
                        style: AppTextButtonsStyles(
                          context: context,
                        ).textButtonStyle,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductAddToCartDialogBoxViewArguments {
  ProductAddToCartDialogBoxViewArguments({
    required this.title,
    required this.productId,
    required this.supplierId,
  }) : quantity = null;

  ProductAddToCartDialogBoxViewArguments.fromCartPage({
    required this.title,
    required this.productId,
    required this.supplierId,
    required this.quantity,
  });

  final int? productId, supplierId, quantity;
  final String title;
}

class ProductAddToCartDialogBoxViewOutArguments {
  ProductAddToCartDialogBoxViewOutArguments({
    required this.productId,
    required this.quantity,
    required this.cartItem,
  });

  final CartItem? cartItem;
  final int productId, quantity;
}
