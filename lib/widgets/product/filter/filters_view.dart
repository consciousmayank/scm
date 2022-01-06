import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/product/filter/filters_viewmodel.dart';
import 'package:scm/widgets/product/filter/simple_search_widget.dart';
import 'package:stacked/stacked.dart';

class ProductsFilterView extends StatefulWidget {
  const ProductsFilterView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductsFilterViewArguments arguments;

  @override
  _ProductsFilterViewState createState() => _ProductsFilterViewState();
}

class _ProductsFilterViewState extends State<ProductsFilterView> {
  Widget buildFilterTypesAndValues({
    required ProductsFilterViewModel viewModel,
    required BuildContext context,
  }) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Filter Types UI
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors().white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildFiltersTypeTitle(
                    context: context,
                    filterCount: viewModel.tempCheckedBrandsList.length,
                    filterTypeTitle: 'Brand',
                    viewModel: viewModel,
                    showFilterIndicator:
                        widget.arguments.selectedBrand!.isNotEmpty
                            ? true
                            : false,
                  ),
                  buildFiltersTypeTitle(
                    context: context,
                    filterCount: viewModel.tempCheckedCategoriesList.length,
                    filterTypeTitle: 'Category',
                    viewModel: viewModel,
                    showFilterIndicator:
                        widget.arguments.selectedCategory!.isNotEmpty
                            ? true
                            : false,
                  ),
                  buildFiltersTypeTitle(
                    context: context,
                    filterCount: viewModel.tempCheckedSubCategoriesList.length,
                    filterTypeTitle: 'Sub-Category',
                    viewModel: viewModel,
                    showFilterIndicator:
                        widget.arguments.selectedSuCategory!.isNotEmpty
                            ? true
                            : false,
                  ),
                ],
              ),
            ),
          ),

          /// Filter Type Values or Sub-Types UI

          if (viewModel.clickedFilter == 'Brand')
            Expanded(
              flex: 5,
              child: viewModel.isBusy
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Loading Brands...'),
                          hSizedBox(
                            height: 10,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SimpleSearchWidget.innerHint(
                          searchTerm: viewModel.brandTitle,
                          onSearchTermCleared: () {
                            viewModel.brandTitle = null;
                            viewModel.getBrandsList(showLoader: true);
                          },
                          onSearchTermEntered: ({required String searchTerm}) {
                            if (searchTerm.length > 2) {
                              viewModel.brandTitle = searchTerm;
                              viewModel.getBrandsList(
                                showLoader: true,
                              );
                            }
                          },
                          innerHintText: labelSearchBrands,
                        ),
                        Text(
                          'Total Brands: ${viewModel.totalItemsForBrandsApi.toString()}',
                          // style: AppTextStyles.robotoMedium10PrimaryShade5
                          //     .copyWith(
                          //   fontSize: 14,
                          // ),
                        ),
                        Expanded(
                          child: LazyLoadScrollView(
                            scrollOffset:
                                (MediaQuery.of(context).size.height ~/ 6),
                            onEndOfPage: () => viewModel.getBrandsList(
                              showLoader: false,
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) =>
                                  buildFilterTypeValues(
                                context: context,
                                value: viewModel
                                    .brandsForFilterList[index].isSelected,
                                onChanged: (value) {
                                  viewModel.brandsForFilterList[index]
                                      .isSelected = value;

                                  /// adding checked Brands to [checkedBrandsList]
                                  /// later it will be sent to bring the filtered products list

                                  if (value == true) {
                                    /// on check of checkbox, add the list item to checkedBrandList

                                    viewModel.tempCheckedBrandsList.add(
                                        viewModel.brandsForFilterList[index]
                                            .brandName);
                                    viewModel.checkBrandsAndMoveToTop();
                                  } else {
                                    /// on uncheck of checkbox, remove the list item to checkedBrandList

                                    viewModel.tempCheckedBrandsList
                                        .removeWhere((element) {
                                      return element ==
                                          viewModel.brandsForFilterList[index]
                                              .brandName;
                                    });
                                  }

                                  viewModel.notifyListeners();
                                },
                                text: viewModel
                                    .brandsForFilterList[index].brandName,
                              ),
                              itemCount: viewModel.brandsForFilterList.length,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          if (viewModel.clickedFilter == 'Category')
            Expanded(
              flex: 5,
              child: viewModel.isBusy
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Loading Categories...'),
                          hSizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          SimpleSearchWidget.innerHint(
                            searchTerm: viewModel.categoryTitle,
                            onSearchTermCleared: () {
                              viewModel.categoryTitle = null;
                              viewModel.getProductCategoriesList(
                                  showLoader: true);
                            },
                            onSearchTermEntered: (
                                {required String searchTerm}) {
                              if (searchTerm.length > 2) {
                                viewModel.categoryTitle = searchTerm;
                                viewModel.getProductCategoriesList(
                                  showLoader: true,
                                );
                              }
                            },
                            innerHintText: labelSearchCategory,
                          ),
                          Text(
                            'Total Categories: ${viewModel.totalItemsForCategoriesApi.toString()}',
                            // style: AppTextStyles.robotoMedium10PrimaryShade5
                            //     .copyWith(
                            //   fontSize: 14,
                            // ),
                          ),
                          Expanded(
                            child: LazyLoadScrollView(
                              scrollOffset:
                                  (MediaQuery.of(context).size.height ~/ 6),
                              onEndOfPage: () =>
                                  viewModel.getProductCategoriesList(
                                showLoader: false,
                              ),
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    buildFilterTypeValues(
                                  context: context,
                                  text: viewModel.categoriesForFilterList[index]
                                      .categoryName,
                                  value: viewModel
                                      .categoriesForFilterList[index]
                                      .isSelected,
                                  onChanged: (value) {
                                    viewModel.categoriesForFilterList[index]
                                        .isSelected = value;

                                    /// adding checked Categories to [checkedCategoriesList]
                                    /// later it will be sent to bring the filtered products list

                                    if (value == true) {
                                      viewModel.tempCheckedCategoriesList.add(
                                          viewModel
                                              .categoriesForFilterList[index]
                                              .categoryName!);
                                      viewModel.checkCategoriesAndMoveToTop();
                                    } else {
                                      viewModel.tempCheckedCategoriesList
                                          .removeWhere(
                                        (element) =>
                                            element ==
                                            viewModel
                                                .categoriesForFilterList[index]
                                                .categoryName,
                                      );
                                    }
                                    viewModel.notifyListeners();
                                  },
                                ),
                                itemCount:
                                    viewModel.categoriesForFilterList.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          if (viewModel.clickedFilter == 'Sub-Category')
            Expanded(
              flex: 5,
              child: viewModel.isBusy
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Loading Sub-Categories...'),
                          hSizedBox(
                            height: 10,
                          ),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : Container(
                      child: (viewModel.tempCheckedCategoriesList.isNotEmpty)
                          ? Column(
                              children: [
                                SimpleSearchWidget.innerHint(
                                  searchTerm: viewModel.subCategoryTitle,
                                  onSearchTermCleared: () {
                                    viewModel.subCategoryTitle = null;
                                    viewModel.getProductsSubCategoriesList(
                                        showLoader: true);
                                  },
                                  onSearchTermEntered: (
                                      {required String searchTerm}) {
                                    if (searchTerm.length > 2) {
                                      viewModel.subCategoryTitle = searchTerm;
                                      viewModel.getProductsSubCategoriesList(
                                        showLoader: true,
                                      );
                                    }
                                  },
                                  innerHintText: labelSearchSubCategory,
                                ),
                                Text(
                                  'Total Sub-Categories: ${viewModel.totalItemsForSubCategoriesApi.toString()}',
                                  // style: AppTextStyles
                                  //     .robotoMedium10PrimaryShade5
                                  //     .copyWith(
                                  //   fontSize: 14,
                                  // ),
                                ),
                                Expanded(
                                  child: LazyLoadScrollView(
                                    scrollOffset:
                                        (MediaQuery.of(context).size.height ~/
                                            6),
                                    onEndOfPage: () =>
                                        viewModel.getProductsSubCategoriesList(
                                      showLoader: false,
                                    ),
                                    child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          buildFilterTypeValues(
                                        context: context,
                                        text: viewModel
                                            .subCategoriesForFilterList[index]
                                            .subCategoryName,
                                        value: viewModel
                                            .subCategoriesForFilterList[index]
                                            .isSelected,
                                        onChanged: (value) {
                                          viewModel
                                              .subCategoriesForFilterList[index]
                                              .isSelected = value;

                                          /// adding checked Sub - Categories to [checkedSubCategoriesList]
                                          /// later it will be sent to bring the filtered products list

                                          // viewModel.s
                                          if (value == true) {
                                            // viewModel.checkedSubCategoriesList.add(
                                            //     viewModel
                                            //         .subCategoriesForFilterList[index]
                                            //         .subCategoryName!);
                                            viewModel
                                                .tempCheckedSubCategoriesList
                                                .add(viewModel
                                                    .subCategoriesForFilterList[
                                                        index]
                                                    .subCategoryName!);

                                            viewModel
                                                .checkSubCategoriesAndMoveToTop();
                                          } else {
                                            // viewModel.checkedSubCategoriesList
                                            //     .removeWhere((element) =>
                                            //         element ==
                                            //         viewModel
                                            //             .subCategoriesForFilterList[
                                            //                 index]
                                            //             .subCategoryName);
                                            viewModel
                                                .tempCheckedSubCategoriesList
                                                .removeWhere((element) =>
                                                    element ==
                                                    viewModel
                                                        .subCategoriesForFilterList[
                                                            index]
                                                        .subCategoryName);
                                          }
                                          viewModel.notifyListeners();
                                        },
                                      ),
                                      itemCount: viewModel
                                          .subCategoriesForFilterList.length,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 6,
                              ),
                              child: Text(
                                  'Please select a CATEGORY to see SUB-CATEGORIES'),
                            ),
                    ),
            ),
        ],
      ),
    );
  }

  Widget buildFilterTypeValues({
    required bool? value,
    required String? text,
    required void Function(bool?)? onChanged,
    required BuildContext context,
  }) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: NullableTextWidget(
        stringValue: text,
        // text!.toLowerCase(),
        textStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: value == true
                  ? Theme.of(context).colorScheme.secondaryVariant
                  : AppColors().black,
            ),
      ),
    );

    // Row(
    //   children: [
    //     Checkbox(
    //       value: value,
    //       onChanged: onChanged,
    //     ),
    //     // wSizedBox(5),
    //     NullableTextWidget(
    //       text: text,
    //       // text!.toLowerCase(),
    //       textStyle: Theme.of(context).textTheme.subtitle2,
    //     )
    //   ],
    // );
  }

  Widget buildFiltersTypeTitle({
    required String? filterTypeTitle,
    required ProductsFilterViewModel? viewModel,
    required bool? showFilterIndicator,
    required int? filterCount,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: viewModel!.clickedFilter != filterTypeTitle
            ? AppColors().white
            : Theme.of(context).colorScheme.secondaryVariant,
        borderRadius: BorderRadius.circular(Dimens().defaultBorder),
        // border: Border(
        //   bottom: BorderSide(
        //     color: AppColors.primaryColor,
        //     width: 1,
        //   ),
        // ),
      ),
      child: InkWell(
        onTap:

            /// if already selected filter type is clicked
            /// then passing [null] to function onTap
            viewModel.clickedFilter == filterTypeTitle
                ? null
                : () {
                    viewModel.clickedFilter = filterTypeTitle;

                    //todo: use enums later
                    if (filterTypeTitle!.toLowerCase() == 'brand') {
                      /// if [Brand] is clicked on the left pane
                      /// hit the brands list api
                      viewModel.getBrandsList(showLoader: true);
                    } else if (filterTypeTitle.toLowerCase() == 'category') {
                      /// if [Category] is clicked on the left pane
                      /// hit the categories list api
                      viewModel.getProductCategoriesList(showLoader: true);
                    } else if (filterTypeTitle.toLowerCase() ==
                        'sub-category') {
                      /// if [Sub - Category] is clicked on the left pane
                      /// hit the sub-categories list api
                      viewModel.getProductsSubCategoriesList(showLoader: true);
                    }
                  },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filterTypeTitle!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: viewModel.clickedFilter == filterTypeTitle
                        ? AppColors().white
                        : AppColors().black),
              ),
              if (filterCount! > 0)
                wSizedBox(
                  width: 5,
                ),
              if (filterCount > 0)
                Text(
                  filterCount.toString(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: viewModel.clickedFilter == filterTypeTitle
                          ? AppColors().white
                          : AppColors().black),
                )
              // Text(viewModel.check)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClearAndApplyButtons({
    ProductsFilterViewModel? viewModel,
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: Dimens().buttonHeight,
              child: TextButton(
                  style: AppTextButtonsStyles(
                    context: context,
                  ).textButtonStyle,
                  onPressed: () {
                    viewModel?.unCheckAllFilters();
                    viewModel?.tempCheckedBrandsList.clear();
                    viewModel?.tempCheckedCategoriesList.clear();
                    viewModel?.tempCheckedSubCategoriesList.clear();
                  },
                  child: const Text('Clear All')),
            ),
          ),
          wSizedBox(width: 4),
          Expanded(
            child: SizedBox(
              height: Dimens().buttonHeight,
              child: TextButton(
                onPressed: () {
                  widget.arguments
                      .onApplyFilterButtonClicked(
                        outArgs: ProductsFilterViewOutputArguments(
                          checkedBrands: viewModel?.tempCheckedBrandsList,
                          checkedCategories:
                              viewModel?.tempCheckedCategoriesList,
                          checkedSubCategories:
                              viewModel?.tempCheckedSubCategoriesList,
                        ),
                      )
                      .call();
                },
                child: const Text(
                  'Apply',
                ),
                style: AppTextButtonsStyles(
                  context: context,
                ).textButtonStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheetTitle({
    required String text,
    IconData? icon,
  }) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        wSizedBox(
          width: 4,
        ),
        Icon(icon),
        // Icon(Icons.filter_list_alt),
        wSizedBox(
          width: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.left,
          // style: AppTextStyles.robotoBold18Black,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsFilterViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            // buildBottomSheetHeader(),
            buildFilterTypesAndValues(
              viewModel: model,
              context: context,
            ),
            buildClearAndApplyButtons(
              context: context,
              viewModel: model,
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ProductsFilterViewModel(),
    );
  }
}

class ProductsFilterViewArguments {
  ProductsFilterViewArguments({
    required this.selectedBrand,
    required this.selectedCategory,
    required this.selectedSuCategory,
    required this.searchProductTitle,
    required this.onApplyFilterButtonClicked,
    required this.onCancelButtonClicked,
    required this.supplierId,
  });

  final Function({
    required ProductsFilterViewOutputArguments outArgs,
  }) onApplyFilterButtonClicked;

  final Function onCancelButtonClicked;
  final String? searchProductTitle;
  final List<String?>? selectedBrand;
  final List<String?>? selectedCategory;
  final List<String?>? selectedSuCategory;
  final int? supplierId;
}

class ProductsFilterViewOutputArguments {
  ProductsFilterViewOutputArguments({
    this.checkedBrands,
    this.checkedCategories,
    this.checkedSubCategories,
  });

  final List<String?>? checkedBrands;
  final List<String?>? checkedCategories;
  final List<String?>? checkedSubCategories;
}
