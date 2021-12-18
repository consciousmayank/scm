import 'package:flutter/material.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/update_product_dialog/update_product_dialog_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UpdateProductDialogBoxView extends StatefulWidget {
  const UpdateProductDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _UpdateProductDialogBoxViewState createState() =>
      _UpdateProductDialogBoxViewState();
}

class _UpdateProductDialogBoxViewState
    extends State<UpdateProductDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    UpdateProductDialogBoxViewArguments arguments =
        widget.request.data as UpdateProductDialogBoxViewArguments;
    return ViewModelBuilder<UpdateProductDialogBoxViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      viewModelBuilder: () => UpdateProductDialogBoxViewModel(),
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
          child: AddProductView(
            arguments: AddProductViewArguments(
                productToEdit: arguments.product,
                onProductUpdated: () {
                  widget.completer(DialogResponse(
                    confirmed: true,
                  ));
                }),
          ),
        ),
      ),
    );
  }
}

class UpdateProductDialogBoxViewArguments {
  UpdateProductDialogBoxViewArguments({
    required this.title,
    required this.product,
  });

  final Product product;
  final String title;
}
