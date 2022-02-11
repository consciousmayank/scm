import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/model_classes/address.dart' as demanders_address;
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class CartDeliveryAddressListView extends ViewModelWidget<CartPageViewModel> {
  const CartDeliveryAddressListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CartPageViewModel viewModel) {
    return viewModel.busy(getAddressListBusyObject)
        ? const Center(
            child:
                LoadingWidgetWithText(text: 'Fetching Addresses. Please Wait'),
          )
        : Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: AppTableWidget.values(
              requiresPadding: false,
              values: [
                AppTableSingleItem.customWidget(
                  Column(
                    children: [
                      const AppTableWidget.header(
                        // requiresPadding: false,
                        values: [
                          AppTableSingleItem.string(
                            'Delivery Address',
                            // textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                            //       color: AppColors().primaryHeaderTextColor,
                            //     ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: viewModel.addressList.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) => Stack(
                                  children: [
                                    RadioListTile<demanders_address.Address>(
                                      isThreeLine: true,
                                      contentPadding: const EdgeInsets.all(4),
                                      title: Text(
                                        viewModel.addressList[index].toString(),
                                      ),
                                      value: viewModel.addressList
                                          .elementAt(index),
                                      groupValue: viewModel.selectedAddress,
                                      onChanged: (value) {
                                        if (value != null) {
                                          viewModel.setSelectedAddress(
                                            selectedAddress: value,
                                          );
                                        }
                                      },
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AppButton(
                                            toolTipMessage: labelEditAddress,
                                            buttonBg:
                                                AppColors().buttonGreenColor,
                                            onTap: () {
                                              viewModel.addAddress(
                                                  selectedAddress: viewModel
                                                      .addressList
                                                      .elementAt(index));
                                            },
                                            leading: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: AppColors().white,
                                            ),
                                          ),
                                          wSizedBox(width: 8),
                                          AppButton(
                                            toolTipMessage: labelDeleteAddress,
                                            buttonBg:
                                                AppColors().buttonRedColor,
                                            onTap: () {
                                              viewModel.deleteAddress(
                                                  selectedAddress: viewModel
                                                      .addressList
                                                      .elementAt(index));
                                            },
                                            leading: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: AppColors().white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
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
                      AppButton(
                        buttonBg: AppColors().buttonGreenColor,
                        title: labelAddNewAddress,
                        onTap: () {
                          viewModel.addAddress();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
