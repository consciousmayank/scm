import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_viewmodel.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartIconView extends StatefulWidget {
  const CartIconView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CartIconViewArguments arguments;

  @override
  _CartIconViewState createState() => _CartIconViewState();
}

class _CartIconViewState extends State<CartIconView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartIconViewModel>.reactive(
      createNewModelOnInsert: false,
      disposeViewModel: true,
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => InkWell(
        onTap: () {
          if (model.cart.cartItems!.isNotEmpty) {
            model.takeToCart();
          } else {
            di<SnackbarService>().showCustomSnackBar(
              variant: SnackbarType.ERROR,
              duration: const Duration(
                seconds: 4,
              ),
              title: "Error",
              message: 'Your cart is empty. Please add some products.',
            );
          }
        },
        child: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Image.asset(
                    cartIcon,
                    height: 40,
                    width: 40,
                    color: AppColors().white,
                  ),
                ),
                Container(
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 2,
                  // ),
                  child: NullableTextWidget.int(
                    intValue: model.getCartApiStatus == ApiStatus.LOADING
                        ? null
                        : model.cart.totalItems,
                    textStyle: Theme.of(context).textTheme.button!.copyWith(
                          color: AppColors().white,
                        ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CartIconViewModel(),
    );
  }
}

class CartIconViewArguments {}
