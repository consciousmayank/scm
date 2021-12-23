import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/popular_categories/popular_categories_viewmodel.dart';
import 'package:scm/widgets/profile_image_widget.dart';
import 'package:stacked/stacked.dart';

class PopularCategoriesView extends StatelessWidget {
  final PopularCategoriesViewArguments arguments;
  const PopularCategoriesView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PopularCategoriesViewModel>.reactive(
      onModelReady: (model) => model.getAllCategories(),
      builder: (context, model, child) => Scaffold(
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
                                    color: AppColors().popularBrandsSeeAllBg,
                                    decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      model.categoriesResponse != null ||
                              model.categoriesResponse!.types != null
                          ? SizedBox(
                              height: Dimens().popularCategoryHeight - 50,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ListView.builder(
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SinglePopularBrandItem(
                                        item: model.categoriesResponse!.types!
                                            .elementAt(
                                          index,
                                        ),
                                        onItemClicked: (
                                            {required String selectedItem}) {
                                          print('$selectedItem clicked');
                                        },
                                      ),
                                    ),
                                    itemCount:
                                        model.categoriesResponse!.types!.length,
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
                    ],
                  ),
                ),
              ),
      ),
      viewModelBuilder: () => PopularCategoriesViewModel(),
    );
  }
}

class PopularCategoriesViewArguments {}

class SinglePopularBrandItem extends StatelessWidget {
  final Function({required String selectedItem}) onItemClicked;
  final String item;
  const SinglePopularBrandItem({
    Key? key,
    required this.onItemClicked,
    required this.item,
  }) : super(key: key);

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
