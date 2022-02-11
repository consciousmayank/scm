import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_delivery_address_list_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_list_view_widget.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/placed_order_view.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/screens/order_list_page/helper_widgets/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/orderitem_row_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_order_widget_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_table_widget.dart';
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
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const NotSupportedScreensView(),
      tablet: (BuildContext context) => const NotSupportedScreensView(),
      desktop: (BuildContext context) =>
          ViewModelBuilder<CartPageViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
          appBar: appbarWidget(
              context: context,
              title: labelCart,
              automaticallyImplyLeading: true,
              options: model.orderPlaced
                  ? null
                  : [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: Text(
                            'Total Items: ${model.cart.cartItems?.length}',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: AppColors().white,
                                    ),
                          ),
                        ),
                      ),
                    ]),
          body: model.orderPlaced
              ? const PlacedOrderView()
              : model.busy(cartApiBusyObject) ||
                      model.busy(placeOrderApiStatusApiBusyObject)
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
                            child: model.busy(cartApiBusyObject)
                                ? Container()
                                : Card(
                                    shape: Dimens().getCardShape(),
                                    color: AppColors().white,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const AppTableWidget.header(
                                                values: [
                                                  AppTableSingleItem.string(
                                                    'SUPPLIER DETAILS',
                                                    flexValue: 1,
                                                  )
                                                ],
                                              ),
                                              AppTableWidget.values(
                                                values: [
                                                  AppTableSingleItem.string(
                                                    'Name : ${model.responseSupplierDetails.businessName}',
                                                    flexValue: 1,
                                                  )
                                                ],
                                              ),
                                              AppTableWidget.values(
                                                values: [
                                                  AppTableSingleItem.string(
                                                    'Contact Person : ${model.responseSupplierDetails.contactPerson}',
                                                    flexValue: 1,
                                                  )
                                                ],
                                              ),

                                              AppTableWidget.values(
                                                values: [
                                                  AppTableSingleItem.string(
                                                    'Contact Number : ${model.responseSupplierDetails.contactNumber()}',
                                                    flexValue: 1,
                                                  )
                                                ],
                                              ),

                                              AppTableWidget.values(
                                                values: [
                                                  AppTableSingleItem
                                                      .customWidget(
                                                    AppButton(
                                                      buttonBg: Theme.of(
                                                              context)
                                                          .primaryColorLight,
                                                      title:
                                                          'Add More products of same Supplier',
                                                      onTap: model.cart
                                                                  .supplyId ==
                                                              null
                                                          ? null
                                                          : () => model
                                                              .takeToProductsPageOfSelectedSupplier(),
                                                    ),
                                                    flexValue: 1,
                                                  )
                                                ],
                                              ),

                                              // OrderSummaryItemViewWidget(
                                              //   label: 'NAME',
                                              //   value: model.responseSupplierDetails
                                              //           .businessName ??
                                              //       '--',
                                              // ),
                                            ],
                                          ),
                                        ),
                                        hSizedBox(
                                          height: 16,
                                        ),
                                        const Flexible(
                                          child: CartDeliveryAddressListView(),
                                          flex: 1,
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
      ),
    );
  }
}
