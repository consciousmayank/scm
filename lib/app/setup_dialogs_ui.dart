import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_dialog_box_view.dart';
import 'package:scm/screens/pim_homescreen/discard_product/discard_product_dialog_box.dart';
import 'package:scm/screens/pim_homescreen/get_product_by_id_dialog_box/get_product_by_id_dialog_box_view.dart';
import 'package:scm/screens/pim_homescreen/update_product_dialog/update_product_dialog_view.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:scm/widgets/column_with_title.dart';
import 'package:scm/widgets/delivery_details_dialog_box.dart';
import 'package:scm/widgets/product/filter/filters_dialog_box_view.dart';
import 'package:scm/widgets/product/product_details/product_add_to_cart_dialogbox_view.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = di<DialogService>();
  final builders = {
    DialogType.BASIC: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.NEW_GPS_REQUEST: (context, sheetRequest, completer) =>
        _NewGpsRequestDialog(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.BRANDS_LIST_DIALOGBOX: (context, sheetRequest, completer) =>
        BrandsDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.UPDATE_PRODUCT: (context, sheetRequest, completer) =>
        UpdateProductDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.GET_PRODUCT_BY_ID: (context, sheetRequest, completer) =>
        GetProductByIdDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.ChANGE_PASSWORD: (context, sheetRequest, completer) =>
        ChangePasswordViewDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.PRODUCT_DETAILS: (context, sheetRequest, completer) =>
        ProductDetailDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.PRODUCTS_FILTER: (context, sheetRequest, completer) =>
        ProductFilterDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.DELIVERY_DETAILS: (context, sheetRequest, completer) =>
        DeliveryDetilasDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.DISCARD_PRODUCT: (context, sheetRequest, completer) =>
        DiscardProductReasonDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
    DialogType.ADD_PRODUCT_TO_CART: (context, sheetRequest, completer) =>
        ProductAddToCartDialogBoxView(
          request: sheetRequest,
          completer: completer,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  const _BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container() /* Build your dialog UI here */
        );
  }
}

class _NewGpsRequestDialog extends StatelessWidget {
  const _NewGpsRequestDialog({
    required this.request,
    required this.completer,
  });

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  Widget build(BuildContext context) {
    NewGpsRequestDialogInputArguments arguments = request.data;

    return CenteredBaseDialog(
      arguments: CenteredBaseDialogArguments(
        request: request,
        completer: completer,
        title: 'New Gps Request',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '${arguments.vendorName} has raised a new GPS Request.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Dimens().buttonHeight,
                    child: AppButton(
                        onTap: () {
                          completer(
                            DialogResponse(
                              confirmed: false,
                            ),
                          );
                        },
                        buttonText: 'Later'),
                  ),
                  flex: 1,
                ),
                wSizedBox(
                  width: 4,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: Dimens().buttonHeight,
                    child: AppButton(
                        onTap: () {
                          completer(
                            DialogResponse(
                              confirmed: true,
                            ),
                          );
                        },
                        buttonText: 'Process'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RightSidedBaseDialogArguments {
  RightSidedBaseDialogArguments({
    required this.request,
    required this.completer,
    required this.title,
    required this.child,
  });

  final Function(DialogResponse) completer;
  final Widget child;
  final DialogRequest request;
  final String title;
}

class RightSidedBaseDialog extends StatelessWidget {
  const RightSidedBaseDialog({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final RightSidedBaseDialogArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.60,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors().getColumnWithTitleHeaderColor,
            ),
            padding: EdgeInsets.all(
              Dimens().getColumnWithTitleHeaderPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    arguments.title,
                    style: AppTextStyles(
                      context: context,
                    ).getColumnWithTitleTextStyle.copyWith(
                          color: AppColors().white,
                        ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors().white,
                  ),
                  onPressed: () {
                    arguments.completer(DialogResponse(
                      confirmed: false,
                    ));
                  },
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(
                8,
              ),
              child: arguments.child,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CenteredBaseDialogArguments {
  CenteredBaseDialogArguments({
    required this.request,
    required this.completer,
    required this.title,
    required this.child,
    this.contentPadding,
  });

  final Function(DialogResponse) completer;
  final Widget child;
  final EdgeInsets? contentPadding;
  final DialogRequest request;
  final String title;
}

class CenteredBaseDialog extends StatelessWidget {
  const CenteredBaseDialog({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final CenteredBaseDialogArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      insetPadding: arguments.contentPadding ??
          EdgeInsets.all(
            MediaQuery.of(context).size.height * 0.25,
          ),
      child: ColumnWithTitle(
        title: arguments.title,
        child: arguments.child,
        dialogClose: () => arguments.completer(DialogResponse(
          confirmed: false,
        )),
      ),
    );
  }
}

class NewGpsRequestDialogInputArguments {
  NewGpsRequestDialogInputArguments({
    required this.vendorName,
  });

  final String vendorName;
}
