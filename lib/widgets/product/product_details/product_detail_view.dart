import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as image_widget;
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/product_details/product_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

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
              ? const Center(
                  child: LoadingWidgetWithText(
                    text: 'Fetching Product Details',
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Container(
                                color: Colors.green,
                                child: AppTableWidget.values(
                                  values: [
                                    AppTableSingleItem.customWidget(
                                      ProfileImageWidget.productImage(
                                        onImageLoaded: () {},
                                        isForCatalog: false,
                                        supplierId: null,
                                        elevation: 0,
                                        profileImageHeight:
                                            Dimens().productDtailImageHeight,
                                        profileImageWidth:
                                            Dimens().productDtailImageHeight,
                                        borderDerRadius: BorderRadius.all(
                                          Radius.circular(
                                            Dimens()
                                                .suppliersListItemImageCircularRaduis,
                                          ),
                                        ),
                                        productId: model.product!.id,
                                      ),

                                      // (model.productImage == null)
                                      //     ? image_widget.Image.asset(
                                      //         productDefaultImage,
                                      //         fit: BoxFit.contain,
                                      // height: Dimens()
                                      //     .productDtailImageHeight,
                                      // width: Dimens()
                                      //     .productDtailImageHeight,
                                      //       )
                                      //     : image_widget.Image.memory(
                                      //         model.productImage!,
                                      //         fit: BoxFit.contain,
                                      //         height: Dimens()
                                      //             .productDtailImageHeight,
                                      //         width: Dimens()
                                      //             .productDtailImageHeight,
                                      //       ),
                                      showToolTip: false,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 22,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTableWidget.values(
                                    values: [
                                      AppTableSingleItem.string(
                                        'Title',
                                        flexValue: 1,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showToolTip: false,
                                      ),
                                      AppTableSingleItem.string(
                                        model.product!.title,
                                        flexValue: 2,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        showToolTip: false,
                                      ),
                                    ],
                                  ),
                                  AppTableWidget.values(
                                    values: [
                                      AppTableSingleItem.string(
                                        'Brand',
                                        flexValue: 1,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showToolTip: false,
                                      ),
                                      AppTableSingleItem.string(
                                        model.product!.brand,
                                        flexValue: 2,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        showToolTip: false,
                                      ),
                                    ],
                                  ),
                                  AppTableWidget.values(
                                    requiresPadding: true,
                                    values: [
                                      AppTableSingleItem.string(
                                        'Category',
                                        flexValue: 1,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showToolTip: false,
                                      ),
                                      AppTableSingleItem.string(
                                        model.product!.type,
                                        flexValue: 2,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1,
                                        showToolTip: false,
                                      ),
                                    ],
                                  ),
                                  AppTableWidget.values(
                                    requiresPadding: true,
                                    values: [
                                      AppTableSingleItem.string(
                                        'Sub Category',
                                        flexValue: 1,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showToolTip: false,
                                      ),
                                      AppTableSingleItem.string(
                                        model.product!.subType,
                                        flexValue: 2,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1,
                                        showToolTip: false,
                                      ),
                                    ],
                                  ),
                                  if (model.product != null &&
                                      model.product!.price != null)
                                    AppTableWidget.values(
                                      requiresPadding: true,
                                      values: [
                                        AppTableSingleItem.string(
                                          'Price',
                                          flexValue: 1,
                                          textAlignment: TextAlign.left,
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.subtitle1?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          showToolTip: false,
                                        ),
                                        AppTableSingleItem.double(
                                          model.product!.price,
                                          flexValue: 2,
                                          textAlignment: TextAlign.left,
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.subtitle1,
                                          showToolTip: false,
                                        ),
                                      ],
                                    ),
                                  if (model.product != null &&
                                      model.product!.measurement != null &&
                                      model.product!.measurementUnit != null)
                                    AppTableWidget.values(
                                      requiresPadding: true,
                                      values: [
                                        AppTableSingleItem.string(
                                          'Weight',
                                          flexValue: 1,
                                          textAlignment: TextAlign.left,
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.subtitle1?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          showToolTip: false,
                                        ),
                                        AppTableSingleItem.string(
                                          getProductMeasurement(
                                            measurement:
                                                model.product!.measurement,
                                            measurementUnit:
                                                model.product!.measurementUnit,
                                          ),
                                          flexValue: 2,
                                          textAlignment: TextAlign.left,
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.subtitle1,
                                          showToolTip: false,
                                        ),
                                      ],
                                    ),
                                  AppTableWidget.values(
                                    requiresPadding: true,
                                    values: [
                                      AppTableSingleItem.string(
                                        'Summary',
                                        flexValue: 1,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                        showToolTip: false,
                                      ),
                                      AppTableSingleItem.string(
                                        model.product!.summary,
                                        maxlines: null,
                                        flexValue: 2,
                                        textAlignment: TextAlign.left,
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.subtitle1,
                                        showToolTip: false,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // SliverToBoxAdapter(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //         flex: 1,
                      //         child: AppTableWidget.values(
                      //           values: [
                      //             AppTableSingleItem.string(
                      //               'Summary',
                      //               flexValue: 1,
                      //               textAlignment: TextAlign.left,
                      //               textStyle: Theme.of(
                      //                 context,
                      //               ).textTheme.bodyText1?.copyWith(
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: AppTableWidget.values(
                      //           values: [
                      //             AppTableSingleItem.string(
                      //               model.product!.summary,
                      //               maxlines: null,
                      //               flexValue: 2,
                      //               textAlignment: TextAlign.left,
                      //               textStyle: Theme.of(
                      //                 context,
                      //               ).textTheme.bodyText1?.copyWith(
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
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
