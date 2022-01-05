import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item.dart';
import 'package:scm/widgets/showing_data_widgets.dart';
import 'package:scm/widgets/single_brand_item.dart';
import 'package:scm/widgets/single_category_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class SuppplierProfileView extends StatefulWidget {
  const SuppplierProfileView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SuppplierProfileViewArguments arguments;

  @override
  _SuppplierProfileViewState createState() => _SuppplierProfileViewState();
}

class _SuppplierProfileViewState extends State<SuppplierProfileView> {
  final ItemPositionsListener brandsItemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController brandsItemScrollController =
      ItemScrollController();

  final ItemPositionsListener categoriesItemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController categoriesItemScrollController =
      ItemScrollController();

  @override
  void initState() {
    super.initState();
    brandsItemPositionsListener.itemPositions.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuppplierProfileViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: Card(
          shape: Dimens().getCardShape(),
          color: AppColors().white,
          child: CustomScrollView(
            controller: ScrollController(
              keepScrollOffset: true,
            ),
            slivers: [
              SliverToBoxAdapter(
                child: hSizedBox(
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: PageBarWidget.withCustomFiledColor(
                  title:
                      "${widget.arguments.selectedSupplier!.businessName!}'\s Info",
                  filledColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SliverToBoxAdapter(
                child: hSizedBox(
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileImageWidget.withCurvedBorder(
                          elevation: 0,
                          profileImageSize: 210,
                          borderDerRadius: BorderRadius.all(
                            Radius.circular(
                              Dimens().suppliersListItemImageCiircularRaduis,
                            ),
                          ),
                          imageUrlString: checkImageUrl(
                            imageUrl: widget.arguments.selectedSupplier!.image,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GridView.count(
                            childAspectRatio: 6.5,
                            crossAxisCount: 2,
                            children: [
                              LabelValueDataShowWidget.column(
                                label: 'Contact Person',
                                value: widget
                                    .arguments.selectedSupplier!.contactPerson,
                              ),
                              LabelValueDataShowWidget.column(
                                label: 'Mobile Number',
                                value:
                                    widget.arguments.selectedSupplier!.mobile,
                              ),
                              LabelValueDataShowWidget.column(
                                label: 'Email',
                                value: widget.arguments.selectedSupplier!.email,
                              ),
                              LabelValueDataShowWidget.column(
                                label: 'Phone',
                                value: widget.arguments.selectedSupplier!.phone,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: hSizedBox(
                  height: 8,
                ),
              ),
              if (model.brandsApiStatus == ApiStatus.FETCHED &&
                  model.allBrandsResponse!.brands!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: "Popular Brands",
                    filledColor: Theme.of(context).colorScheme.secondary,
                    options: [
                      AppInkwell(
                        onTap: () => model
                            .navigateToPopularBrandsFullScreenForDemander(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            labelSeeMore,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                  child: model.brandsApiStatus == ApiStatus.LOADING
                      ? const Center(
                          child: LoadingWidgetWithText(
                              text: 'Fetching Brands. Please Wait...'),
                        )
                      : model.allBrandsResponse!.brands!.isEmpty
                          ? const Center(
                              child: Text('No Brands Found'),
                            )
                          : Container(
                              color: AppColors().white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: AppInkwell(
                                      onTap: () {
                                        brandsItemScrollController.scrollTo(
                                          index: 0,
                                          duration: Duration(seconds: 2),
                                          curve: Curves.easeInOutCubic,
                                        );
                                      },
                                      child: const Center(
                                        child: Icon(Icons.arrow_back_ios,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ScrollablePositionedList.builder(
                                      itemScrollController:
                                          brandsItemScrollController,
                                      itemPositionsListener:
                                          brandsItemPositionsListener,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        log('Indexx :: $index');
                                        return SizedBox(
                                          width: 250,
                                          child: Builder(builder: (context) {
                                            return SingleBrandItemWidget(
                                              item: model
                                                  .allBrandsResponse!.brands!
                                                  .elementAt(
                                                index,
                                              ),
                                              onItemClicked: ({
                                                required Brand selectedItem,
                                              }) {
                                                model.takeToProductListView(
                                                  selectedBrand: selectedItem,
                                                );
                                              },
                                            );
                                          }),
                                        );
                                      },
                                      itemCount: model
                                          .allBrandsResponse!.brands!.length,
                                    ),
                                  ),
                                  AppInkwell(
                                    onTap: () {
                                      brandsItemScrollController.scrollTo(
                                        index: model
                                            .allBrandsResponse!.brands!.length,
                                        duration: Duration(seconds: 2),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    },
                                    child: const SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
              if (model.categoriesApiStatus == ApiStatus.FETCHED &&
                  model.productCategoriesResponse!.types!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: "Popular Categories",
                    filledColor: Theme.of(context).colorScheme.secondary,
                    options: [
                      AppInkwell(
                        onTap: () =>
                            model.navigateToCategoriesFullScreenForDemander(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            labelSeeMore,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                  child: model.categoriesApiStatus == ApiStatus.LOADING
                      ? const Center(
                          child: LoadingWidgetWithText(
                              text: 'Fetching Categories. Please Wait...'),
                        )
                      : model.productCategoriesResponse!.types!.isEmpty
                          ? const Center(
                              child: Text('No Categories Found'),
                            )
                          : Container(
                              color: AppColors().white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: AppInkwell(
                                      onTap: () {
                                        categoriesItemScrollController.scrollTo(
                                          index: 0,
                                          duration: Duration(seconds: 2),
                                          curve: Curves.easeInOutCubic,
                                        );
                                      },
                                      child: const Center(
                                        child: Icon(Icons.arrow_back_ios,
                                            size: 30),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ScrollablePositionedList.builder(
                                      itemScrollController:
                                          categoriesItemScrollController,
                                      itemPositionsListener:
                                          categoriesItemPositionsListener,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: 180,
                                          child: SingleCategoryItemWidget(
                                            item: model
                                                .productCategoriesResponse!
                                                .types!
                                                .elementAt(
                                              index,
                                            ),
                                            onItemClicked: ({
                                              required String selectedItem,
                                            }) {
                                              model.takeToProductListView(
                                                selectedCategory: selectedItem,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      itemCount: model
                                          .productCategoriesResponse!
                                          .types!
                                          .length,
                                    ),
                                  ),
                                  AppInkwell(
                                    onTap: () {
                                      categoriesItemScrollController.scrollTo(
                                        index: model.productCategoriesResponse!
                                            .types!.length,
                                        duration: Duration(seconds: 2),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    },
                                    child: const SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
              if (model.productListApiStatus == ApiStatus.FETCHED &&
                  model.productListResponse!.products!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: "Popular Products",
                    filledColor: Theme.of(context).colorScheme.secondary,
                    options: [
                      AppInkwell(
                        onTap: () =>
                            model.navigateToProductListFullScreenForDemander(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            labelSeeMore,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              model.brandsApiStatus == ApiStatus.LOADING
                  ? const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: LoadingWidgetWithText(
                              text: 'Fetching products. Please Wait...'),
                        ),
                      ),
                    )
                  : model.allBrandsResponse!.brands!.isEmpty
                      ? const SliverToBoxAdapter(
                          child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('No Products Found'),
                          ),
                        ))
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ProductListItem(
                                arguments: ProductListItemArguments(
                                  productTitle: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .title,
                                  productCategory: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .type,
                                  productPrice: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .price,
                                  onAddButtonClick: () {
                                    model.addToCartObject
                                        .openProductQuantityDialogBox(
                                      product: model
                                          .productListResponse!.products!
                                          .elementAt(
                                        index,
                                      ),
                                    );
                                  },
                                  onProductClick: () {
                                    model.openProductDetails(
                                      product: model
                                          .productListResponse!.products!
                                          .elementAt(index),
                                    );
                                  },
                                  // image: getProductImage(model, index),
                                  image: getProductImage(
                                      productImage:
                                          model.productListResponse!.products!
                                              .elementAt(
                                                index,
                                              )
                                              .images),
                                  productId: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .id,
                                  measurementUnit: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .measurementUnit,
                                  measurement: model
                                      .productListResponse!.products!
                                      .elementAt(index)
                                      .measurement,
                                ),
                              );
                            },
                            childCount:
                                model.productListResponse!.products!.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 3,
                          ),
                        )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SuppplierProfileViewModel(),
    );
  }
}

class SuppplierProfileViewArguments {
  const SuppplierProfileViewArguments({
    required this.selectedSupplier,
  });

  final Supplier? selectedSupplier;
}
