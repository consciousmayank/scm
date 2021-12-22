import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/supply_module_screens/homepage/home_page_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController? searchProductTextController = TextEditingController();
  FocusNode searchProductTextFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (viewModel) {
        // viewModel.getAllBrands();
        // viewModel.getAllCategories();
        // viewModel.getAllProducts();
      },
      builder: (context, viewModel, child) => const Scaffold(
        body: HomePageBodyWidget(),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}

class HomePageBodyWidget extends ViewModelWidget<HomePageViewModel> {
  const HomePageBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: CustomScrollView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        slivers: [
          // SliverToBoxAdapter(
          //   child: PageBarWidget(title: 'Products', options: [
          //     InkWell(
          //       onTap: () {
          //         viewModel.takeToSearchProductsView();
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(18.0),
          //         child: Image.asset(
          //           searchIconBlack,
          //           width: 20,
          //           height: 20,
          //           color: AppColors().black,
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
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
          )
        ],
      ),
    );
  }
}
