import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:stacked_services/stacked_services.dart';

class DeliveryDetilasDialogBoxView extends StatefulWidget {
  const DeliveryDetilasDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _DeliveryDetilasDialogBoxViewState createState() =>
      _DeliveryDetilasDialogBoxViewState();
}

class _DeliveryDetilasDialogBoxViewState
    extends State<DeliveryDetilasDialogBoxView> {
  FocusNode deliverByFocusNode = FocusNode();
  TextEditingController deliverByTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildQtyTextFormField() {
    return AppTextField(
      // maxLines: 2,
      keyboardType: TextInputType.streetAddress,
      hintText: 'e.g. VIKAS, UK07CA8178',
      onFieldSubmitted: (_) {
        // fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter deliver by';
        }
        return null;
      },
      controller: deliverByTextController,
      focusNode: deliverByFocusNode,
    );
  }

  @override
  Widget build(BuildContext context) {
    DeliveryDetilasDialogBoxViewArguments arguments =
        widget.request.data as DeliveryDetilasDialogBoxViewArguments;
    return CenteredBaseDialog(
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please fill delivery details',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                hSizedBox(height: 10),
                buildQtyTextFormField(),
                hSizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    buttonBg: AppColors().buttonGreenColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.completer(
                          DialogResponse(
                            confirmed: true,
                            data: DeliveryDetilasDialogBoxViewOutArguments(
                              deliveredBy: deliverByTextController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    title: 'SAVE',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryDetilasDialogBoxViewArguments {
  DeliveryDetilasDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}

class DeliveryDetilasDialogBoxViewOutArguments {
  DeliveryDetilasDialogBoxViewOutArguments({required this.deliveredBy});

  final String deliveredBy;
}
