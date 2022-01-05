import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_items_list_table.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class CartListViewWidget extends ViewModelWidget<CartPageViewModel> {
  const CartListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CartPageViewModel viewModel) {
    return viewModel.cartApiStatus == ApiStatus.LOADING
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              shape: Dimens().getCardShape(),
              color: AppColors().white,
              child: Column(
                children: [
                  PageBarWidget.withCustomFiledColor(
                    title: labelCartPageTitle,
                    filledColor: AppColors().white,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == 0) {
                                  return ProcessingItemsListTable.header(
                                    values: const [
                                      Text(
                                        '#',
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Title',
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Qty',
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                    flexValues: const [1, 5, 3, 3],
                                  );
                                }

                                index -= 1;

                                return ProcessingItemsListTable.normal(
                                  values: [
                                    Text(
                                      '${index + 1}',
                                      textAlign: TextAlign.center,
                                    ),
                                    AppInkwell(
                                      onTap: () {
                                        viewModel.openProductDetails(
                                          productId: viewModel.cart.cartItems!
                                              .elementAt(index)
                                              .itemId!,
                                          productTitle: viewModel
                                              .cart.cartItems!
                                              .elementAt(index)
                                              .itemTitle!,
                                        );
                                      },
                                      child: Text(
                                        '${viewModel.cart.cartItems!.elementAt(index).itemTitle}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        '${viewModel.cart.cartItems!.elementAt(index).itemQuantity}',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            viewModel.editCartItemAt(
                                              index: index,
                                              cartItem: viewModel
                                                  .cart.cartItems!
                                                  .elementAt(
                                                index,
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          label: const Text(''),
                                        ),
                                        wSizedBox(width: 8),
                                        TextButton.icon(
                                          onPressed: () {
                                            viewModel.deleteCartItemAt(
                                              cartItem: viewModel
                                                  .cart.cartItems!
                                                  .elementAt(
                                                index,
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          label: const Text(''),
                                        ),
                                      ],
                                    )
                                  ],
                                  flexValues: const [1, 5, 3, 3],
                                );
                              },
                              childCount: viewModel.cart.cartItems!.length + 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProcessingItemsListTable.header(
                    values: [
                      Text(
                        'Total',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                        ),
                        child: Text(
                          '${viewModel.cart.totalItems} Items',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                    flexValues: const [2, 2, 2],
                  )
                ],
              ),
            ),
          );
  }
}
