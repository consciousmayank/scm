import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_delivery_address_list_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_list_view_widget.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/screens/order_list_page/helper_widgets/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/orderitem_row_widget.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({
    Key? key,
  }) : super(key: key);

  @override
  _CartPageViewState createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartPageViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: appbarWidget(
          context: context,
          title: labelCart,
          automaticallyImplyLeading: true,
        ),
        body: model.cartApiStatus == ApiStatus.LOADING
            ? const Center(
                child: LoadingWidgetWithText(
                  text: 'Fetching Cart. Please Wait...',
                ),
              )
            : Row(
                children: [
                  const Expanded(
                    child: CartListViewWidget(),
                    flex: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        4.0,
                      ),
                      child: model.cartApiStatus == ApiStatus.LOADING
                          ? Container()
                          : Card(
                              shape: Dimens().getCardShape(),
                              color: AppColors().white,
                              child: Column(
                                children: [
                                  hSizedBox(
                                    height: 16,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: OrderItemContainerWidget(
                                      child: Column(
                                        children: [
                                          OrderItemRowWidget
                                              .noValueWithLabelStyle(
                                            label: 'Order Summary',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          OrderItemRowWidget.customPadding(
                                            padding: const EdgeInsets.all(0),
                                            label: 'Total Items',
                                            value: '#${model.cart.totalItems}',
                                          ),
                                          OrderItemRowWidget.customPadding(
                                            padding: const EdgeInsets.all(0),
                                            label: 'Supplier',
                                            value: '${model.supplierName}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  hSizedBox(
                                    height: 16,
                                  ),
                                  const Flexible(
                                    child: CartDeliveryAddressListView(),
                                    flex: 2,
                                  ),
                                  hSizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: Dimens().buttonHeight,
                                    width: double.infinity,
                                    child: AppButton(
                                      onTap: model.selectedAddress == null
                                          ? null
                                          : () {
                                              model.placeOrder();
                                            },
                                      title: labelPlaceOrder,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
      ),
      viewModelBuilder: () => CartPageViewModel(),
    );
  }
}
