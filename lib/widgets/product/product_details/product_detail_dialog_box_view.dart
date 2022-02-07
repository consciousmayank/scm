import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/widgets/product/product_details/product_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailDialogBoxView extends StatefulWidget {
  const ProductDetailDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _ProductDetailDialogBoxViewState createState() =>
      _ProductDetailDialogBoxViewState();
}

class _ProductDetailDialogBoxViewState
    extends State<ProductDetailDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    ProductDetailDialogBoxViewArguments arguments =
        widget.request.data as ProductDetailDialogBoxViewArguments;
    return CenteredBaseDialog(
      arguments: CenteredBaseDialogArguments(
        noColorOnTop: true,
        contentPadding: Dimens().productDetaildialogPadding(context: context),
        request: widget.request,
        completer: widget.completer,
        title: 'Product Detail', //arguments.title,
        child: ProductDetailView(
          arguments: ProductDetailViewArguments(
            productId: arguments.productId,
            product: arguments.product,
          ),
        ),
      ),
    );
  }
}

class ProductDetailDialogBoxViewArguments {
  ProductDetailDialogBoxViewArguments({
    required this.title,
    this.productId,
    required this.product,
  });

  ProductDetailDialogBoxViewArguments.fetchProduct({
    required this.title,
    required this.productId,
    this.product,
  });

  final Product? product;
  final int? productId;
  final String title;
}
