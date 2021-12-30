import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/cart_icon/cart_icon_viewmodel.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';

class CartIconView extends StatefulWidget {
  final CartIconViewArguments arguments;
  const CartIconView({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  @override
  _CartIconViewState createState() => _CartIconViewState();
}

class _CartIconViewState extends State<CartIconView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartIconViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  12.0,
                ),
                child: Image.asset(
                  cartIcon,
                  height: 80,
                  width: 80,
                  color: AppColors().primaryColor.shade50,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: NullableTextWidget.int(
                  intValue: model.getCartApiStatus == ApiStatus.LOADING
                      ? null
                      : model.cart.totalItems,
                  textStyle: Theme.of(context).textTheme.button,
                ),
                decoration: BoxDecoration(
                  color: AppColors().primaryColor.shade300,
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => CartIconViewModel(),
    );
  }
}

class CartIconViewArguments {}
