import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/order_status_timeline_widget.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:stacked/stacked.dart';

class OrderProcessButtonsWidget
    extends ViewModelWidget<OrderListPageViewModel> {
  const OrderProcessButtonsWidget({
    Key? key,
  }) : super(key: key);

  Widget buildOrderButtons({
    required Function() onTap,
    required String buttonText,
    required Color buttonBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      // height: 50,
      child: SizedBox(
        height: AppBar().preferredSize.height,
        child: AppButton(
          buttonBg: buttonBg,
          onTap: onTap,
          title: buttonText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    switch (viewModel.orderDetails.status) {
      case 'CREATED':
        return Row(
          children: [
            Expanded(
              // child: OrderStatusTimeLineWidget(),
              child: Container(),
              flex: 2,
            ),
            Expanded(
              child: buildOrderButtons(
                buttonBg: AppColors().buttonRedColor,
                buttonText: 'REJECT',
                onTap: () {
                  viewModel.rejectOrder(
                    orderId: viewModel.orderDetails.id,
                  );
                },
              ),
              flex: 1,
            ),
            wSizedBox(width: 5),
            Expanded(
              child: buildOrderButtons(
                buttonBg: AppColors().buttonGreenColor,
                buttonText: 'ACCEPT',
                onTap: () {
                  viewModel.acceptOrder(
                    orderId: viewModel.orderDetails.id,
                  );
                },
              ),
              flex: 1,
            ),
          ],
        );
      case 'PROCESSING':
        return Row(
          children: [
            Expanded(
              // child: OrderStatusTimeLineWidget(),
              child: Container(),
              flex: 4,
            ),
            Expanded(
              flex: 1,
              child: buildOrderButtons(
                buttonBg: AppColors().buttonGreenColor,
                buttonText: 'Continue',
                onTap: () {
                  for (var element in viewModel.orderDetails.orderItems!) {
                    element = element.copyWith(
                      itemPrice: element.itemQuantity! * element.itemPrice!,
                    );
                  }

                  viewModel.shippingStatusConfirmation(
                    finalisedOrderList: viewModel.orderDetails.orderItems,
                  );
                  // bool isValid = true;

                  // for (var element in viewModel.orderDetails.orderItems!) {
                  //   int index =
                  //       viewModel.orderDetails.orderItems!.indexOf(element);

                  //   // if (element.itemQuantity != null &&
                  //   //     element.itemQuantity! < 1) {
                  //   //   viewModel.showErrorSnackBar(
                  //   //       message: errorQuantityRequired,
                  //   //       onSnackBarOkButton: () {
                  //   //         viewModel.quantityEditingFocusnodes
                  //   //             .elementAt(index)
                  //   //             .requestFocus();
                  //   //       });
                  //   //   isValid = false;
                  //   //   break;
                  //   // } else if (element.itemPrice != null &&
                  //   //     element.itemPrice! < 1) {
                  //   //   viewModel.showErrorSnackBar(
                  //   //       message: errorPriceRequired,
                  //   //       onSnackBarOkButton: () {
                  //   //         viewModel.priceEditingFocusnodes
                  //   //             .elementAt(index)
                  //   //             .requestFocus();
                  //   //       });
                  //   //   isValid = false;
                  //   //   break;
                  //   // } else {
                  //   //   isValid = true;
                  //   // }
                  // }

                  // if (isValid) {
                  //   viewModel.updateOrder();
                  // }
                },
              ),
            ),
          ],
        );
      case 'INTRANSIT':
        return Row(
          children: [
            Expanded(
              // child: OrderStatusTimeLineWidget(),
              child: Container(),
              flex: 4,
            ),
            Expanded(
              flex: 1,
              child: buildOrderButtons(
                buttonBg: AppColors().buttonGreenColor,
                buttonText: 'DELIVER',
                onTap: () {
                  viewModel.openDeliveryDetailsDialogBox(
                    orderId: viewModel.orderDetails.id,
                    amount: viewModel.orderDetails.totalAmount,
                  );
                },
              ),
            ),
          ],
        );
      case 'DELIVERED':
        // return const OrderStatusTimeLineWidget();
        return Container();
      case 'CANCELLED':
        // return const OrderStatusTimeLineWidget();
        return Container();

      default:
        return Container();
    }
  }
}
