import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_table_widget.dart';
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
                  hSizedBox(height: 8),
                  // PageBarWidget.withCustomFiledColor(
                  //   subTitle: 'Total : ${viewModel.cart.cartItems?.length}',
                  //   title: labelCartPageTitle,
                  //   filledColor: AppColors().white,
                  //   options: [
                  //     Text('Total Items: ${viewModel.cart.cartItems?.length}'),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AppTableWidget.header(values: [
                      const AppTableSingleItem.string(
                        '#',
                        flexValue: 1,
                        textAlignment: TextAlign.center,
                      ),
                      const AppTableSingleItem.string(
                        'TITLE',
                        flexValue: 5,
                      ),
                      AppTableSingleItem.customWidget(
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: Text(
                            labelQuantity,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: AppColors().primaryHeaderTextColor,
                                    ),
                          ),
                        ),
                        flexValue: 2,
                      ),
                      AppTableSingleItem.customWidget(
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: Text(
                            labelOptions,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: AppColors().primaryHeaderTextColor,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        flexValue: 2,
                      ),
                    ]),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return AppTableWidget.values(
                                  values: [
                                    AppTableSingleItem.customWidget(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          '${index + 1}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                      flexValue: 1,
                                    ),
                                    AppTableSingleItem.customWidget(
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
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          child: Text(
                                            '${viewModel.cart.cartItems!.elementAt(index).itemTitle}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .underline),
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      flexValue: 5,
                                    ),
                                    AppTableSingleItem.customWidget(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: Text(
                                            '${viewModel.cart.cartItems!.elementAt(index).itemQuantity}',
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      flexValue: 2,
                                    ),
                                    AppTableSingleItem.customWidget(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AppButton(
                                            buttonBg:
                                                AppColors().buttonGreenColor,
                                            toolTipMessage:
                                                labelEditItemQuantity,
                                            onTap: () {
                                              viewModel.editCartItemAt(
                                                index: index,
                                                cartItem: viewModel
                                                    .cart.cartItems!
                                                    .elementAt(
                                                  index,
                                                ),
                                              );
                                            },
                                            leading: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: AppColors().white,
                                            ),
                                          ),
                                          wSizedBox(width: 8),
                                          AppButton(
                                            toolTipMessage: labelRemoveItem,
                                            buttonBg:
                                                AppColors().buttonRedColor,
                                            onTap: () {
                                              viewModel.deleteCartItemAt(
                                                cartItem: viewModel
                                                    .cart.cartItems!
                                                    .elementAt(
                                                  index,
                                                ),
                                              );
                                            },
                                            leading: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: AppColors().white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      flexValue: 2,
                                      textAlignment: TextAlign.right,
                                    ),
                                  ],
                                );
                              },
                              childCount: viewModel.cart.cartItems!.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: AppTableWidget.values(
                      values: [
                        AppTableSingleItem.string(
                          'Total Quantity',
                          textAlignment: TextAlign.right,
                          textStyle:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          flexValue: Dimens().grandTotaltFlexValueCart,
                        ),
                        AppTableSingleItem.customWidget(
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: Text(
                              viewModel.getCartItemsQuantityTotal().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          flexValue: Dimens().quantityFlexValueCart,
                        ),
                        AppTableSingleItem.string(
                          '',
                          flexValue: Dimens().quantityFlexValueCart,
                          textStyle:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: SizedBox(
                      height: Dimens().buttonHeight,
                      width: double.infinity,
                      child: AppButton(
                        toolTipMessage: viewModel.selectedAddress == null
                            ? labelPickAddressToPlaceOrder
                            : labelPlaceOrder,
                        buttonBg: viewModel.selectedAddress == null
                            ? Colors.grey
                            : AppColors().buttonGreenColor,
                        onTap: viewModel.selectedAddress == null
                            ? null
                            : () {
                                viewModel.placeOrder();
                              },
                        title: labelPlaceOrder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
