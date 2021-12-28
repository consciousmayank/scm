import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/discard_product/diascard_product_dialog_box_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DiscardProductReasonDialogBoxView extends StatefulWidget {
  const DiscardProductReasonDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _DiscardProductReasonDialogBoxViewState createState() =>
      _DiscardProductReasonDialogBoxViewState();
}

class _DiscardProductReasonDialogBoxViewState
    extends State<DiscardProductReasonDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    DiscardProductReasonDialogBoxViewArguments arguments =
        widget.request.data as DiscardProductReasonDialogBoxViewArguments;
    return ViewModelBuilder<DiscardProductReasonDialogBoxViewModel>.reactive(
      onModelReady: (model) =>
          model.init(arguments: arguments, completer: widget.completer),
      viewModelBuilder: () => DiscardProductReasonDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          contentPadding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.20,
            right: MediaQuery.of(context).size.width * 0.20,
            top: MediaQuery.of(context).size.width * 0.10,
            bottom: MediaQuery.of(context).size.width * 0.10,
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                AppTextField(
                  maxLines: 5,
                  maxCharacters: Dimens().maxSummaryLength,
                  hintText: 'Enter reason for discarding product',
                  onTextChange: (value) => model.reason = value,
                  onFieldSubmitted: (value) {
                    model.reason = value;
                    model.discardProduct();
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                  height: Dimens().buttonHeight,
                  child: TextButton(
                    onPressed: () {
                      model.discardProduct();
                    },
                    child: const Text(labelSubmit),
                    style: AppTextButtonsStyles().textButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiscardProductReasonDialogBoxViewArguments {
  DiscardProductReasonDialogBoxViewArguments({
    required this.title,
    required this.productToDiscard,
  });

  final Product productToDiscard;
  final String title;
}
