import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/pim_product_list_types.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/decorative_container.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/list_footer.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ProductsListViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsListViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                children: [
                  PageBarWidget(
                    title: model.getTitle(),
                    subTitle: '#${model.productListResponse.totalItems}',
                    options: [
                      if (model.isDeoSuperVisor())
                        InputChip(
                          label: Text(
                            labelGetProductById,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: AppColors().white,
                                ),
                          ),
                          onPressed: () {
                            model.getProductById();
                          },
                        )
                    ],
                  ),
                  const ProductListHeader(),
                  Flexible(
                    child: ListView.separated(
                      itemBuilder: (context, index) => AppInkwell(
                        onTap: model.productListResponse.products == null
                            ? null
                            : () {
                                if (model.isDeo()) {
                                  model.showErrorSnackBar(
                                    message: errorNotAuthorisedToEditProducts,
                                  );
                                } else {
                                  model.openProductDetailsDialog(
                                    product: model.productListResponse.products!
                                        .elementAt(index),
                                  );
                                }
                              },
                        child: ProductListItem(
                          index: index,
                          product: model.productListResponse.products!
                              .elementAt(index),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const DottedDivider(),
                      itemCount: model.productListResponse.products!.length,
                    ),
                    flex: 1,
                  ),
                  ListFooter.firstPreviousNextLast(
                    showJumpToPage: model.isDeo() ||
                            model.isDeoSuperVisor() ||
                            model.isDeoGd()
                        ? true
                        : false,
                    onJumpToPage: ({required int pageNumber}) {
                      model.pageNumber = pageNumber;
                      model.getProductList(showLoader: true);
                    },
                    pageNumber: model.pageNumber,
                    totalPages: model.productListResponse.totalPages == null
                        ? 0
                        : model.productListResponse.totalPages! - 1,
                    onFirstPageClick: () {
                      model.pageNumber = 0;
                      model.getProductList(showLoader: true);
                    },
                    onLastPageClick: () {
                      model.pageNumber =
                          model.productListResponse.totalPages! - 1;
                      model.getProductList(showLoader: true);
                    },
                    onPreviousPageClick: () {
                      model.pageNumber--;
                      model.getProductList(showLoader: true);
                    },
                    onNextPageClick: () {
                      model.pageNumber++;
                      model.getProductList(showLoader: true);
                    },
                  )
                ],
              ),
      ),
      viewModelBuilder: () => ProductsListViewModel(),
    );
  }
}

class ProductsListViewArguments {
  ProductsListViewArguments({required this.productListType});

  final PimProductListType productListType;
}

class ProductListHeader extends StatelessWidget {
  const ProductListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        (AppTextStyles(context: context).getNormalTableTextStyle).copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return DecorativeContainer(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Id',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Brand',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Type',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Subtype',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Title',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Created On',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return DecorativeContainer.transparent(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: product.id != null ? product.id.toString() : '0',
            ),
          ),
          Expanded(
            flex: 3,
            child: NullableTextWidget(
              stringValue: product.brand,
            ),
          ),
          Expanded(
            flex: 2,
            child: NullableTextWidget(
              stringValue: product.type,
            ),
          ),
          Expanded(
            flex: 2,
            child: NullableTextWidget(
              stringValue: product.subType,
            ),
          ),
          Expanded(
            flex: 6,
            child: NullableTextWidget(
              stringValue: product.title,
            ),
          ),
          Expanded(
            flex: 2,
            child: NullableTextWidget(
              stringValue: product.creationdate,
            ),
          ),
        ],
      ),
    );
  }
}
