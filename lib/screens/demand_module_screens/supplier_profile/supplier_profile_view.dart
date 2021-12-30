import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/order_list_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item.dart';
import 'package:scm/widgets/profile_image_widget.dart';
import 'package:scm/widgets/showing_data_widgets.dart';
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
                  filledColor: AppColors().orderDetailsContainerBg,
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
                    height: 205,
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
                            childAspectRatio: 5 / 1,
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
                    filledColor: AppColors().orderDetailsContainerBg,
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
              model.brandsApiStatus == ApiStatus.LOADING
                  ? const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: LoadingWidgetWithText(
                              text: 'Fetching Brands. Please Wait...'),
                        ),
                      ),
                    )
                  : model.allBrandsResponse!.brands!.isEmpty
                      ? const SliverToBoxAdapter(
                          child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text('No Brands Found'),
                          ),
                        ))
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SinglePopularBrandItem(
                                  item: model.allBrandsResponse!.brands!
                                      .elementAt(
                                    index,
                                  ),
                                  onItemClicked: ({
                                    required Brand selectedItem,
                                  }) {
                                    model.takeToProductListView(
                                      selectedItem: selectedItem,
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: model.allBrandsResponse!.brands!.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 2,
                          ),
                        ),
              if (model.productListApiStatus == ApiStatus.FETCHED &&
                  model.productListResponse!.products!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: "Popular Products",
                    filledColor: AppColors().orderDetailsContainerBg,
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
