import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
import 'package:stacked/stacked.dart';

class SupplyProductsOptionsPageView extends StatefulWidget {
  const SupplyProductsOptionsPageView({Key? key}) : super(key: key);

  @override
  _SupplyProductsOptionsPageViewState createState() =>
      _SupplyProductsOptionsPageViewState();
}

class _SupplyProductsOptionsPageViewState
    extends State<SupplyProductsOptionsPageView> {
  TextEditingController? searchProductTextController = TextEditingController();
  FocusNode searchProductTextFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SupplyProductsOptionsPageViewModel>.reactive(
      builder: (context, viewModel, child) => const Scaffold(
        body: HomePageBodyWidget(),
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
              arguments: PopularBrandsViewArguments(
                  onSeeAllBrandsClicked: () =>
                      viewModel.takeToFullScreenBrandsView()),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimens().popularCategoryHeight,
            child: PopularCategoriesView(
              arguments: PopularCategoriesViewArguments(),
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
              arguments: ProductListViewArguments.asWidget(
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