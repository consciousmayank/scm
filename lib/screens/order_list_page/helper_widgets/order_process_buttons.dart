import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/screens/order_list_page/order_list_page_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:stacked/stacked.dart';

class OrderPorcessButtonsWidget
    extends ViewModelWidget<OrderListPageViewModel> {
  const OrderPorcessButtonsWidget({
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
        height: AppBar().preferredSize.height * 0.8,
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
              child: Container(),
              flex: 2,
            ),
            Expanded(
              flex: 1,
              child: buildOrderButtons(
                buttonBg: AppColors().buttonGreenColor,
                buttonText: 'Continue',
                onTap: () {
                  bool isValid = true;

                  for (var element in viewModel.orderDetails.orderItems!) {
                    int index =
                        viewModel.orderDetails.orderItems!.indexOf(element);
                    if (element.itemQuantity != null &&
                        element.itemQuantity! < 1) {
                      viewModel.showErrorSnackBar(
                          message: errorQuantityRequired,
                          onSnackBarOkButton: () {
                            viewModel.quantityEditingFocusnodes
                                .elementAt(index)
                                .requestFocus();
                          });
                      isValid = false;
                      break;
                    } else if (element.itemPrice != null &&
                        element.itemPrice! < 1) {
                      viewModel.showErrorSnackBar(
                          message: errorPriceRequired,
                          onSnackBarOkButton: () {
                            viewModel.priceEditingFocusnodes
                                .elementAt(index)
                                .requestFocus();
                          });
                      isValid = false;
                      break;
                    } else {
                      isValid = true;
                    }
                  }

                  if (isValid) {
                    viewModel.updateOrder();
                  }
                },
              ),
            ),
          ],
        );
      case 'INTRANSIT':
        return Row(
          children: [
            Expanded(
              child: Container(),
              flex: 2,
            ),
            Expanded(
              flex: 1,
              child: buildOrderButtons(
                buttonBg: AppColors().buttonGreenColor,
                buttonText: 'DELIVER',
                onTap: () {
                  viewModel.openDeliveryDetailsDialogBox(
                    orderId: viewModel.orderDetails.id,
                  );
                },
              ),
            ),
          ],
        );
      case 'DELIVERED':
      // return Container(
      //   height: AppBar().preferredSize.height * 1.5,
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.all(8),
      //   decoration: BoxDecoration(
      //     color: Colors.green,
      //     boxShadow: <BoxShadow>[
      //       BoxShadow(
      //           color: AppColors.shadesOfBlack[400]!,
      //           blurRadius: 3,
      //           offset: Offset(0.0, 0.75))
      //     ],
      //     // color: Colors.red,
      //   ),
      //   child: Center(
      //     child: Text(
      //       'Order has been Delivered.',
      //       style: Theme.of(context).textTheme.headline4!.copyWith(
      //             color: AppColors().white,
      //           ),
      //     ),
      //   ),
      // );
      case 'CANCELLED':
      // return Container(
      //   height: AppBar().preferredSize.height * 1.5,
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.all(8),
      //   decoration: BoxDecoration(
      //     color: Colors.red,
      //     boxShadow: <BoxShadow>[
      //       BoxShadow(
      //           color: AppColors.shadesOfBlack[400]!,
      //           blurRadius: 3,
      //           offset: Offset(0.0, 0.75))
      //     ],
      //     // color: Colors.red,
      //   ),
      //   child: Center(
      //     child: Text(
      //       'Order has been Cancelled.',
      //       style: Theme.of(context).textTheme.headline4!.copyWith(
      //             color: AppColors().white,
      //           ),
      //     ),
      //   ),
      // );

      default:
        return Container();
    }
  }
}
