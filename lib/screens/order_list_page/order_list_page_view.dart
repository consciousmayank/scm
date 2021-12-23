import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/order_list_widget.dart';
import 'package:scm/widgets/product/product_list/product_list_item/product_list_item.dart';
import 'package:stacked/stacked.dart';

class OrderListPageView extends StatelessWidget {
  const OrderListPageView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final OrderListPageViewArguments arguments;

  String getAddressString({required Address? address}) {
    if (address == null) {
      return '';
    }
    return '${address.addressLine1}, ${address.addressLine2}, \n${address.locality} ${address.nearby}, \n${address.city}, ${address.state}, ${address.country}, ${address.pincode}';
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderListPageViewModel>.reactive(
      onModelReady: (model) => model.init(arguments),
      builder: (context, model, child) => Scaffold(
        body: getValueForScreenType(
          context: context,
          mobile: Container(),
          tablet: Container(),
          desktop: Row(
            children: [
              Expanded(
                child: model.orderListApi == ApiStatus.LOADING
                    ? const LoadingWidgetWithText(
                        text: 'Fetching Orders. Please Wait...')
                    : OrderListWidget.orderPage(
                        onOrderClick: ({
                          required Order selectedOrder,
                        }) {
                          model.selectedOrder = selectedOrder;
                          model.getOrdersDetails();
                        },
                        label: labelOrders,
                        isScrollable: true,
                        isSupplyRole: model.preferences.getSelectedUserRole() ==
                            AuthenticatedUserRoles.ROLE_SUPPLY.getStatusString,
                        orders: model.orderList.orders!,
                        onNextPageClick: () {
                          model.pageNumber++;
                          model.getOrderList();
                        },
                        onPreviousPageClick: () {
                          model.pageNumber--;
                          model.getOrderList();
                        },
                        pageNumber: model.pageNumber,
                        totalPages: model.orderList.totalPages! - 1,
                      ),
                flex: 1,
              ),
              Expanded(
                child: model.orderDetailsApi == ApiStatus.LOADING
                    ? const LoadingWidgetWithText(
                        text: 'Fetching Orders. Please Wait...')
                    : Card(
                        shape: Dimens().getCardShape(),
                        color: AppColors().white,
                        elevation: Dimens().getDefaultElevation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                labelOrderDetail,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            hSizedBox(
                              height: 8,
                            ),
                            Flexible(
                              child: CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: OrderItemContainerWidget(
                                      child: Column(
                                        children: [
                                          OrderItemRowWidget(
                                            label: 'Order Id',
                                            value: model.orderDetails.id
                                                .toString(),
                                          ),
                                          OrderItemRowWidget(
                                            label: 'Total Amount',
                                            value: model
                                                .orderDetails.totalAmount
                                                .toString(),
                                          ),
                                          OrderItemRowWidget(
                                            label: 'Total Items',
                                            value: model.orderDetails.totalItems
                                                .toString(),
                                          ),
                                          OrderItemRowWidget(
                                            label: 'Order Placed On',
                                            value: model
                                                .orderDetails.createDateTime
                                                .toString(),
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
                                  SliverToBoxAdapter(
                                    child: OrderItemContainerWidget(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              labelShippingAddress,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getAddressString(
                                                address: model.orderDetails
                                                    .shippingAddress,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
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
                                  SliverToBoxAdapter(
                                    child: OrderItemContainerWidget(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              labelBillingAddress,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getAddressString(
                                                address: model.orderDetails
                                                    .billingAddress,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
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
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        labelProductItems,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) =>
                                          Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: OrderItemContainerWidget(
                                          child: ProductListItem(
                                            arguments: ProductListItemArguments(
                                              productTitle: model
                                                  .orderDetails.orderItems!
                                                  .elementAt(index)
                                                  .itemTitle,
                                              productCategory:
                                                  'X${model.orderDetails.orderItems!.elementAt(index).itemQuantity}',
                                              productPrice: model
                                                  .orderDetails.orderItems!
                                                  .elementAt(index)
                                                  .itemTotalPrice,
                                              onAddButtonClick: () {},
                                              onProductClick: () {},
                                              // image: getProductImage(model, index),
                                              image: getProductImage(
                                                productImage: null,
                                              ),
                                              productId: model
                                                  .orderDetails.orderItems!
                                                  .elementAt(index)
                                                  .itemId,
                                              measurementUnit: '',
                                              measurement: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      childCount:
                                          model.orderDetails.orderItems == null
                                              ? 0
                                              : model.orderDetails.orderItems!
                                                  .length,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => OrderListPageViewModel(),
    );
  }
}

class OrderListPageViewArguments {}

class OrderItemRowWidget extends StatelessWidget {
  const OrderItemRowWidget({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class OrderItemContainerWidget extends StatelessWidget {
  const OrderItemContainerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimens().getDefaultRadius,
          ),
        ),
        color: AppColors().white,
        border: Border.all(
          color: AppColors().productListItemWebCategoryContainerBg,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
