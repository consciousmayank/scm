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
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      // height: 50,
      child: SizedBox(
        height: AppBar().preferredSize.height,
        child: AppButton(
          onTap: onTap,
          buttonText: buttonText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, OrderListPageViewModel viewModel) {
    switch (viewModel.orderDetails.status) {
      case 'CREATED':
        return Container(
          height: AppBar().preferredSize.height * 1.5,
          // color: Colors.red,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors().white,
            // color: Colors.red,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppColors.shadesOfBlack[400]!,
                  blurRadius: 3,
                  offset: Offset(0.0, 0.75))
            ],
            // color: Colors.red,
          ),
          child: Row(
            children: [
              Expanded(
                child: buildOrderButtons(
                  buttonText: 'REJECT',
                  onTap: () {
                    viewModel.rejectOrder(
                      orderId: viewModel.orderDetails.id,
                    );
                  },
                ),
              ),
              wSizedBox(width: 5),
              Expanded(
                child: buildOrderButtons(
                  buttonText: 'ACCEPT',
                  onTap: () {
                    viewModel.acceptOrder(
                      orderId: viewModel.orderDetails.id,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      case 'PROCESSING':
        return Container(
          height: AppBar().preferredSize.height * 1.5,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors().white,
            // color: Colors.red,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppColors.shadesOfBlack[400]!,
                  blurRadius: 3,
                  offset: Offset(0.0, 0.75))
            ],
            // color: Colors.red,
          ),
          child: buildOrderButtons(
            buttonText: 'Continue',
            onTap: () {
              viewModel.orderDetails.orderItems!.forEach((element) {
                int index = viewModel.orderDetails.orderItems!.indexOf(element);
                if (element.itemQuantity == 0) {
                  viewModel.showErrorSnackBar(
                      message: errorQuantityRequired,
                      onSnackBarOkButton: () {
                        viewModel.quantityEditingFocusnodes
                            .elementAt(index)
                            .requestFocus();
                      });
                } else if (element.itemPrice == 0) {
                  viewModel.showErrorSnackBar(
                      message: errorPriceRequired,
                      onSnackBarOkButton: () {
                        viewModel.priceEditingFocusnodes
                            .elementAt(index)
                            .requestFocus();
                      });
                } else {
                  viewModel.updateOrder();
                }
              });
            },
          ),
        );
      case 'INTRANSIT':
        return Container(
          height: AppBar().preferredSize.height * 1.5,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors().white,
            // color: Colors.red,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppColors.shadesOfBlack[400]!,
                  blurRadius: 3,
                  offset: Offset(0.0, 0.75))
            ],
            // color: Colors.red,
          ),
          child: buildOrderButtons(
            buttonText: 'DELIVER',
            onTap: () {
              viewModel.openDeliveryDetailsDialogBox(
                orderId: viewModel.orderDetails.id,
              );
            },
          ),
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
