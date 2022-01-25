import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/product/product_list_item_v2/product_list_item_2.dart';
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

  getSupplierProfileForDemandModule() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          hSizedBox(
            height: 8,
          ),
          PageBarWidget.withCustomFiledColor(
            title:
                "${widget.arguments.selectedSupplier!.businessName!}'\s Info",
            filledColor: Theme.of(context).primaryColorLight,
          ),
          hSizedBox(
            height: 8,
          ),
          Padding(
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
                        Dimens().suppliersListItemImageCircularRaduis,
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
                          value:
                              widget.arguments.selectedSupplier!.contactPerson,
                        ),
                        LabelValueDataShowWidget.column(
                          label: 'Mobile Number',
                          value: widget.arguments.selectedSupplier!.mobile,
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
          )
        ],
      ),
    );
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
              if (widget.arguments.selectedSupplier != null)
                getSupplierProfileForDemandModule(),
              if (widget.arguments.selectedSupplier != null)
                SliverToBoxAdapter(
                  child: hSizedBox(
                    height: 8,
                  ),
                ),
              if (model.brandsApiStatus == ApiStatus.FETCHED &&
                  model.allBrandsResponse!.brands!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: widget.arguments.isSupplierCatalog
                        ? 'My Brands'
                        : "Popular Brands",
                    filledColor: Theme.of(context).primaryColorLight,
                    options: [
                      AppInkwell(
                        onTap: () => widget.arguments.selectedSupplier != null
                            ? model
                                .navigateToPopularBrandsFullScreenForDemander()
                            : model
                                .navigateToPopularBrandsFullScreenForSupplier(),
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
                child: model.brandsApiStatus == ApiStatus.LOADING
                    ? const LoadingWidget(text: labelFetchingBrands)
                    : model.allBrandsResponse!.brands!.isEmpty
                        ? const NoDataWidget(text: labelNoBrandsFound)
                        : Container(
                            height: 150,
                            color: AppColors().white,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: AppInkwell(
                                    onTap: () {
                                      brandsItemScrollController.scrollTo(
                                        index: 0,
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    },
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 30,
                                      ),
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
                                    itemCount:
                                        model.allBrandsResponse!.brands!.length,
                                  ),
                                ),
                                AppInkwell(
                                  onTap: () {
                                    brandsItemScrollController.scrollTo(
                                      index: model
                                          .allBrandsResponse!.brands!.length,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: const SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 4, right: 4),
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
              if (model.categoriesApiStatus == ApiStatus.FETCHED &&
                  model.productCategoriesResponse!.types!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: widget.arguments.isSupplierCatalog
                        ? 'My Categories'
                        : "Popular Categories",
                    filledColor: Theme.of(context).primaryColorLight,
                    options: [
                      AppInkwell(
                        onTap: () => widget.arguments.selectedSupplier != null
                            ? model.navigateToCategoriesFullScreenForDemander()
                            : model.navigateToCategoriesFullScreenForSupplier(),
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
                child: model.categoriesApiStatus == ApiStatus.LOADING
                    ? const LoadingWidget(text: labelFetchingCategories)
                    : model.productCategoriesResponse!.types!.isEmpty
                        ? const NoDataWidget(
                            text: labelNoCategoriesFound,
                          )
                        : Container(
                            height: 150,
                            color: AppColors().white,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: AppInkwell(
                                    onTap: () {
                                      categoriesItemScrollController.scrollTo(
                                        index: 0,
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.easeInOutCubic,
                                      );
                                    },
                                    child: const Center(
                                      child:
                                          Icon(Icons.arrow_back_ios, size: 30),
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
                                              .productCategoriesResponse!.types!
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
                                    itemCount: model.productCategoriesResponse!
                                        .types!.length,
                                  ),
                                ),
                                AppInkwell(
                                  onTap: () {
                                    categoriesItemScrollController.scrollTo(
                                      index: model.productCategoriesResponse!
                                          .types!.length,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.easeInOutCubic,
                                    );
                                  },
                                  child: const SizedBox(
                                    height: 150,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 4, right: 4),
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
              if (model.productListApiStatus == ApiStatus.FETCHED &&
                  model.productListResponse!.products!.isNotEmpty)
                SliverToBoxAdapter(
                  child: PageBarWidget.withCustomFiledColor(
                    title: widget.arguments.isSupplierCatalog
                        ? 'My Products'
                        : "Popular Products",
                    filledColor: Theme.of(context).primaryColorLight,
                    options: [
                      AppInkwell(
                        onTap: () => widget.arguments.selectedSupplier != null
                            ? model.navigateToProductListFullScreenForDemander()
                            : model
                                .navigateToProductListFullScreenForSupplier(),
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
              model.productListApiStatus == ApiStatus.LOADING
                  ? const SliverToBoxAdapter(
                      child: LoadingWidget(text: labelFetchingProducts),
                    )
                  : model.allBrandsResponse!.brands!.isEmpty
                      ? const SliverToBoxAdapter(
                          child: NoDataWidget(
                            text: labelNoProductsFound,
                          ),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ProductListItem2View(
                                arguments: widget.arguments.isSupplierCatalog
                                    ? ProductListItem2ViewArguments.catalog(
                                        product: model
                                            .productListResponse!.products!
                                            .elementAt(index),
                                        onProductOperationCompleted: () {
                                          model.reloadPage();
                                        },
                                        onProductClick: () {
                                          model.openProductDetails(
                                            product: model
                                                .productListResponse!.products!
                                                .elementAt(index),
                                          );
                                        },
                                      )
                                    : ProductListItem2ViewArguments(
                                        supplierId: widget
                                            .arguments.selectedSupplier?.id,
                                        product: model
                                            .productListResponse!.products!
                                            .elementAt(index),
                                        onProductOperationCompleted: () {
                                          model.reloadPage();
                                        },
                                        onProductClick: () {
                                          model.openProductDetails(
                                            product: model
                                                .productListResponse!.products!
                                                .elementAt(index),
                                          );
                                        },
                                      ),
                              );
                            },
                            childCount:
                                model.productListResponse!.products!.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                widget.arguments.selectedSupplier == null
                                    ? 3
                                    : 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                            mainAxisExtent: 250,
                            // childAspectRatio: 3,
                          ),
                        ),
              if (model.productListApiStatus == ApiStatus.FETCHED)
                const SliverToBoxAdapter(
                  child: AppFooterWidget(),
                ),
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
  }) : isSupplierCatalog = false;

  const SuppplierProfileViewArguments.allProductsForSupplier()
      : isSupplierCatalog = false,
        selectedSupplier = null;

  const SuppplierProfileViewArguments.catalog()
      : isSupplierCatalog = true,
        selectedSupplier = null;

  final bool isSupplierCatalog;
  final Supplier? selectedSupplier;
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: Dimens().getCardShape(),
        color: Colors.white,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: LoadingWidgetWithText(
          text: text,
        ),
      ),
    );
  }
}
