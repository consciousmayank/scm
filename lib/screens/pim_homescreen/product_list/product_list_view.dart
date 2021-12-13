import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/decorative_container.dart';
import 'package:scm/widgets/dotted_divider.dart';
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
      onModelReady: (model) => model.getProductList(),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                children: [
                  const PageBarWidget(
                    title: productsListPageTitle,
                  ),
                  const ProductListHeader(),
                  Flexible(
                    child: ListView.separated(
                      itemBuilder: (context, index) => ProductListItem(
                        product: model.productListResponse.products!
                            .elementAt(index),
                      ),
                      separatorBuilder: (context, index) =>
                          const DottedDivider(),
                      itemCount: model.productListResponse.products!.length,
                    ),
                    flex: 1,
                  )
                ],
              ),
      ),
      viewModelBuilder: () => ProductsListViewModel(),
    );
  }
}

class ProductsListViewArguments {}

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
              'Title',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Tags',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Brand',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Type',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Subtype',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Price',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Measurement',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Measurement Unit',
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
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DecorativeContainer.transparent(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.title,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.tags,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.brand,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.type,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.subType,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.price != null ? product.price.toString() : '0',
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.measurement != null
                  ? product.measurement.toString()
                  : '0',
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              text: product.measurementUnit,
            ),
          ),
        ],
      ),
    );
  }
}
