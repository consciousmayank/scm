import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/supply_module_screens/products/products_page_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_footer_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class SupplyProductsOptionsPageView extends StatefulWidget {
  const SupplyProductsOptionsPageView({Key? key}) : super(key: key);

  @override
  _SupplyProductsOptionsPageViewState createState() =>
      _SupplyProductsOptionsPageViewState();
}

class _SupplyProductsOptionsPageViewState
    extends State<SupplyProductsOptionsPageView> {
  final ItemPositionsListener brandsItemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController brandsItemScrollController =
      ItemScrollController();

  final ItemPositionsListener categoriesItemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController categoriesItemScrollController =
      ItemScrollController();

  TextEditingController? searchProductTextController = TextEditingController();
  FocusNode searchProductTextFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SupplyProductsOptionsPageViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
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
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SupplyProductsOptionsPageViewModel(),
    );
  }
}

class HomePageBodyWidget
    extends ViewModelWidget<SupplyProductsOptionsPageViewModel> {
  const HomePageBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
      BuildContext context, SupplyProductsOptionsPageViewModel viewModel) {
    return CustomScrollView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      slivers: [
        SliverToBoxAdapter(
          child: hSizedBox(height: 5),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimens().popularBrandsHeight,
            child: PopularBrandsView(
              arguments: PopularBrandsViewArgs(
                  onSeeAllBrandsClicked: () =>
                      viewModel.takeToFullScreenBrandsView()),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimens().popularCategoryHeight,
            child: PopularCategoriesView(
              arguments: PopularCategoriesViewArgs(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: getValueForScreenType(
              context: context,
              mobile: Dimens().popularProductsHeight / 3,
              tablet: Dimens().popularProductsHeight,
              desktop: Dimens().popularProductsHeight,
            ),
            child: ProductListView(
              arguments: ProductListViewArgs.asWidget(
                brandsFilterList: [],
                categoryFilterList: [],
                productTitle: '',
                subCategoryFilterList: [],
                supplierId: -1,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: AppFooterWidget(),
        )
      ],
    );
  }
}
