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
import 'package:scm/utils/date_time_converter.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:stacked/stacked.dart';

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
      child: CustomScrollView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        slivers: [
          SliverToBoxAdapter(
            child: viewModel.isSupplier()
                ? const Padding(
                    padding: EdgeInsets.only(top: 4.0, right: 4),
                    child: OrderPorcessButtonsWidget(),
                  )
                : Container(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProcessingItemsListTable.header(
                    flexValues: const [1],
                    values: [
                      Text(
                        "ORDER DETAIL",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppColors().primaryHeaderTextColor,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OrderSummaryItemViewWidget(
                            label: 'ORDER ID',
                            value: '#${viewModel.orderDetails.id}'),
                        flex: 2,
                      ),
                      Expanded(
                        child: viewModel.isSupplier()
                            ? OrderSummaryItemViewWidget(
                                label: 'DEMAND BY',
                                value:
                                    '${viewModel.orderDetails.demandBusinessName}',
                              )
                            : OrderSummaryItemViewWidget(
                                label: 'SUPPLY BY',
                                value:
                                    '${viewModel.orderDetails.supplyBusinessName}',
                              ),
                        flex: 5,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OrderSummaryItemViewWidget(
                          label: 'TOTAL ITEMS',
                          value: '${viewModel.orderDetails.totalItems}',
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: OrderSummaryItemViewWidget(
                          label: 'TOTAL AMOUNT',
                          value: '${viewModel.orderDetails.totalAmount}',
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: OrderSummaryItemViewWidget(
                          label: 'PLACED ON',
                          value: DateTimeToStringConverter.ddMMMMyyyyhhmmssaa(
                            date: StringToDateTimeConverter.ddmmyyhhmmss24Hr(
                                    date:
                                        viewModel.orderDetails.createDateTime ??
                                            '')
                                .convert(),
                          ).convert(),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: hSizedBox(
              height: 8,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ProcessingItemsListTable.header(
                      values: [
                        Text(
                          '#',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                        ),
                        Text(
                          'TITLE',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          labelQuantity,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'PRICE',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                        ),
                        Text(
                          'AMOUNT',
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppColors().primaryHeaderTextColor,
                                  ),
                        )
                      ],
                      flexValues: const [1, 5, 3, 3, 1, 3],
                    ),
                  );
                }

                index -= 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProcessingItemsListTable.normal(
                    values: [
                      Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      AppInkwell(
                        onTap: () {
                          viewModel.openProductDetails(
                              productId: viewModel.orderDetails.orderItems!
                                  .elementAt(index)
                                  .itemId!,
                              productTitle: viewModel.orderDetails.orderItems!
                                      .elementAt(index)
                                      .itemTitle ??
                                  'NA');
                        },
                        child: Text(
                          '${viewModel.orderDetails.orderItems!.elementAt(index).itemTitle}',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: viewModel.isSupplier() &&
                                viewModel.orderDetails.status ==
                                    OrderStatusTypes.PROCESSING.apiToAppTitles
                            ? QuantityWidget(
                                focusNode: viewModel.quantityEditingFocusnodes
                                    .elementAt(index),
                                controller: viewModel.quantityEditingControllers
                                    .elementAt(index),
                                index: index,
                                onChanged: ({required String value}) {
                                  // viewModel.updateQuantity(
                                  //     index: index, quantity: value);
                                  // viewModel.quantityEditingFocusnodes
                                  //     .elementAt(index)
                                  //     .requestFocus();
                                },
                                quantity: viewModel.orderDetails.orderItems!
                                        .elementAt(index)
                                        .itemQuantity ??
                                    0,
                                hint: 'Item Quantity',
                              )
                            : Text(
                                '${viewModel.orderDetails.orderItems!.elementAt(index).itemQuantity}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: viewModel.isSupplier() &&
                                viewModel.orderDetails.status ==
                                    OrderStatusTypes.PROCESSING.apiToAppTitles
                            ? PriceWidget(
                                focusNode: viewModel.priceEditingFocusnodes
                                    .elementAt(index),
                                controller: viewModel.priceEditingControllers
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
                                style: Theme.of(context).textTheme.headline6,
                              ),
                      ),
                      viewModel.isSupplier() &&
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
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                    flexValues: const [1, 5, 3, 3, 1, 3],
                  ),
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProcessingItemsListTable.header(
                        flexValues: const [1],
                        values: [
                          Text(
                            labelShippingAddress.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: AppColors().primaryHeaderTextColor,
                                    ),
                          )
                        ],
                      ),
                      ProcessingItemsListTable.normal(
                        values: [
                          Text(
                            getAddressString(
                              address: viewModel.orderDetails.shippingAddress,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                        flexValues: [1],
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                wSizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProcessingItemsListTable.header(
                        flexValues: const [1],
                        values: [
                          Text(
                            labelBillingAddress.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: AppColors().primaryHeaderTextColor,
                                    ),
                          )
                        ],
                      ),
                      ProcessingItemsListTable.normal(
                        values: [
                          Text(
                            getAddressString(
                              address: viewModel.orderDetails.billingAddress,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                        flexValues: [1],
                      ),
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class OrderSummaryItemViewWidget extends StatelessWidget {
  const OrderSummaryItemViewWidget({
    Key? key,
    required this.label,
    required this.value,
  })  : isCustomChild = false,
        customChild = null,
        super(key: key);

  const OrderSummaryItemViewWidget.customChild({
    Key? key,
    required this.customChild,
  })  : isCustomChild = true,
        label = '',
        value = '',
        super(key: key);

  final Widget? customChild;
  final bool isCustomChild;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors().white,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.5,
        ),
      ),
      child: isCustomChild
          ? customChild
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
    );
  }
}
