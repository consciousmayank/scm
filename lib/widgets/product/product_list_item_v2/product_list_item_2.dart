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
        body: model.isBusy
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
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ProfileImageWidget.productImage(
                          key: UniqueKey(),
                          isForCatalog: widget.arguments.isForCatalog,
                          supplierId: widget.arguments.supplierId,
                          elevation: 0,
                          profileImageHeight: Dimens().productDtailImageHeight,
                          profileImageWidth: Dimens().productDtailImageHeight,
                          borderDerRadius: BorderRadius.all(
                            Radius.circular(
                              Dimens().suppliersListItemImageCircularRaduis,
                            ),
                          ),
                          productId: widget.arguments.product?.id,
                          onImageLoaded: () {},
                        ),

                        // (getProductImage(
                        //                 productImage:
                        //                     widget.arguments.product?.images) ==
                        //             null ||
                        //         getProductImage(
                        //                 productImage:
                        //                     widget.arguments.product?.images)!
                        //             .isEmpty)
                        //     ? image_widget.Image.asset(productDefaultImage)
                        //     : image_widget.Image.memory(
                        //         getProductImage(
                        //             productImage:
                        //                 widget.arguments.product?.images)!,
                        //         fit: BoxFit.cover,
                        //       ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NullableTextWidget(
                              stringValue:
                                  '${widget.arguments.product?.title}, (${widget.arguments.product?.type})',
                              maxLines: 5,
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          hSizedBox(height: 8),
                          const Spacer(),
                          if (widget.arguments.product?.measurement != null &&
                              widget.arguments.product!.measurement! > 0)
                            NullableTextWidget(
                              stringValue: getProductMeasurement(
                                measurement:
                                    widget.arguments.product?.measurement,
                                measurementUnit:
                                    widget.arguments.product?.measurementUnit,
                              ),
                              textAlign: TextAlign.left,
                              textStyle: Theme.of(context).textTheme.subtitle2,
                            ),

                          // ProductItemButtons(
                          //   isForCatalog: widget.arguments.isForCatalog,
                          //   isSupplier: model.isSupplier(),
                          //   isProductInCatalog: model.isProductInCatalog(
                          //     productId: widget.arguments.product?.id,
                          //   ),
                          //   isProductInCart: model.isProductInCart(
                          //     productId: widget.arguments.product?.id,
                          //   ),
                          // )
                          // widget.arguments.isForCatalog
                          //     ? const RemoveProductWidget()
                          //     : model.isSupplier()
                          //         //check if product is in catalog

                          // ? model.isProductInCatalog(
                          //     productId: widget.arguments.product?.id,
                          //   )
                          //             ? const RemoveProductWidget()
                          //             : const AddProductWidget()
                          // : model.isProductInCart(
                          //         productId:
                          //             widget.arguments.product?.id)
                          //             ? Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceEvenly,
                          //                 children: [
                          //                   const Flexible(
                          //                     child: RemoveProductWidget(
                          //                       reverseStyle: true,
                          //                     ),
                          //                     flex: 1,
                          //                   ),
                          //                   wSizedBox(width: 4),
                          //                   const Flexible(
                          //                     child: UpdateProductWidget(),
                          //                     flex: 1,
                          //                   ),
                          //                 ],
                          //               )
                          //             : const AddProductWidget()
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
      toolTipMessage:
          'Update Product Quantity in ${viewModel.isSupplier() ? 'Catalog' : 'Cart'}',
      buttonBg: AppColors().buttonGreenColor,
      onTap: viewModel.onUpdateButtonClick,
      leading: Icon(
        Icons.edit,
        size: 20,
        color: AppColors().white,
      ),
    );
  }
}

class RemoveProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const RemoveProductWidget({
    Key? key,
    this.reverseStyle = false,
  }) : super(key: key);

  final bool reverseStyle;

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return AppButton(
      toolTipMessage:
          'Remove Product from ${viewModel.isSupplier() ? 'Catalog' : 'Cart'}',
      buttonBg: AppColors().buttonRedColor,
      onTap: viewModel.onRemoveButtonClick,
      leading: Icon(
        Icons.delete,
        size: 20,
        color: AppColors().white,
      ),
    );
  }
}
