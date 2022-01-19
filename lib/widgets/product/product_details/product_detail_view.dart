import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_details/product_detail_viewmodel.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/src/widgets/image.dart' as image_widget;

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductDetailViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      builder: (context, model, child) {
        return Scaffold(
          body: model.isBusy
              ? const LoadingWidgetWithText(text: 'Fetching Product Details')
              : SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: (model.productImage == null)
                              ? image_widget.Image.asset(productDefaultImage)
                              : image_widget.Image.memory(
                                  model.productImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.product!.title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              ProductDetialItem(
                                label: 'Product Code         ',
                                value: model.product!.id.toString(),
                              ),
                              ProductDetialItem(
                                label: 'Brand         ',
                                value: model.product!.brand,
                              ),
                              ProductDetialItem(
                                  label: 'Category      ',
                                  value: model.product!.type),
                              ProductDetialItem(
                                  label: 'Sub-Category  ',
                                  value: model.product!.subType),
                              ProductDetialItem(
                                  label: 'Price         ',
                                  value: model.product!.price!.toString()),
                              ProductDetialItem(
                                label: 'Weight        ',
                                value: getProductMeasurement(
                                  measurement: model.product!.measurement,
                                  measurementUnit:
                                      model.product!.measurementUnit,
                                ),
                              ),
                              ProductDetialItem(
                                label: 'Summary         ',
                                value: model.product!.summary,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => ProductDetailViewModel(),
    );
  }
}

class ProductDetailViewArguments {
  ProductDetailViewArguments({
    this.productId,
    required this.product,
  });

  ProductDetailViewArguments.fetchProduct({
    required this.productId,
    this.product,
  });

  final Product? product;
  final int? productId;
}

class ProductDetialItem extends StatelessWidget {
  const ProductDetialItem({
    Key? key,
    required this.label,
    this.value,
  }) : super(key: key);

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline5,
            )),
        Expanded(
          flex: 2,
          child: NullableTextWidget(
            textStyle: Theme.of(context).textTheme.headline6,
            stringValue: value,
          ),
        ),
      ],
    );
  }
}
