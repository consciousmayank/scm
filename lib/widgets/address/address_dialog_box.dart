import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/widgets/address/address_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AddressDialogBoxView extends StatefulWidget {
  const AddressDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _AddressDialogBoxViewState createState() => _AddressDialogBoxViewState();
}

class _AddressDialogBoxViewState extends State<AddressDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    AddressDialogBoxViewArguments arguments =
        widget.request.data as AddressDialogBoxViewArguments;
    return RightSidedBaseDialog(
      arguments: RightSidedBaseDialogArguments(
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: AddressView(
          arguments: AddressViewArguments(
            selectedAddress: arguments.selectedAddress,
            onSubmit: ({
              required Address address,
            }) {
              widget.completer(DialogResponse(
                  data: AddressDialogBoxViewOutArguments(
                    selectedAddress: address,
                  ),
                  confirmed: true));
            },
          ),
        ),
      ),
    );
  }
}

class AddressDialogBoxViewArguments {
  AddressDialogBoxViewArguments({
    required this.title,
    this.selectedAddress,
  });

  final Address? selectedAddress;
  final String title;
}

class AddressDialogBoxViewOutArguments {
  AddressDialogBoxViewOutArguments({
    required this.selectedAddress,
  });

  final Address selectedAddress;
}
