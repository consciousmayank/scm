import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/list_footer.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/popular_categories/popular_categories_viewmodel.dart';
import 'package:scm/widgets/app_image/profile_image_widget.dart';
import 'package:scm/widgets/single_category_item.dart';
import 'package:stacked/stacked.dart';

class PopularCategoriesView extends StatelessWidget {
  const PopularCategoriesView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PopularCategoriesViewArgs arguments;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const NotSupportedScreensView(),
      tablet: (BuildContext context) => const NotSupportedScreensView(),
      desktop: (BuildContext context) =>
          ViewModelBuilder<PopularCategoriesViewModel>.reactive(
        onModelReady: (model) => model.init(
          args: arguments,
        ),
        builder: (context, model, child) => Scaffold(
          appBar: arguments.isFullScreen
              ? appbarWidget(
                  context: context,
                  title: arguments.supplierName != null
                      ? suppliersCategoryListPageTitle(
                          suppliersName: arguments.supplierName!,
                        )
                      : suppliersCategoryPageTitle,
                  automaticallyImplyLeading: true,
                  options: [
                    AnimatedSearchWidget(
                      hintText: labelSearchBrands,
                      onSearch: ({required String searchTerm}) {
                        model.categoryTitle = searchTerm;
                        model.getAllCategories();
                      },
                      onCrossButtonClicked: () {
                        model.categoryTitle = null;
                        model.getAllCategories();
                      },
                      // searchController: model.searchController,
                      // searchFocusNode: model.searchFocusNode,
                    )
                  ],
                )
              : null,
          body: model.isBusy
              ? const Center(
                  child: LoadingWidgetWithText(
                    text: 'Fetching Categories. Please Wait',
                  ),
                )
              : Card(
                  shape: Dimens().getCardShape(),
                  color: AppColors().popularBrandsBg,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimens().popularBrandsToppadding,
                      left: Dimens().popularBrandsLeftpadding,
                      right: Dimens().popularBrandsRightpadding,
                    ),
                    child: Column(
                      children: [
                        if (!arguments.isFullScreen)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Categories',
                                style: AppTextStyles(context: context)
                                    .popularBrandsTitleStyle,
                              ),
                              Text(
                                'See All',
                                style: AppTextStyles(context: context)
                                    .popularBrandsTitleStyle
                                    .copyWith(
                                        color:
                                            AppColors().popularBrandsSeeAllBg,
                                        decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        arguments.isFullScreen
                            ? Flexible(
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      model.categoriesResponse!.types!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: getValueForScreenType(
                                      context: context,
                                      mobile: 1,
                                      tablet: arguments.isFullScreen ? 4 : 2,
                                      desktop: arguments.isFullScreen ? 5 : 2,
                                    ),
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 2.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleCategoryItemWidget(
                                        item: model.categoriesResponse!.types!
                                            .elementAt(
                                          index,
                                        ),
                                        onItemClicked: (
                                            {required String selectedItem}) {
                                          model.takeToProductListView(
                                            selectedCategory: selectedItem,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            : model.categoriesResponse != null ||
                                    model.categoriesResponse!.types != null
                                ? SizedBox(
                                    height: Dimens().popularCategoryHeight - 50,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ListView.builder(
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SinglePopularBrandItem(
                                              item: model
                                                  .categoriesResponse!.types!
                                                  .elementAt(
                                                index,
                                              ),
                                              onItemClicked: (
                                                  {required String
                                                      selectedItem}) {
                                                print('$selectedItem clicked');
                                              },
                                            ),
                                          ),
                                          itemCount: model.categoriesResponse!
                                              .types!.length,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                        Positioned(
                                          left: 0,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_left,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                        if (arguments.isFullScreen)
                          ListFooter.firstPreviousNextLast(
                            pageNumber: model.pageIndex,
                            totalPages:
                                model.categoriesResponse!.totalItems == null
                                    ? 0
                                    : model.categoriesResponse!.totalPages! - 1,
                            onPreviousPageClick: () {
                              model.pageIndex--;
                              model.getAllCategories();
                            },
                            onNextPageClick: () {
                              model.pageIndex++;
                              model.getAllCategories();
                            },
                            onFirstPageClick: () {
                              model.pageIndex = 0;
                              model.getAllCategories();
                            },
                            onLastPageClick: () {
                              model.pageIndex =
                                  model.categoriesResponse!.totalPages == null
                                      ? 0
                                      : model.categoriesResponse!.totalPages! -
                                          1;
                              model.getAllCategories();
                            },
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        viewModelBuilder: () => PopularCategoriesViewModel(),
      ),
    );
  }
}

class PopularCategoriesViewArgs {
  const PopularCategoriesViewArgs({
    this.isSupplierCatalog = false,
  })  : isFullScreen = true,
        supplierId = null,
        supplierName = null;

  PopularCategoriesViewArgs.demanderPopularBrands({
    required this.supplierId,
    required this.supplierName,
  })  : isFullScreen = true,
        isSupplierCatalog = false;

  final bool isFullScreen;
  final bool isSupplierCatalog;
  final int? supplierId;
  final String? supplierName;
}

class SinglePopularBrandItem extends StatelessWidget {
  const SinglePopularBrandItem({
    Key? key,
    required this.onItemClicked,
    required this.item,
  }) : super(key: key);

  final Function({required String selectedItem}) onItemClicked;
  final String item;

  @override
  Widget build(BuildContext context) {
    double width = getValueForScreenType(
      context: context,
      mobile: 150,
      tablet: 250,
      desktop: 250,
    );
    return SizedBox(
      width: width,
      child: AppInkwell.withBorder(
        onTap: () => onItemClicked(selectedItem: item),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(4),
              child: Text(
                item,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
