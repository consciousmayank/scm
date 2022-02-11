import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';

import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/brands_for_filter.dart';
import 'package:scm/model_classes/categories_for_filter.dart';
import 'package:scm/model_classes/products_brands_response.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/services/app_api_service_classes/product_brands_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/product_sub_categories_apis.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/product/filter/filters_view.dart';

const String brandsBusyObjectKey = 'my-busy-key-brands';
const String categorySizesBusyObjectKey = 'my-busy-key-category';
const String subCategoryBusyObjectKey = 'my-busy-key-subCategory';

class ProductsFilterViewModel extends GeneralisedBaseViewModel {
  late final ProductsFilterViewArguments args;

  /// it is used to store which [filter] item [Brand, Category, Sub-Category] is clicked
  /// in the left pane of the filter bottom sheet
  String? clickedFilter = 'Brand';
  int selectedFilterView = 0;

  int? pageIndexForBrandsApi = 0;
  int? pageIndexForCategoriesApi = 0;
  int? pageIndexForSubCategoriesApi = 0;
  TextEditingController searchBrandsTextController = TextEditingController();
  TextEditingController searchCategoriesTextController =
      TextEditingController();

  TextEditingController searchSubCategoriesTextController =
      TextEditingController();

  int? totalItemsForBrandsApi = 0;
  int? totalItemsForCategoriesApi = 0;
  int? totalItemsForSubCategoriesApi = 0;

  String? _brandTitle;
  final ProductBrandsApis _brandsApis = locator<ProductBrandsApiImpl>();
  List<BrandsForFilter>? _brandsForFilterList = [];
  List<Brand>? _brandsList;
  ProductBrandsResponse? _brandsResponse;
  List<CategoriesForFilter>? _categoriesForFilterList = [];
  SuppliersTypesListResponse? _categoriesResponse;
  String? _categoryTitle;
  List<Brand?>? _checkedBrandsList = [];
  List<Type?>? _checkedCategoriesList = [];
  List<SubType?>? _checkedSubCategoriesList = [];
  final ProductCategoriesApis _productCategoriesApis =
      locator<ProductCategoriesApiImpl>();

  List<Type>? _productCategoriesList;
  final ProductSubCategoriesApis _subCategoriesApis =
      locator<ProductSubCategoriesApisImpl>();

  List<SubCategoriesForFilter>? _subCategoriesForFilterList = [];
  List<SubType>? _subCategoriesList;
  SuppliersSubTypesListResponse? _subCategoriesResponse;
  String? _subCategoryTitle;
  List<Brand?>? _tempCheckedBrandsList = [];
  List<Type?>? _tempCheckedCategoriesList = [];
  List<SubType?>? _tempCheckedSubCategoriesList = [];

  init({required ProductsFilterViewArguments args}) {
    this.args = args;
    populatingCheckedList();
    getBrandsList(showLoader: true);
    getProductCategoriesList(showLoader: true);
    getProductsSubCategoriesList(showLoader: true);
  }

  List<SubType?> get checkedSubCategoriesList => _checkedSubCategoriesList!;

  List<SubType?> get tempCheckedSubCategoriesList =>
      _tempCheckedSubCategoriesList!;

  set checkedSubCategoriesList(List<SubType?>? value) {
    _checkedSubCategoriesList = value;
  }

  set tempCheckedSubCategoriesList(List<SubType?>? value) {
    _tempCheckedSubCategoriesList = value;
  }

  // Set<String> ? _checkedBrandsSet;

  List<Brand?> get checkedBrandsList => _checkedBrandsList!;

  List<Brand?> get tempCheckedBrandsList => _tempCheckedBrandsList!;

  set checkedBrandsList(List<Brand?>? value) {
    _checkedBrandsList = value;
    notifyListeners();
  }

  set tempCheckedBrandsList(List<Brand?>? value) {
    _tempCheckedBrandsList = value;
    notifyListeners();
  }

  List<Type?> get checkedCategoriesList => _checkedCategoriesList!;

  List<Type?> get tempCheckedCategoriesList => _tempCheckedCategoriesList!;

  set checkedCategoriesList(List<Type?>? value) {
    _checkedCategoriesList = value;
    notifyListeners();
  }

  set tempCheckedCategoriesList(List<Type?>? value) {
    _tempCheckedCategoriesList = value;
    notifyListeners();
  }

  List<SubCategoriesForFilter> get subCategoriesForFilterList =>
      _subCategoriesForFilterList!;

  set subCategoriesForFilterList(List<SubCategoriesForFilter>? value) {
    _subCategoriesForFilterList = value;
    notifyListeners();
  }

  List<BrandsForFilter> get brandsForFilterList => _brandsForFilterList!;

  set brandsForFilterList(List<BrandsForFilter>? value) {
    _brandsForFilterList = value;
    notifyListeners();
  }

  List<CategoriesForFilter> get categoriesForFilterList =>
      _categoriesForFilterList!;

  set categoriesForFilterList(List<CategoriesForFilter>? value) {
    _categoriesForFilterList = value;
    notifyListeners();
  }

  /// clear/ uncheck all the applied filters
  unCheckAllFilters() {
    for (var element in brandsForFilterList) {
      element.isSelected = false;
    }
    for (var element in categoriesForFilterList) {
      element.isSelected = false;
    }
    for (var element in subCategoriesForFilterList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  ProductBrandsResponse? get brandsResponse => _brandsResponse;

  set brandsResponse(ProductBrandsResponse? value) {
    _brandsResponse = value;
    notifyListeners();
  }

  List<Brand> get brandsList => _brandsList!;

  set brandsList(List<Brand>? value) {
    _brandsList = value;
    notifyListeners();
  }

  String? get brandTitle => _brandTitle;

  set brandTitle(String? value) {
    _brandTitle = value;
    notifyListeners();
  }

  getBrandsList({
    bool showLoader = false,
  }) async {
    if (showLoader) {
      pageIndexForBrandsApi = 0;
      brandsList = [];
      brandsForFilterList = [];
    }

    if (totalItemsForBrandsApi! > brandsList.length ||
        pageIndexForBrandsApi == 0) {
      /// if [checkedTypesList] is not empty then hit the brand by types api
      /// otherwise hit all brands api

      brandsResponse = await runBusyFuture(
        _brandsApis.getBrandsList(
          pageIndex: pageIndexForBrandsApi,
          brandTitle: brandTitle,
          checkedCategoryFilterList:
              tempCheckedCategoriesList.map((e) => e!.type).toList(),
          checkedSubCategoryFilterList:
              tempCheckedSubCategoriesList.map((e) => e?.subType).toList(),
          productTitle: args.searchProductTitle,
          supplierId: args.supplierId,
          isSupplierCatalog: args.isSupplierCatalog,
        ),
        busyObject: showLoader ? brandsBusyObjectKey : null,
      );

      totalItemsForBrandsApi = brandsResponse?.totalItems;
      if (showLoader) {
        brandsList = copyList(brandsResponse?.brands);
      } else {
        brandsList.addAll(brandsResponse?.brands ?? []);
        // makeBrandListCheckable(apiResponseBrandList: brandsList);
      }

      makeBrandListCheckable(
        apiResponseBrandList: copyList(brandsResponse?.brands!),
      );
      pageIndexForBrandsApi = pageIndexForBrandsApi! + 1;
    }
  }

  /// the coming brand list is of type [String] so below
  /// it is converted into objects to give it [isSelected] property
  void makeBrandListCheckable({required List<Brand>? apiResponseBrandList}) {
    apiResponseBrandList?.forEach((element) {
      brandsForFilterList.add(
        BrandsForFilter(
          brandName: element.brand,
          isSelected: false,
          count: element.count ?? 0,
        ),
      );
    });

    if (args.selectedBrand != null) {
      brandsForFilterList = addPreSelectedBrandsToFilterList(
        brandsForFilterList: brandsForFilterList,
        // args: args,
        filterApiList: brandsList,
      );
    }

    /// check the already checked brands in filter list (while switching filters)

    for (int i = 0; i < brandsForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedBrandsList.length; j++) {
        if (brandsForFilterList[i].brandName ==
            tempCheckedBrandsList[j]?.brand) {
          brandsForFilterList[i].isSelected = true;
        }
      }
    }

    /// removing the duplicate values from brandsForFilterList
    /// used when a checked item comes in later pages from api
    brandsForFilterList.sort((a, b) => a.brandName!.compareTo(b.brandName!));
    for (int i = 0; i < brandsForFilterList.length; i++) {
      for (int j = i + 1; j < brandsForFilterList.length; j++) {
        if (brandsForFilterList[i].brandName ==
            brandsForFilterList[j].brandName) {
          brandsForFilterList.removeAt(i);
        }
      }
    }

    /// move checked item at the beginning of list
    brandsForFilterList =
        moveCheckedBrandFiltersAtBeginning(filterList: brandsForFilterList);
  }

  /// check the items in [brandsForFilterList] which are present in [tempCheckedBrandsList]
  /// move checkedBrands at top in UI
  void checkBrandsAndMoveToTop() {
    //todo: later
    /// add the items to brandForFilterList which are (present in
    /// [tempCheckedBrandsList] but missing in  [brandsForFilterList]

    for (int i = 0; i < brandsForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedBrandsList.length; j++) {
        if (brandsForFilterList[i].brandName ==
            tempCheckedBrandsList[j]?.brand) {
          brandsForFilterList[i].isSelected = true;
        }
      }
    }

    /// move checked item at the beginning of list
    brandsForFilterList =
        moveCheckedBrandFiltersAtBeginning(filterList: brandsForFilterList);
    notifyListeners();
  }

  /// check if the argumentsBrandFilter list contains those brand which are not
  /// in filterList(api based) because it can be in 2nd page or 3rd page of api
  /// if not present, add them
  List<BrandsForFilter>? addPreSelectedBrandsToFilterList({
    required List<BrandsForFilter>? brandsForFilterList,
    // required argss? args,
    required List<Brand>? filterApiList,
  }) {
    filterApiList = filterApiList?.toSet().toList();
    for (var element in tempCheckedBrandsList) {
      if (!filterApiList!.contains(element)) {
        brandsForFilterList?.add(
          BrandsForFilter(
            brandName: element?.brand,
            isSelected: true,
            count: element?.count ?? 0,
          ),
        );
      }
    }

    return brandsForFilterList?.toSet().toList();
  }

  /// check if the argumentsCategoryFilter list contains those brand which are not
  /// in filterList(api based) because it can be in 2nd page or 3rd page of api
  /// if not present add them
  List<CategoriesForFilter>? addPreSelectedCategoriesToFilterList({
    required List<CategoriesForFilter>? categoriesForFilterList,
    required ProductsFilterViewArguments? args,
    required List<Type>? filterApiList,
  }) {
    filterApiList = filterApiList?.toSet().toList();
    for (var element in tempCheckedCategoriesList) {
      if (!filterApiList!.contains(element)) {
        categoriesForFilterList?.add(
          CategoriesForFilter(
            categoryName: element?.type,
            isSelected: true,
            count: element?.count ?? 0,
          ),
        );
      }
    }

    return categoriesForFilterList?.toSet().toList();
  }

  List<BrandsForFilter> moveCheckedBrandFiltersAtBeginning(
      {List<BrandsForFilter>? filterList}) {
    List<BrandsForFilter> checkedFilterList =
        filterList!.where((element) => element.isSelected == true).toList();

    filterList.insertAll(0, checkedFilterList);

    return filterList.toSet().toList();
  }

  List<CategoriesForFilter> moveCheckedCategoriesFiltersAtBeginning(
      {List<CategoriesForFilter>? filterList}) {
    List<CategoriesForFilter> checkedFilterList =
        filterList!.where((element) => element.isSelected == true).toList();

    filterList.insertAll(0, checkedFilterList);

    return filterList.toSet().toList();
  }

  List<SubCategoriesForFilter> moveCheckedSubCategoriesFiltersAtBeginning(
      {List<SubCategoriesForFilter>? filterList}) {
    List<SubCategoriesForFilter> checkedFilterList =
        filterList!.where((element) => element.isSelected == true).toList();

    filterList.insertAll(0, checkedFilterList);

    return filterList.toSet().toList();
  }

  List<Type> get productCategoriesList => _productCategoriesList!;

  set productCategoriesList(List<Type> value) {
    _productCategoriesList = value;
    notifyListeners();
  }

  SuppliersTypesListResponse? get categoriesResponse => _categoriesResponse;

  set categoriesResponse(SuppliersTypesListResponse? value) {
    _categoriesResponse = value;
    notifyListeners();
  }

  /// populating the checkedFilterList
  populatingCheckedList() {
    if (args.selectedCategory != null) {
      args.selectedCategory?.forEach((element) {
        checkedCategoriesList.add(
          Type(
            type: element?.type ?? '',
            count: element?.count ?? 0,
          ),
        );
        tempCheckedCategoriesList.add(
          Type(
            type: element?.type ?? '',
            count: element?.count ?? 0,
          ),
        );
      });
    }
    if (args.selectedBrand != null) {
      args.selectedBrand?.forEach((element) {
        checkedBrandsList.add(element);
        tempCheckedBrandsList.add(
          Brand(
            brand: element?.brand ?? '',
            count: element?.count ?? 0,
          ),
        );
      });
    }
    if (args.selectedSuCategory != null) {
      args.selectedSuCategory?.forEach((element) {
        checkedSubCategoriesList.add(element);
        tempCheckedSubCategoriesList.add(
          SubType(
            subType: element?.subType ?? '',
            count: element?.count ?? 0,
          ),
        );
      });
    }
  }

  String? get categoryTitle => _categoryTitle;

  set categoryTitle(String? value) {
    _categoryTitle = value;
    notifyListeners();
  }

  getProductCategoriesList({
    bool showLoader = false,
  }) async {
    if (showLoader) {
      pageIndexForCategoriesApi = 0;
      productCategoriesList = [];
      categoriesForFilterList = [];
    }

    if (totalItemsForCategoriesApi! > productCategoriesList.length ||
        pageIndexForCategoriesApi == 0) {
      /// if [checkedBrandList] is not empty then hit the types by brand api otherwise hit all types api

      categoriesResponse = await runBusyFuture(
        _productCategoriesApis.getProductCategoriesList(
          pageIndex: pageIndexForCategoriesApi,
          checkedBrandList: tempCheckedBrandsList.map((e) => e!.brand).toList(),
          checkedSubCategoriesList:
              tempCheckedSubCategoriesList.map((e) => e?.subType).toList(),
          categoryTitle: categoryTitle,
          productTitle: args.searchProductTitle,
          supplierId: args.supplierId,
          isSupplierCatalog: args.isSupplierCatalog,
        ),
        busyObject: showLoader ? categorySizesBusyObjectKey : null,
      );

      totalItemsForCategoriesApi = categoriesResponse?.totalItems;
      if (showLoader) {
        productCategoriesList = copyList(categoriesResponse?.types);
      } else {
        productCategoriesList.addAll(categoriesResponse?.types ?? []);
        // makeCategoriesListCheckable(tempCategoriesList: productCategoriesList);
      }
      makeCategoriesListCheckable(
        apiResponseCategoriesList: copyList(categoriesResponse?.types),
      );
      pageIndexForCategoriesApi = pageIndexForCategoriesApi! + 1;
    }
  }

  /// the coming category list is of type [String] so below it is
  /// converted into objects to give it [isSelected] property

  void makeCategoriesListCheckable(
      {required List<Type>? apiResponseCategoriesList}) {
    /// making categories list checkable
    for (var element in apiResponseCategoriesList!) {
      categoriesForFilterList.add(CategoriesForFilter(
        categoryName: element.type,
        isSelected: false,
        count: element.count ?? 0,
      ));
    }

    if (args.selectedCategory != null) {
      categoriesForFilterList = addPreSelectedCategoriesToFilterList(
        categoriesForFilterList: categoriesForFilterList,
        args: args,
        filterApiList: productCategoriesList,
      );
    }

    /// check the already checked categories in filter list (used while switching filters)

    for (int i = 0; i < categoriesForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedCategoriesList.length; j++) {
        if (categoriesForFilterList[i].categoryName ==
            tempCheckedCategoriesList[j]?.type) {
          categoriesForFilterList[i].isSelected = true;
        }
      }
    }

    /// removing the duplicate values from categoriesForFilterList
    /// used when a checked item comes in later pages from api
    categoriesForFilterList
        .sort((a, b) => a.categoryName!.compareTo(b.categoryName!));
    for (int i = 0; i < categoriesForFilterList.length; i++) {
      for (int j = i + 1; j < categoriesForFilterList.length; j++) {
        if (categoriesForFilterList[i].categoryName ==
            categoriesForFilterList[j].categoryName) {
          categoriesForFilterList.removeAt(i);
        }
      }
    }

    /// move checked item at the beginning of list
    categoriesForFilterList = moveCheckedCategoriesFiltersAtBeginning(
        filterList: categoriesForFilterList);
  }

  /// check the items in [categoriesForFilterList] which are present in [tempCheckedCategoriesList]
  /// move checkedBrands at top in UI
  void checkCategoriesAndMoveToTop() {
    //todo: later
    /// add the items to [categoriesForFilterList] which are (present in
    /// [tempCheckedCategoriesList] but missing in  [categoriesForFilterList]
    for (int i = 0; i < categoriesForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedCategoriesList.length; j++) {
        if (categoriesForFilterList[i].categoryName ==
            tempCheckedCategoriesList[j]?.type) {
          categoriesForFilterList[i].isSelected = true;
        }
      }
    }

    /// move checked item at the beginning of list
    categoriesForFilterList = moveCheckedCategoriesFiltersAtBeginning(
        filterList: categoriesForFilterList);
  }

  List<SubType> get subCategoriesList => _subCategoriesList!;

  set subCategoriesList(List<SubType> value) {
    _subCategoriesList = value;
    notifyListeners();
  }

  SuppliersSubTypesListResponse get subCategoriesResponse =>
      _subCategoriesResponse!;

  set subCategoriesResponse(SuppliersSubTypesListResponse value) {
    _subCategoriesResponse = value;
  }

  String? get subCategoryTitle => _subCategoryTitle;

  set subCategoryTitle(String? value) {
    _subCategoryTitle = value;
    notifyListeners();
  }

  getProductsSubCategoriesList({
    bool showLoader = false,
  }) async {
    if (showLoader) {
      pageIndexForSubCategoriesApi = 0;
      subCategoriesList = [];
      subCategoriesForFilterList = [];
    }

    if (totalItemsForSubCategoriesApi! > subCategoriesList.length ||
        pageIndexForSubCategoriesApi == 0) {
      subCategoriesResponse = await runBusyFuture(
        _subCategoriesApis.getProductSubCategoriesList(
          pageSize: 30,
          pageIndex: pageIndexForSubCategoriesApi,
          subCategoryTitle: subCategoryTitle,
          checkedCategoryList:
              tempCheckedCategoriesList.map((e) => e?.type).toList(),
          checkedBrandList: tempCheckedBrandsList.map((e) => e!.brand).toList(),
          productTitle: args.searchProductTitle,
          supplierId: args.supplierId,
          isSupplierCatalog: args.isSupplierCatalog,
        ),
        busyObject: showLoader ? subCategoryBusyObjectKey : null,
      );

      totalItemsForSubCategoriesApi = subCategoriesResponse.totalItems;
      if (showLoader) {
        subCategoriesList = copyList(subCategoriesResponse.subTypes!);
      } else {
        subCategoriesList.addAll(subCategoriesResponse.subTypes!);
      }
      makeSubCategoriesListCheckable(
        apiResponseSubCategoriesList: copyList(subCategoriesResponse.subTypes),
      );
      pageIndexForSubCategoriesApi = pageIndexForSubCategoriesApi! + 1;
    }
  }

  /// the coming (from api) subCategories list is of type [String] so below
  /// it is converted into objects to give it [isSelected] property
  void makeSubCategoriesListCheckable(
      {required List<SubType>? apiResponseSubCategoriesList}) {
    /// making sub categories list checkable
    for (var element in apiResponseSubCategoriesList!) {
      subCategoriesForFilterList.add(
        SubCategoriesForFilter(
            subCategoryName: element.subType,
            isSelected: false,
            count: element.count ?? 0),
      );
    }

    if (args.selectedCategory != null) {
      subCategoriesForFilterList = addPreSelectedSubCategoriesToFilterList(
        subCategoriesForFilterList: subCategoriesForFilterList,
        // args: args,
        filterApiList: subCategoriesList,
      );
    }

    /// check the already checked brands in filter list (used while switching filters)
    for (int i = 0; i < subCategoriesForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedSubCategoriesList.length; j++) {
        if (subCategoriesForFilterList[i].subCategoryName ==
            tempCheckedSubCategoriesList[j]?.subType) {
          subCategoriesForFilterList[i].isSelected = true;
        }
      }
    }

    /// removing the duplicate values from brandsForFilterList
    /// used when a checked item comes in later pages from api

    subCategoriesForFilterList
        .sort((a, b) => a.subCategoryName!.compareTo(b.subCategoryName!));
    for (int i = 0; i < subCategoriesForFilterList.length; i++) {
      for (int j = i + 1; j < subCategoriesForFilterList.length; j++) {
        if (subCategoriesForFilterList[i].subCategoryName ==
            subCategoriesForFilterList[j].subCategoryName) {
          subCategoriesForFilterList.removeAt(i);
        }
      }
    }

    /// move checked item at the beginning of list
    subCategoriesForFilterList = moveCheckedSubCategoriesFiltersAtBeginning(
        filterList: subCategoriesForFilterList);
  }

  /// check the items in [subCategoriesForFilterList] which are present in [tempCheckedSubCategoriesList]
  /// move checkedBrands at top in UI
  void checkSubCategoriesAndMoveToTop() {
    for (int i = 0; i < subCategoriesForFilterList.length; i++) {
      for (int j = 0; j < tempCheckedSubCategoriesList.length; j++) {
        if (subCategoriesForFilterList[i].subCategoryName ==
            tempCheckedSubCategoriesList[j]?.subType) {
          subCategoriesForFilterList[i].isSelected = true;
        }
      }
    }

    /// move checked item at the beginning of list
    subCategoriesForFilterList = moveCheckedSubCategoriesFiltersAtBeginning(
        filterList: subCategoriesForFilterList);
    notifyListeners();
  }

  /// check if the argumentsSubCategoryFilterList contains those sub-cat which are not
  /// in filterList(api based) because it can be in 2nd page or 3rd page of api
  /// if not present add them
  List<SubCategoriesForFilter>? addPreSelectedSubCategoriesToFilterList({
    required List<SubCategoriesForFilter>? subCategoriesForFilterList,
    // required argss? args,
    required List<SubType>? filterApiList,
  }) {
    filterApiList = filterApiList?.toSet().toList();
    for (var element in tempCheckedSubCategoriesList) {
      if (!filterApiList!.contains(element)) {
        subCategoriesForFilterList?.add(
          SubCategoriesForFilter(
            subCategoryName: element?.subType ?? '',
            isSelected: true,
            count: element?.count ?? 0,
          ),
        );
      }
    }

    return subCategoriesForFilterList?.toSet().toList();
  }

  void updateSelectedFilterView({required int value}) {
    selectedFilterView = value;
    switch (value) {
      case 0:
        clickedFilter = 'Brand';
        getBrandsList(showLoader: true);
        break;

      case 1:
        clickedFilter = 'Category';
        getProductCategoriesList(showLoader: true);

        break;
      case 2:
        clickedFilter = 'Sub-Category';
        getProductsSubCategoriesList(showLoader: true);
        break;
    }
    notifyListeners();
  }
}

/// it is created to make the sub category list checkable in filter bottom sheet
class SubCategoriesForFilter {
  SubCategoriesForFilter({
    required this.subCategoryName,
    required this.isSelected,
    required this.count,
  });

  final int? count;
  bool? isSelected;
  final String? subCategoryName;
}
