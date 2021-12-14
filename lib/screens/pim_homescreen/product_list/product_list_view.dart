import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/user_roles.dart';
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
      onModelReady: (model) => model.getProductList(showLoader: true),
      builder: (context, model, child) => Scaffold(
        body: model.isBusy
            ? const LoadingWidget()
            : Column(
                children: [
                  PageBarWidget(
                    title: productsListPageTitle,
                    subTitle: '#${model.productListResponse.totalItems}',
                  ),
                  const ProductListHeader(),
                  Flexible(
                    child: LazyLoadScrollView(
                      scrollOffset: (MediaQuery.of(context).size.height ~/ 6),
                      onEndOfPage: () =>
                          model.getProductList(showLoader: false),
                      child: ListView.separated(
                        itemBuilder: (context, index) => ProductListItem(
                          index: index,
                          product: model.productListResponse.products!
                              .elementAt(index),
                        ),
                        separatorBuilder: (context, index) =>
                            const DottedDivider(),
                        itemCount: model.productListResponse.products!.length,
                      ),
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
          if (di<AppPreferences>().getSelectedUserRole() ==
              AuthenticatedUserRoles.ROLE_SUPVR.getStatusString)
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
            flex: 2,
            child: Text(
              'Title',
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
          // Text(
          //   index.toString(),
          // ),
          if (di<AppPreferences>().getSelectedUserRole() ==
              AuthenticatedUserRoles.ROLE_SUPVR.getStatusString)
            Expanded(
              flex: 1,
              child: NullableTextWidget(
                text: product.id != null ? product.id.toString() : '0',
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
            flex: 2,
            child: NullableTextWidget(
              text: product.title,
            ),
          ),
        ],
      ),
    );
  }
}
