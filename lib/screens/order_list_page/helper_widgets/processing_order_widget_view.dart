import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/order_status_types.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/screens/order_list_page/helper_widgets/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_process_buttons.dart';
import 'package:scm/screens/order_list_page/helper_widgets/orderitem_row_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_items_list_table.dart';
import 'package:scm/screens/order_list_page/helper_widgets/quantity_input_widget.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

class ProcessingOrderWidget extends ViewModelWidget<OrderListPageViewModel> {
  const ProcessingOrderWidget({
    Key? key,
  }) : super(key: key);

  String getAddressString({required Address? address}) {
    if (address == null) {
      return '';
    }
    return '${address.addressLine1}, ${address.addressLine2}, \n${address.locality} ${address.nearby}, \n${address.city}, ${address.state}, ${address.country}, ${address.pincode}';
  }

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    return Card(
      shape: Dimens().getCardShape(),
      color: AppColors().white,
      elevation: Dimens().getDefaultElevation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  labelOrderDetail,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      Dimens().defaultBorder,
                    ),
                    bottomLeft: Radius.circular(
                      Dimens().defaultBorder,
                    ),
                  ),
                  color: getBorderColor(
                      status: viewModel.selectedOrder.status.toString()),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  getApiToAppOrderStatus(
                    status: viewModel.selectedOrder.status.toString(),
                  ),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColors().white,
                      ),
                ),
              ),
            ],
          ),
          hSizedBox(
            height: 8,
          ),
          OrderItemContainerWidget(
            child: Column(
              children: [
                OrderItemRowWidget.noValueWithLabelStyle(
                  label: 'Summary',
                  labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                OrderItemRowWidget.customPadding(
                  padding: const EdgeInsets.all(0),
                  label: 'Order Id',
                  value: '#${viewModel.orderDetails.id}',
                ),
                OrderItemRowWidget.customPadding(
                  padding: const EdgeInsets.all(0),
                  label: 'Total Amount',
                  value: '${viewModel.orderDetails.totalAmount}',
                ),
                OrderItemRowWidget.customPadding(
                  padding: const EdgeInsets.all(0),
                  label: 'Total Items',
                  value: '${viewModel.orderDetails.totalItems}',
                ),
                OrderItemRowWidget.customPadding(
                  padding: const EdgeInsets.all(0),
                  label: 'Placed On',
                  value: '${viewModel.orderDetails.createDateTime}',
                ),
                OrderItemRowWidget.customPadding(
                  padding: const EdgeInsets.all(0),
                  label: 'Ordered By',
                  value: viewModel.isSupplier()
                      ? '${viewModel.orderDetails.demandBusinessName}'
                      : '${viewModel.orderDetails.supplyBusinessName}',
                )
              ],
            ),
          ),
          hSizedBox(
            height: 8,
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
                                'Details',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Qty',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Price',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Amount',
                                textAlign: TextAlign.right,
                              )
                            ],
                            flexValues: const [1, 5, 2, 3, 3, 1, 3],
                          );
                        }

                        index -= 1;

                        return ProcessingItemsListTable.normal(
                          values: [
                            Text(
                              '$index',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${viewModel.orderDetails.orderItems!.elementAt(index).itemTitle}',
                              textAlign: TextAlign.left,
                            ),
                            AppInkwell(
                              onTap: () {
                                viewModel.openProductDetails(
                                    productId: viewModel
                                        .orderDetails.orderItems!
                                        .elementAt(index)
                                        .itemId!,
                                    productTitle: viewModel
                                            .orderDetails.orderItems!
                                            .elementAt(index)
                                            .itemTitle ??
                                        'NA');
                              },
                              child: const Text(
                                'View Product',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: viewModel.orderDetails.status ==
                                      OrderStatusTypes.PROCESSING.apiToAppTitles
                                  ? QuantityWidget(
                                      focusNode: viewModel
                                          .quantityEditingFocusnodes
                                          .elementAt(index),
                                      controller: viewModel
                                          .quantityEditingControllers
                                          .elementAt(index),
                                      index: index,
                                      onChanged: ({required String value}) {
                                        // viewModel.updateQuantity(
                                        //     index: index, quantity: value);
                                        // viewModel.quantityEditingFocusnodes
                                        //     .elementAt(index)
                                        //     .requestFocus();
                                      },
                                      quantity: viewModel
                                              .orderDetails.orderItems!
                                              .elementAt(index)
                                              .itemQuantity ??
                                          0,
                                      hint: 'Item Quantity',
                                    )
                                  : Text(
                                      '${viewModel.orderDetails.orderItems!.elementAt(index).itemQuantity}',
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: viewModel.orderDetails.status ==
                                      OrderStatusTypes.PROCESSING.apiToAppTitles
                                  ? PriceWidget(
                                      focusNode: viewModel
                                          .priceEditingFocusnodes
                                          .elementAt(index),
                                      controller: viewModel
                                          .priceEditingControllers
                                          .elementAt(index),
                                      index: index,
                                      onChanged: ({required String value}) {
                                        // viewModel.updatePrice(
                                        //     index: index, price: value);
                                        // viewModel.priceEditingFocusnodes
                                        //     .elementAt(index)
                                        //     .requestFocus();
                                      },
                                      hint: 'Item Price',
                                      price: viewModel.orderDetails.orderItems!
                                              .elementAt(index)
                                              .itemPrice ??
                                          0,
                                    )
                                  : Text(
                                      '${viewModel.orderDetails.orderItems!.elementAt(index).itemPrice}',
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                            viewModel.orderDetails.status ==
                                    OrderStatusTypes.PROCESSING.apiToAppTitles
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    child: AppInkwell(
                                      onTap: () {
                                        viewModel.updateTotal(
                                          index: index,
                                          price: double.parse(
                                            viewModel.priceEditingControllers
                                                .elementAt(index)
                                                .text
                                                .trim(),
                                          ),
                                          quantity: int.parse(
                                            viewModel.quantityEditingControllers
                                                .elementAt(index)
                                                .text
                                                .trim(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.done,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Text(
                              '${viewModel.orderDetails.orderItems!.elementAt(index).itemTotalPrice}',
                              textAlign: TextAlign.right,
                            )
                          ],
                          flexValues: const [1, 5, 2, 3, 3, 1, 3],
                        );
                      },
                      childCount: viewModel.orderDetails.orderItems!.length + 1,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: hSizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: OrderItemContainerWidget(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  labelShippingAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    getAddressString(
                                      address: viewModel
                                          .orderDetails.shippingAddress,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  labelBillingAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    getAddressString(
                                      address:
                                          viewModel.orderDetails.billingAddress,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const OrderPorcessButtonsWidget()
        ],
      ),
    );
  }
}
