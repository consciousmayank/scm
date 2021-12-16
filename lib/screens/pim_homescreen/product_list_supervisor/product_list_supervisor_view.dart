import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';

class ProductListSuervisorView extends StatefulWidget {
  final ProductListSuervisorViewArguments arguments;
  const ProductListSuervisorView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  _ProductListSuervisorViewState createState() =>
      _ProductListSuervisorViewState();
}

class _ProductListSuervisorViewState extends State<ProductListSuervisorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelStyle: AppTextStyles(context: context).tabSelectedLabelStyle,
              unselectedLabelStyle:
                  AppTextStyles(context: context).tabUnselectedLabelStyle,
              labelColor: AppColors().tabSelectedLabelColor,
              unselectedLabelColor: AppColors().tabUnSelectedLabelColor,
              indicator: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors().tabIndicatorColor,
              ),
              tabs: const [
                Tab(
                  text: todoProductsListPageTitle,
                ),
                Tab(
                  text: publishedProductsListPageTitle,
                ),
              ],
            ),
            // Divider(
            //   height: 2,
            //   thickness: 2,
            //   color: AppColors().tabDividerColor,
            // ),
            hSizedBox(height: 1),
            Expanded(
              child: TabBarView(
                children: [
                  ProductsListView(
                    arguments: ProductsListViewArguments(
                      productListType: ProductListType.TODO,
                    ),
                  ),
                  ProductsListView(
                    arguments: ProductsListViewArguments(
                      productListType: ProductListType.PUBLISHED,
                    ),
                  ),
                  // Text('test'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListSuervisorViewArguments {}
