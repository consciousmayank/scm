import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/streams/catalog_stream.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/src/widgets/image.dart' as image_widget;

class ProductListItem2View extends StatefulWidget {
  final ProductListItem2ViewArguments arguments;
  const ProductListItem2View({
    Key? key,
    required this.arguments,
  }) : super(key: key);
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
        body: model.isBusy
            ? const Center(child: LoadingWidget())
            : AppInkwell.withBorder(
                onTap: () => widget.arguments.onProductClick(),
                borderDerRadius: BorderRadius.circular(
                  Dimens().suppliersListItemImageCircularRaduis,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: (getProductImage(
                                      productImage:
                                          widget.arguments.product?.images) ==
                                  null ||
                              getProductImage(
                                      productImage:
                                          widget.arguments.product?.images)!
                                  .isEmpty)
                          ? image_widget.Image.asset(productDefaultImage)
                          : image_widget.Image.memory(
                              getProductImage(
                                  productImage:
                                      widget.arguments.product?.images)!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NullableTextWidget(
                              stringValue: widget.arguments.product?.title,
                              maxLines: 2,
                              textStyle: Theme.of(context).textTheme.headline6,
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
                                  borderRadius: BorderRadius.circular(
                                      Dimens().defaultBorder / 2),
                                  color:
                                      AppColors().productListItemWebCategoryBg,
                                  border: Border.all(
                                    color: AppColors()
                                        .productListItemWebCategoryContainerBg,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: NullableTextWidget(
                                    stringValue: widget.arguments.product?.type,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: NullableTextWidget(
                                    stringValue: getProductMeasurement(
                                      measurement:
                                          widget.arguments.product?.measurement,
                                      measurementUnit: widget
                                          .arguments.product?.measurementUnit,
                                    ),
                                    textAlign: TextAlign.center,
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: widget.arguments.isForCatalog
                                    ? const RemoveProductWidget()
                                    : model.isProductInCart(
                                            productId:
                                                widget.arguments.product?.id)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Flexible(
                                                child: RemoveProductWidget(
                                                  reverseStyle: true,
                                                ),
                                                flex: 1,
                                              ),
                                              wSizedBox(width: 4),
                                              const Flexible(
                                                child: UpdateProductWidget(),
                                                flex: 1,
                                              ),
                                            ],
                                          )
                                        : const AddProductWidget(),
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
  final Product? product;
  final bool isForCatalog;
  final int? supplierId;
  final Function onProductOperationCompleted;
  final Function onProductClick;

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
}

class AddProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const AddProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return TextButton(
      clipBehavior: Clip.antiAlias,
      style: AppTextButtonsStyles(
        context: context,
      ).textButtonStyleForProductListItem,
      onPressed: viewModel.onAddButtonClick,
      child: const Text('Add'),
    );
  }
}

class UpdateProductWidget extends ViewModelWidget<ProductListItem2ViewModel> {
  const UpdateProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListItem2ViewModel viewModel) {
    return TextButton(
      clipBehavior: Clip.antiAlias,
      style: AppTextButtonsStyles(
        context: context,
      ).textButtonStyleForProductListItem,
      onPressed: viewModel.onUpdateButtonClick,
      child: const Text('Update'),
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
    return TextButton(
      clipBehavior: Clip.antiAlias,
      style: reverseStyle
          ? AppTextButtonsStyles(context: context)
              .textButtonStyleForProductListItemReversed
          : AppTextButtonsStyles(
              context: context,
            ).textButtonStyleForProductListItem,
      onPressed: viewModel.onRemoveButtonClick,
      child: const Text('Remove'),
    );
  }
}
