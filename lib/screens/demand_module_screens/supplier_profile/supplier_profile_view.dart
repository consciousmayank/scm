import 'package:flutter/material.dart';
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
import 'package:scm/widgets/app_table_widget.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/hyper_link_type_text_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/no_data_widget.dart';
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

  getSupplierProfileForDemandModule({
    required SuppplierProfileViewModel model,
  }) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Column(
            children: [
              AppTableWidget.header(
                values: [
                  AppTableSingleItem.string(
                    widget.arguments.selectedSupplier!.businessName != null
                        ? "${widget.arguments.selectedSupplier!.businessName!}'\s Info"
                        : "--",
                    flexValue: 1,
                    textAlignment: TextAlign.left,
                    textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: AppColors().primaryHeaderTextColor,
                        ),
                  ),
                ],
              ),
              AppTableWidget.values(
                values: [
                  AppTableSingleItem.customWidget(
                    ProfileImageWidget.withCurvedBorder(
                      elevation: 0,
                      profileImageHeight: 90,
                      profileImageWidth: 90,
                      borderDerRadius: BorderRadius.all(
                        Radius.circular(
                          Dimens().suppliersListItemImageCircularRaduis,
                        ),
                      ),
                      imageUrlString: checkImageUrl(
                        imageUrl: widget.arguments.selectedSupplier!.image,
                      ),
                    ),
                    flexValue: 1,
                  ),
                  AppTableSingleItem.customWidget(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      child: LabelValueDataShowWidget.column(
                        label: 'Contact Person',
                        value: widget.arguments.selectedSupplier!.contactPerson,
                      ),
                    ),
                    flexValue: 2,
                  ),
                  AppTableSingleItem.customWidget(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      child: LabelValueDataShowWidget.column(
                        label: 'Mobile Number',
                        value: widget.arguments.selectedSupplier!.mobile,
                      ),
                    ),
                    flexValue: 2,
                  ),
                  AppTableSingleItem.customWidget(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      child: LabelValueDataShowWidget.column(
                        label: 'Phone',
                        value: widget.arguments.selectedSupplier!.phone,
                      ),
                    ),
                    flexValue: 2,
                  ),
                ],
              ),
            ],
          ),
          if (widget.arguments.selectedSupplier!.address != null &&
              widget.arguments.selectedSupplier!.address!.isNotEmpty)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                AppTableWidget.values(
                  values: [
                    AppTableSingleItem.customWidget(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        child: LabelValueDataShowWidget.column(
                          label: 'Address',
                          value: widget
                              .arguments.selectedSupplier!.address!.first
                              .toString(),
                        ),
                      ),
                      flexValue: 2,
                    ),
                  ],
                ),
                if (widget.arguments.selectedSupplier!.address!.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HyperLinkTextView(
                      linkStyle: Theme.of(context).textTheme.bodyText2!,
                      text: labelViewAllAddresses,
                      onHyperLinkTap: () =>
                          model.showSuppliersAddressListDialog(),
                    ),
                  )
              ],
            ),
          hSizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuppplierProfileViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: widget.arguments.cardify
            ? Card(
                shape: Dimens().getCardShape(),
                elevation: Dimens().getDefaultElevation,
                color: AppColors().white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getProfileChildWidget(
                    model: model,
                  ),
                ),
              )
            : getProfileChildWidget(
                model: model,
              ),
      ),
      viewModelBuilder: () => SuppplierProfileViewModel(),
    );
  }

  Widget getProfileChildWidget({
    required SuppplierProfileViewModel model,
  }) {
    return CustomScrollView(
      controller: ScrollController(
        keepScrollOffset: true,
      ),
      slivers: [
        if (widget.arguments.selectedSupplier != null)
          getSupplierProfileForDemandModule(model: model),
        if (widget.arguments.selectedSupplier != null)
          SliverToBoxAdapter(
            child: hSizedBox(
              height: 8,
            ),
          ),
        if (model.brandsApiStatus == ApiStatus.FETCHED &&
            model.allBrandsResponse!.brands!.isNotEmpty)
          SliverToBoxAdapter(
            child: AppTableWidget.header(
              values: [
                AppTableSingleItem.customWidget(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.arguments.isSupplierCatalog
                            ? 'My Brands'
                            : "Popular Brands",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: AppColors().primaryHeaderTextColor,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: HyperLinkTextView(
                          onHyperLinkTap: () => widget
                                      .arguments.selectedSupplier !=
                                  null
                              ? model
                                  .navigateToPopularBrandsFullScreenForDemander()
                              : model
                                  .navigateToPopularBrandsFullScreenForSupplier(),
                          text: labelSeeMore,
                          linkStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      )
                    ],
                  ),
                  flexValue: 1,
                ),
              ],
            ),
          ),
        SliverToBoxAdapter(
          child: model.brandsApiStatus == ApiStatus.LOADING
              ? const LoadingWidgetWithText(text: labelFetchingBrands)
              : model.allBrandsResponse!.brands!.isEmpty
                  ? Column(
                      children: const [
                        NoDataWidget.noCard(text: labelNoBrandsFound),
                        DottedDivider(),
                      ],
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
                              itemScrollController: brandsItemScrollController,
                              itemPositionsListener:
                                  brandsItemPositionsListener,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 250,
                                  child: Builder(builder: (context) {
                                    return SingleBrandItemWidget(
                                      item: model.allBrandsResponse!.brands!
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
                                index: model.allBrandsResponse!.brands!.length,
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            child: const SizedBox(
                              height: 150,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4),
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
              child: AppTableWidget.header(
            values: [
              AppTableSingleItem.customWidget(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.arguments.isSupplierCatalog
                          ? 'My Categories'
                          : "Popular Categories",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: HyperLinkTextView(
                        onHyperLinkTap: () => widget
                                    .arguments.selectedSupplier !=
                                null
                            ? model.navigateToCategoriesFullScreenForDemander()
                            : model.navigateToCategoriesFullScreenForSupplier(),
                        text: labelSeeMore,
                        linkStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors().primaryHeaderTextColor,
                                ),
                      ),
                    ),
                  ],
                ),
                flexValue: 1,
              ),
            ],
          )),
        SliverToBoxAdapter(
          child: model.categoriesApiStatus == ApiStatus.LOADING
              ? const LoadingWidgetWithText(text: labelFetchingCategories)
              : model.productCategoriesResponse!.types!.isEmpty
                  ? Column(
                      children: const [
                        NoDataWidget.noCard(
                          text: labelNoCategoriesFound,
                        ),
                        DottedDivider(),
                      ],
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
                                child: Icon(Icons.arrow_back_ios, size: 30),
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
                                    item:
                                        model.productCategoriesResponse!.types!
                                                .elementAt(
                                                  index,
                                                )
                                                .type ??
                                            '',
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
                                  .productCategoriesResponse!.types!.length,
                            ),
                          ),
                          AppInkwell(
                            onTap: () {
                              categoriesItemScrollController.scrollTo(
                                index: model
                                    .productCategoriesResponse!.types!.length,
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            child: const SizedBox(
                              height: 150,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4),
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
            child: AppTableWidget.header(
              values: [
                AppTableSingleItem.customWidget(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.arguments.isSupplierCatalog
                            ? 'My Products'
                            : "Popular Products",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: AppColors().primaryHeaderTextColor,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: HyperLinkTextView(
                          linkStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                          text: labelSeeMore,
                          onHyperLinkTap: () => widget
                                      .arguments.selectedSupplier !=
                                  null
                              ? model
                                  .navigateToProductListFullScreenForDemander()
                              : model
                                  .navigateToProductListFullScreenForSupplier(),
                        ),
                      )
                    ],
                  ),
                  flexValue: 1,
                ),
              ],
            ),
          ),
        model.productListApiStatus == ApiStatus.LOADING
            ? const SliverToBoxAdapter(
                child: LoadingWidgetWithText(text: labelFetchingProducts),
              )
            : model.allBrandsResponse!.brands!.isEmpty
                ? const SliverToBoxAdapter(
                    child: NoDataWidget.noCard(
                      text: labelNoProductsFound,
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return AppTableWidget.values(values: [
                          AppTableSingleItem.customWidget(
                            ProductListItem2View(
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
                                      supplierId:
                                          widget.arguments.selectedSupplier?.id,
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
                            ),
                            flexValue: 1,
                          )
                        ]);
                      },
                      childCount: model.productListResponse!.products!.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          widget.arguments.selectedSupplier == null ? 3 : 2,
                      mainAxisExtent: 250,
                      // childAspectRatio: 3,
                    ),
                  ),
        if (model.productListApiStatus == ApiStatus.FETCHED)
          const SliverToBoxAdapter(
            child: AppFooterWidget(),
          ),
      ],
    );
  }
}

class SuppplierProfileViewArguments {
  const SuppplierProfileViewArguments({
    required this.selectedSupplier,
  })  : isSupplierCatalog = false,
        cardify = true;

  const SuppplierProfileViewArguments.allProductsForSupplier()
      : isSupplierCatalog = false,
        cardify = false,
        selectedSupplier = null;

  const SuppplierProfileViewArguments.catalog()
      : isSupplierCatalog = true,
        cardify = false,
        selectedSupplier = null;

  final bool isSupplierCatalog, cardify;
  final Supplier? selectedSupplier;
}
