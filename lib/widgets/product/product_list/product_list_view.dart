import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/list_footer.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item.dart';
import 'package:scm/widgets/product/product_list/product_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductListViewArguments arguments;

  String getTitle({required ProductListViewModel model}) {
    return arguments.supplierName == null
        ? model.brandsFilterList.isNotEmpty ||
                model.categoryFilterList.isNotEmpty ||
                model.subCategoryFilterList.isNotEmpty
            ? 'Product List'
            : 'Popular Products'
        : suppliersProductsListPageTitle(
            suppliersName: arguments.supplierName ?? '',
          );
  }

  List<Widget> getOptionsList({
    required ProductListViewModel model,
    required BuildContext context,
  }) {
    return [
      wSizedBox(width: 10),
      if (arguments.showSeeAll)
        AppInkwell(
          onTap: () => model.takeToProductListFullScreen(),
          child: Text(
            'See All',
            style: AppTextStyles(context: context)
                .popularBrandsTitleStyle
                .copyWith(
                    color: AppColors().popularBrandsSeeAllBg,
                    decoration: TextDecoration.underline),
          ),
        ),
      if (arguments.showFilterAndSortOption)
        Row(
          children: [
            wSizedBox(
              width: 8,
            ),
            AnimatedSearchWidget(
              hintText: labelSearchProducts,
              onSearch: ({required String searchTerm}) {
                model.productTitle = searchTerm;
                model.getProductList();
              },
              onCrossButtonClicked: () {
                model.productTitle = '';
                model.getProductList();
              },
              // searchController: model.searchController,
              // searchFocusNode: model.searchFocusNode,
            ),
            wSizedBox(
              width: 8,
            ),
            TextButton.icon(
              style: AppTextButtonsStyles(
                context: context,
              ).textButtonStyleForProductListItem,
              onPressed: () => model.openFiltersDialogBox(),
              icon: const Icon(Icons.filter),
              label: Text(
                model.getAppliedFiltersCount() == 0
                    ? 'Filter'
                    : 'Filter (${model.getAppliedFiltersCount()})',
              ),
            ),
            wSizedBox(width: 8),
            if (arguments.supplierName != null)
              CartIconView(
                key: UniqueKey(),
                arguments: CartIconViewArguments(),
              )
          ],
        ),
      wSizedBox(width: 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      builder: (context, model, child) => Scaffold(
        appBar: arguments.showAppbar
            ? appbarWidget(
                automaticallyImplyLeading: true,
                context: context,
                title: getTitle(model: model),
                options: getOptionsList(
                  model: model,
                  context: context,
                ),
              )
            : null,
        body: model.isBusy
            ? const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: LoadingWidgetWithText(
                    text: 'Fetching Products. Please Wait...',
                  ),
                ),
              )
            : Card(
                shape: Dimens().getCardShape(),
                color: arguments.productsPerLine == 3
                    ? AppColors().white
                    : AppColors().popularBrandsBg,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: arguments.supplierName == null
                        ? Dimens().popularBrandsToppadding
                        : 0,
                    left: Dimens().popularBrandsLeftpadding,
                    right: Dimens().popularBrandsRightpadding,
                  ),
                  child: model.productListResponse!.products!.isNotEmpty
                      ? Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Column(
                                children: [
                                  if (!arguments.showAppbar &&
                                      arguments.isScrollVertical)
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            style: AppTextButtonsStyles(
                                              context: context,
                                            ).textButtonStyleForProductListItem,
                                            onPressed: () =>
                                                model.openFiltersDialogBox(),
                                            icon: const Icon(Icons.filter),
                                            label: Text(
                                              model.getAppliedFiltersCount() ==
                                                      0
                                                  ? 'Filter'
                                                  : 'Filter (${model.getAppliedFiltersCount()})',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (arguments.showSeeAll)
                                    Container(
                                      color: AppColors().white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getTitle(
                                              model: model,
                                            ),
                                            style:
                                                AppTextStyles(context: context)
                                                    .popularBrandsTitleStyle,
                                          ),
                                          Row(
                                            children: getOptionsList(
                                                model: model, context: context),
                                          )
                                        ],
                                      ),
                                    ),
                                  hSizedBox(height: 8),
                                  Flexible(
                                    child: GridView.builder(
                                      //Enable endless list
                                      // key: const PageStorageKey('product_list'),
                                      scrollDirection:
                                          arguments.isScrollVertical
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                      itemCount: model.productListResponse!
                                          .products!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: getValueForScreenType(
                                          context: context,
                                          mobile: 1,
                                          tablet: arguments.isScrollVertical
                                              ? arguments.productsPerLine
                                              : 2,
                                          desktop: arguments.isScrollVertical
                                              ? arguments.productsPerLine
                                              : 2,
                                        ),
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio:
                                            arguments.productsPerLine == 2
                                                ? 2
                                                : 3,
                                      ),
                                      itemBuilder:
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
                                                    .productListResponse!
                                                    .products!
                                                    .elementAt(
                                                  index,
                                                ),
                                              );
                                            },
                                            onProductClick: () {
                                              model.openProductDetails(
                                                product: model
                                                    .productListResponse!
                                                    .products!
                                                    .elementAt(index),
                                              );
                                            },
                                            // image: getProductImage(model, index),
                                            image: getProductImage(
                                                productImage: model
                                                    .productListResponse!
                                                    .products!
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
                                    ),
                                  ),
                                  if (arguments.showBottomPageChanger)
                                    ListFooter.previousNext(
                                      pageNumber: model.pageIndex,
                                      totalPages: model.productListResponse!
                                                  .totalPages ==
                                              null
                                          ? 0
                                          : model.productListResponse!
                                                  .totalPages! -
                                              1,
                                      onPreviousPageClick: () {
                                        model.pageIndex = model.pageIndex - 1;
                                        model.getProductList();
                                      },
                                      onNextPageClick: () {
                                        model.pageIndex = model.pageIndex + 1;
                                        model.getProductList();
                                      },
                                    )
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(productListNoProductsFoundError),
                        ),
                ),
              ),
      ),
      viewModelBuilder: () => ProductListViewModel(),
    );
  }
}

class ProductListViewArguments {
  ProductListViewArguments.appbar({
    this.showAppbar = false,
    this.isScrollVertical = true,
    this.showBottomPageChanger = true,
    this.showFilterAndSortOption = false,
    this.showSeeAll = false,
    required this.brandsFilterList,
    required this.categoryFilterList,
    required this.subCategoryFilterList,
    required this.productTitle,
    required this.supplierId,
  })  : productsPerLine = 4,
        supplierName = null;

  ProductListViewArguments.asSupplierProductList({
    this.showAppbar = true,
    this.isScrollVertical = true,
    this.showBottomPageChanger = true,
    this.showFilterAndSortOption = true,
    this.showSeeAll = false,
    required this.brandsFilterList,
    required this.categoryFilterList,
    required this.subCategoryFilterList,
    required this.productTitle,
    required this.supplierId,
    required this.supplierName,
  }) : productsPerLine = 3;

  ProductListViewArguments.asWidget({
    this.isScrollVertical = false,
    this.showBottomPageChanger = false,
    this.showFilterAndSortOption = false,
    this.showSeeAll = true,
    this.showAppbar = false,
    required this.brandsFilterList,
    required this.categoryFilterList,
    required this.subCategoryFilterList,
    required this.productTitle,
    required this.supplierId,
  })  : productsPerLine = 4,
        supplierName = null;

  ProductListViewArguments.fullScreen({
    this.showAppbar = true,
    this.isScrollVertical = true,
    this.showBottomPageChanger = true,
    this.showFilterAndSortOption = true,
    this.showSeeAll = false,
    required this.brandsFilterList,
    required this.categoryFilterList,
    required this.subCategoryFilterList,
    required this.productTitle,
    required this.supplierId,
  })  : productsPerLine = 4,
        supplierName = null;

  final List<String?>? brandsFilterList;
  final List<String?>? categoryFilterList;
  final String? productTitle;
  final int productsPerLine;
  final bool isScrollVertical,
      showSeeAll,
      showBottomPageChanger,
      showFilterAndSortOption,
      showAppbar;

  final List<String?>? subCategoryFilterList;
  final int? supplierId;
  final String? supplierName;
}

class LoadNextProductWidget extends ViewModelWidget<ProductListViewModel> {
  const LoadNextProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ProductListViewModel viewModel) {
    return viewModel.productListResponse!.totalPages! - 1 == viewModel.pageIndex
        ? Container()
        : Container(
            height: Dimens().productListItemWebHeight,
            width: Dimens().productListItemWebWidth,
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(Dimens().defaultBorder / 2),
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors().black.withOpacity(0.6),
              //     blurRadius: Dimens().defaultBorder/2,
              //     offset: Offset(
              //       Dimens().defaultBorder/2,
              //       Dimens().defaultBorder/2,
              //     ),
              //   ),
              // ],
            ),
            child: viewModel.isBusy
                ? const LoadingWidgetWithText(
                    text: 'Loading More Products. Please wait')
                : Center(
                    child: TextButton(
                        style: AppTextButtonsStyles(
                          context: context,
                        ).textButtonStyle,
                        onPressed:
                            viewModel.productListResponse!.totalPages! - 1 ==
                                    viewModel.pageIndex
                                ? null
                                : () {
                                    viewModel.pageIndex++;
                                    viewModel.getProductList();
                                  },
                        child: Text(
                            viewModel.productListResponse!.totalPages! - 1 ==
                                    viewModel.pageIndex
                                ? 'Thats all folks'
                                : 'Load Next Set of Products')),
                  ),
          );
  }
}
