import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePasswordViewDialogBoxView extends StatefulWidget {
  const ChangePasswordViewDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _ChangePasswordViewDialogBoxViewState createState() =>
      _ChangePasswordViewDialogBoxViewState();
}

class _ChangePasswordViewDialogBoxViewState
    extends State<ChangePasswordViewDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    ChangePasswordViewDialogBoxViewArguments arguments =
        widget.request.data as ChangePasswordViewDialogBoxViewArguments;
    return CenteredBaseDialog(
      arguments: CenteredBaseDialogArguments(
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.30,
          vertical: MediaQuery.of(context).size.height * 0.10,
        ),
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: ChangePasswordView(
          arguments: ChangePasswordViewArguments(
            onCancelButtonClicked: () {
              widget.completer(
                DialogResponse(
                  confirmed: false,
                ),
              );
            },
            onPasswordChangeSuccess: () {
              widget.completer(
                DialogResponse(
                  confirmed: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChangePasswordViewDialogBoxViewArguments {
  ChangePasswordViewDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}
