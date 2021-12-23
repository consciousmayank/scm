import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
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
                    title: arguments.productListType == ProductListType.TODO
                        ? todoProductsListPageTitle
                        : publishedProductsListPageTitle,
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

                  // Flexible(
                  //   child: SizedBox.expand(
                  //     child: SingleChildScrollView(
                  //       child: PaginatedDataTable(
                  //         source: model.productListDataSource,
                  //         // header: PageBarWidget(
                  //         //   title: productsListPageTitle,
                  //         //   subTitle: '#${model.productListResponse.totalItems}',
                  //         // ),
                  //         // header: const ProductListHeader(),
                  //         // headingRowHeight: 200,
                  //         columnSpacing: 20,
                  //         columns: const [
                  //           DataColumn(
                  //             label: Text('ID'),
                  //             // onSort: (columnIndex, ascending) {
                  //             //   model.sort<num>(
                  //             //     (user) => user.id!,
                  //             //     columnIndex,
                  //             //     ascending,
                  //             //   );
                  //             // },
                  //           ),
                  //           DataColumn(label: Text('Brand')),
                  //           DataColumn(label: Text('Type')),
                  //           DataColumn(label: Text('SubType')),
                  //           DataColumn(label: Text('Title')),
                  //         ],
                  //         // columnSpacing: 100,
                  //         horizontalMargin: 10,
                  //         rowsPerPage: 20,
                  //         showCheckboxColumn: false,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Flexible(
                    child: LazyLoadScrollView(
                      scrollOffset: (MediaQuery.of(context).size.height ~/ 6),
                      onEndOfPage: () {
                        // model.getProductList(showLoader: false);
                      },
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
                                      product: model
                                          .productListResponse.products!
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
                    ),
                    flex: 1,
                  ),

                  ListFooter.firstPreviousNextLast(
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

  final ProductListType productListType;
}

enum ProductListType { TODO, PUBLISHED }

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
            flex: 1,
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
              text: product.id != null ? product.id.toString() : '0',
            ),
          ),
          Expanded(
            flex: 3,
            child: NullableTextWidget(
              text: product.brand,
            ),
          ),
          Expanded(
            flex: 2,
            child: NullableTextWidget(
              text: product.type,
            ),
          ),
          Expanded(
            flex: 2,
            child: NullableTextWidget(
              text: product.subType,
            ),
          ),
          Expanded(
            flex: 6,
            child: NullableTextWidget(
              text: product.title,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.creationdate,
            ),
          ),
        ],
      ),
    );
  }
}
