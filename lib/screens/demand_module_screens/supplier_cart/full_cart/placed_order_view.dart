import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_viewmodel.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/lottie_animation_widget.dart';
import 'package:stacked/stacked.dart';

class PlacedOrderView extends ViewModelWidget<CartPageViewModel> {
  const PlacedOrderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, CartPageViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              LottieStopAnimation(
                args: LottieStopAnimationArgs(
                  animation: successAnimation,
                  repeatAnimation: true,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              SizedBox(
                height: 100,
                child: Center(
                  child: DefaultTextStyle(
                    style: GoogleFonts.nunitoSans(
                      fontSize: 42,
                      color: AppColors().black,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        ScaleAnimatedText('Congratulations!',
                            textStyle: Theme.of(context).textTheme.headline6,
                            duration: const Duration(
                              seconds: 2,
                            )),
                        ScaleAnimatedText('Order Placed Successfully!',
                            textStyle: Theme.of(context).textTheme.headline5,
                            duration: const Duration(
                              seconds: 4,
                            )),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: viewModel.getLatestOrdersListApi == ApiStatus.LOADING
              ? const LoadingWidget()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Your Last Order',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: OrderListPageView(
                        arguments: OrderListPageViewArguments.notification(
                          orderId: viewModel.orderList.orders!.first.id,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        buttonTextColor: AppColors().white,
                        buttonBg: Theme.of(context).primaryColor,
                        title: 'Continue Shooping',
                        onTap: () => viewModel.navigationService.back(),
                      ),
                    )
                  ],
                ),
          flex: 2,
        )
      ],
    );
  }
}
