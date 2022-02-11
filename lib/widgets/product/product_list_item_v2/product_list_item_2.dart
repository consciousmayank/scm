import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_item_buttons.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProductListItem2View extends StatefulWidget {
  const ProductListItem2View({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductListItem2ViewArguments arguments;

  @override
  _ProductListItem2ViewState createState() => _ProductListItem2ViewState();
}

//getProductImage
class _ProductListItem2ViewState extends State<ProductListItem2View> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListItem2ViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.busy(operationOnCatalogBusyKey)
            ? const Center(child: LoadingWidget())
            : AppInkwell.withBorder(
                onTap: () => widget.arguments.onProductClick(),
                borderderRadius: BorderRadius.circular(
                  Dimens().suppliersListItemImageCircularRaduis,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Tooltip(
                        message:
                            '${widget.arguments.product?.title}, (${widget.arguments.product?.type})',
                        preferBelow: true,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ProfileImageWidget.productImage(
                            key: UniqueKey(),
                            isForCatalog: widget.arguments.isForCatalog,
                            supplierId: widget.arguments.supplierId,
                            elevation: 0,
                            profileImageHeight:
                                Dimens().productDtailImageHeight,
                            profileImageWidth: Dimens().productDtailImageHeight,
                            borderDerRadius: BorderRadius.all(
                              Radius.circular(
                                Dimens().suppliersListItemImageCircularRaduis,
                              ),
                            ),
                            productId: widget.arguments.product?.id,
                            onImageLoaded: () {},
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: NullableTextWidget(
                              stringValue:
                                  '${widget.arguments.product?.title}, (${widget.arguments.product?.type})',
                              maxLines: 3,
                              textStyle: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          hSizedBox(height: 8),
                          // const Spacer(),
                          if (widget.arguments.product?.measurement != null &&
                              widget.arguments.product!.measurement! > 0)
                            Expanded(
                              child: NullableTextWidget(
                                stringValue: getProductMeasurement(
                                  measurement:
                                      widget.arguments.product?.measurement,
                                  measurementUnit:
                                      widget.arguments.product?.measurementUnit,
                                ),
                                textAlign: TextAlign.left,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle2,
                              ),
                            ),

                          Row(
                            children: [
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Expanded(
                                child: ProductItemButtons(
                                  isForCatalog: widget.arguments.isForCatalog,
                                  isSupplier: model.isSupplier(),
                                  isProductInCatalog: model.isProductInCatalog(
                                    productId: widget.arguments.product?.id,
                                  ),
                                  isProductInCart: model.isProductInCart(
                                    productId: widget.arguments.product?.id,
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      viewModelBuilder: () => ProductListItem2ViewModel(),
    );
  }
}

class ProductListItem2ViewArguments {
  ProductListItem2ViewArguments({
    required this.product,
    required this.onProductOperationCompleted,
    required this.onProductClick,
    required this.supplierId,
  }) : isForCatalog = false;

  ProductListItem2ViewArguments.catalog({
    required this.product,
    required this.onProductOperationCompleted,
    required this.onProductClick,
  })  : isForCatalog = true,
        supplierId = null;

  final bool isForCatalog;
  final Function onProductClick;
  final Function onProductOperationCompleted;
  final Product? product;
  final int? supplierId;
}

class AddProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const AddProductWidget({
    Key? key,
  }) : super(
          key: key,
          reactive: false,
        );

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
      titleTextStyle: Theme.of(context).textTheme.button,
      toolTipMessage:
          'Add Product to ${viewModel.isSupplier() ? 'Catalog' : 'Cart'}',
      buttonBg: AppColors().buttonGreenColor,
      onTap: viewModel.onAddButtonClick,
      title: 'Add',
    );
  }
}

class UpdateProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const UpdateProductWidget({
    Key? key,
  }) : super(
          key: key,
          reactive: false,
        );

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
      title: 'Edit',
      titleTextStyle: Theme.of(context).textTheme.button,
      toolTipMessage:
          'Update Product Quantity in ${viewModel.isSupplier() ? 'Catalog' : 'Cart'}',
      buttonBg: Theme.of(context).primaryColorLight,
      onTap: viewModel.onUpdateButtonClick,
    );
  }
}

class RemoveProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const RemoveProductWidget({
    Key? key,
    this.reverseStyle = false,
  }) : super(
          key: key,
          reactive: false,
        );

  final bool reverseStyle;

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
      toolTipMessage:
          'Remove Product from ${viewModel.isSupplier() ? 'Catalog' : 'Cart'}',
      buttonBg: AppColors().buttonRedColor,
      onTap: viewModel.onRemoveButtonClick,
      title: 'Remove',
      titleTextStyle: Theme.of(context).textTheme.button,
    );
  }
}
