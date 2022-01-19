import 'package:flutter/material.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/screens/order_list_page/helper_widgets/oder_item_containing_container_widget.dart';
import 'package:scm/screens/order_list_page/helper_widgets/orderitem_row_widget.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:scm/model_classes/address.dart' as demanders_address;

class CartDeliveryAddressListView extends ViewModelWidget<CartPageViewModel> {
  const CartDeliveryAddressListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CartPageViewModel viewModel) {
    return OrderItemContainerWidget(
      child: viewModel.getAddressListApiStatus == ApiStatus.LOADING
          ? const Center(
              child: LoadingWidgetWithText(
                  text: 'Fetching Addresses. Please Wait'),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OrderItemRowWidget.noValueWithLabelStyle(
                      label: 'Delivery Address',
                      labelStyle:
                          Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    AppButton(
                      leading: const Icon(Icons.add),
                      title: labelAddNewAddress,
                      onTap: () {
                        viewModel.addAddress();
                      },
                    ),
                  ],
                ),
                Flexible(
                  child: viewModel.addressList.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (context, index) =>
                              RadioListTile<demanders_address.Address>(
                            title: Text(
                              viewModel.addressList[index].toString(),
                            ),
                            value: viewModel.addressList.elementAt(index),
                            groupValue: viewModel.selectedAddress,
                            onChanged: (value) {
                              if (value != null) {
                                viewModel.setSelectedAddress(
                                  selectedAddress: value,
                                );
                              }
                            },
                            secondary: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AppButton(
                                  onTap: () {
                                    viewModel.addAddress(
                                        selectedAddress: viewModel.addressList
                                            .elementAt(index));
                                  },
                                  leading: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                  title: '',
                                ),
                                wSizedBox(width: 8),
                                AppButton(
                                  onTap: () {
                                    viewModel.deleteAddress(
                                        selectedAddress: viewModel.addressList
                                            .elementAt(index));
                                  },
                                  leading: const Icon(
                                    Icons.delete,
                                    size: 20,
                                  ),
                                  title: '',
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const DottedDivider(),
                          itemCount: viewModel.addressList.length,
                        )
                      : Center(
                          child: Text(
                            'No Addresses Found',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}