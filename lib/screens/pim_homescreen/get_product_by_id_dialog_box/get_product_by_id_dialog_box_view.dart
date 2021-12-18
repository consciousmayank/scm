import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/get_product_by_id_dialog_box/get_product_by_id_dialog_box_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GetProductByIdDialogBoxView extends StatefulWidget {
  const GetProductByIdDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _GetProductByIdDialogBoxViewState createState() =>
      _GetProductByIdDialogBoxViewState();
}

class _GetProductByIdDialogBoxViewState
    extends State<GetProductByIdDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    GetProductByIdDialogBoxViewArguments arguments =
        widget.request.data as GetProductByIdDialogBoxViewArguments;
    return ViewModelBuilder<GetProductByIdDialogBoxViewModel>.reactive(
      viewModelBuilder: () => GetProductByIdDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          contentPadding: const EdgeInsets.only(
            left: 50,
            right: 50,
            top: 20,
            bottom: 20,
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Column(
            children: [
              AppTextField(
                formatter: <TextInputFormatter>[
                  Dimens().getNumericTextInputFormatter,
                ],
                controller: model.productIdController,
                autoFocus: true,
                hintText: labelEnterProductId,
                buttonIcon: Icon(model.productIdController.text.isEmpty
                    ? Icons.search
                    : Icons.close),
                buttonType: ButtonType.SMALL,
                onButtonPressed: model.productIdController.text.isEmpty
                    ? () {
                        model.getProductById(
                          productId: int.parse(
                            model.productIdController.text.trim(),
                          ),
                        );
                      }
                    : () {
                        model.productIdFocusNode.requestFocus();
                        model.productIdController.clear();
                        model.product = null;
                        model.notifyListeners();
                      },
                onFieldSubmitted: (value) {
                  model.productIdFocusNode.requestFocus();
                  model.getProductById(
                    productId: int.parse(
                      value.trim(),
                    ),
                  );
                },
                onTextChange: (value) {
                  if (value.isEmpty) {
                    model.notifyListeners();
                  }
                },
              ),
              hSizedBox(height: 8),
              Flexible(
                child: model.product == null
                    ? const Center(
                        child: Text(labelEnterValidProductId),
                      )
                    : AddProductView(
                        key: UniqueKey(),
                        arguments: AddProductViewArguments(
                          productToEdit: model.product,
                          onProductUpdated: () {
                            widget.completer(
                              DialogResponse(
                                confirmed: true,
                              ),
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GetProductByIdDialogBoxViewArguments {
  GetProductByIdDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}
