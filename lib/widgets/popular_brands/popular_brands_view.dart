import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/animated_search_widget.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/list_footer.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/popular_brands/popular_brands_viewmodel.dart';
import 'package:scm/widgets/profile_image_widget.dart';
import 'package:stacked/stacked.dart';

class PopularBrandsView extends StatelessWidget {
  const PopularBrandsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final PopularBrandsViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PopularBrandsViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      builder: (context, model, child) => Scaffold(
        appBar: arguments.isFullScreen
            ? appbarWidget(
                context: context,
                title: labelBrands,
                automaticallyImplyLeading: true,
                options: [
                  AnimatedSearchWidget(
                    hintText: labelSearchBrands,
                    onSearch: ({required String searchTerm}) {
                      model.brandTitle = searchTerm;
                      model.getAllBrands();
                    },
                    onCrossButtonClicked: () {
                      model.brandTitle = '';
                      model.getAllBrands();
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
                  text: 'Fetching Popular Brands. Please Wait',
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
                              labelPopularBrands,
                              style: AppTextStyles(context: context)
                                  .popularBrandsTitleStyle,
                            ),
                            AppInkwell(
                              onTap: arguments.onSeeAllBrandsClicked == null
                                  ? null
                                  : () => arguments.onSeeAllBrandsClicked!(),
                              child: Text(
                                'See All',
                                style: AppTextStyles(context: context)
                                    .popularBrandsTitleStyle
                                    .copyWith(
                                        color:
                                            AppColors().popularBrandsSeeAllBg,
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      arguments.isFullScreen
                          ? Flexible(
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    model.allBrandsResponse!.brands!.length,
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
                                ),
                                itemBuilder: (BuildContext context, int index) {
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
                                            selectedItem: selectedItem);
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      if (arguments.isFullScreen)
                        ListFooter.firstPreviousNextLast(
                          pageNumber: model.pageIndex,
                          totalPages:
                              model.allBrandsResponse!.totalItems == null
                                  ? 0
                                  : model.allBrandsResponse!.totalPages! - 1,
                          onPreviousPageClick: () {
                            model.pageIndex--;
                            model.getAllBrands();
                          },
                          onNextPageClick: () {
                            model.pageIndex++;
                            model.getAllBrands();
                          },
                          onFirstPageClick: () {
                            model.pageIndex = 0;
                            model.getAllBrands();
                          },
                          onLastPageClick: () {
                            model.pageIndex =
                                model.allBrandsResponse!.totalPages == null
                                    ? 0
                                    : model.allBrandsResponse!.totalPages! - 1;
                            model.getAllBrands();
                          },
                        ),
                      if (!arguments.isFullScreen)
                        model.allBrandsResponse != null ||
                                model.allBrandsResponse!.brands != null
                            ? SizedBox(
                                height: Dimens().popularBrandsHeight - 50,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ListView.builder(
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SinglePopularBrandItem(
                                          item: model.allBrandsResponse!.brands!
                                              .elementAt(
                                            index,
                                          ),
                                          onItemClicked: (
                                              {required Brand selectedItem}) {
                                            model.takeToProductListView(
                                                selectedItem: selectedItem);
                                          },
                                        ),
                                      ),
                                      itemCount: model
                                          .allBrandsResponse!.brands!.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    Positioned(
                                      left: 0,
                                      child: AppInkwell.withBorder(
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_left,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: AppInkwell.withBorder(
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                    ],
                  ),
                ),
              ),
      ),
      viewModelBuilder: () => PopularBrandsViewModel(),
    );
  }
}

class PopularBrandsViewArguments {
  PopularBrandsViewArguments({
    this.isFullScreen = false,
    required this.onSeeAllBrandsClicked,
  }) : supplierId = null;

  PopularBrandsViewArguments.fullScreen({
    this.isFullScreen = true,
    this.onSeeAllBrandsClicked,
  }) : supplierId = null;

  PopularBrandsViewArguments.demanderPopularBrands({
    this.isFullScreen = true,
    required this.supplierId,
  }) : onSeeAllBrandsClicked = null;

  final bool isFullScreen;
  final Function? onSeeAllBrandsClicked;
  final int? supplierId;
}

class SinglePopularBrandItem extends StatelessWidget {
  const SinglePopularBrandItem({
    Key? key,
    required this.onItemClicked,
    required this.item,
  }) : super(key: key);

  final Function({required Brand selectedItem}) onItemClicked;
  final Brand item;

  @override
  Widget build(BuildContext context) {
    // double width = getValueForScreenType(
    //   context: context,
    //   mobile: 100,
    //   tablet: 200,
    //   desktop: 300,
    // );

    return AppInkwell.withBorder(
      borderDerRadius: BorderRadius.circular(
        Dimens().suppliersListItemImageCiircularRaduis,
      ),
      onTap: () => onItemClicked(selectedItem: item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileImageWidget.withNoElevation(
            profileImageSize: 100,
            imageUrlString: item.image,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(4),
            child: Text(
              item.title ?? '',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens().suppliersListItemImageCiircularRaduis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadNextProductWidget extends ViewModelWidget<PopularBrandsViewModel> {
  const LoadNextProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, PopularBrandsViewModel viewModel) {
    return viewModel.allBrandsResponse!.totalPages! - 1 == viewModel.pageIndex
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
                    text: 'Loading More Brands. Please wait')
                : Center(
                    child: TextButton(
                        style: AppTextButtonsStyles().textButtonStyle,
                        onPressed:
                            viewModel.allBrandsResponse!.totalPages! - 1 ==
                                    viewModel.pageIndex
                                ? null
                                : () {
                                    viewModel.pageIndex++;
                                    viewModel.getAllBrands();
                                  },
                        child: Text(
                            viewModel.allBrandsResponse!.totalPages! - 1 ==
                                    viewModel.pageIndex
                                ? 'Thats all folks'
                                : 'Load Next Set of Brands')),
                  ),
          );
  }
}
