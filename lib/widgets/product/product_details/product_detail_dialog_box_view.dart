import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/widgets/product/product_details/product_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailDialogBoxView extends StatefulWidget {
  final Function(DialogResponse) completer;
  final DialogRequest request;

  const ProductDetailDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

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
        contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.20,
          right: MediaQuery.of(context).size.width * 0.20,
          top: MediaQuery.of(context).size.height * 0.20,
          bottom: MediaQuery.of(context).size.height * 0.30,
        ),
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
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
  final String title;
  final int? productId;
  final Product? product;

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
}
