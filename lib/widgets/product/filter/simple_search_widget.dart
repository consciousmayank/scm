import 'package:flutter/material.dart';
import 'package:scm/widgets/app_textfield.dart';

class SimpleSearchWidget extends StatelessWidget {
  const SimpleSearchWidget({
    Key? key,
    required this.onSearchTermCleared,
    required this.onSearchTermEntered,
    this.searchTerm,
    required this.hintText,
    this.innerHintText,
  }) : super(key: key);

  const SimpleSearchWidget.innerHint({
    Key? key,
    required this.onSearchTermCleared,
    this.searchTerm,
    required this.onSearchTermEntered,
    this.hintText,
    required this.innerHintText,
  }) : super(key: key);

  final Function({
    required String searchTerm,
  }) onSearchTermEntered;

  final Function onSearchTermCleared;
  final String? hintText, innerHintText, searchTerm;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(
      text: searchTerm ?? '',
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTextField(
        autoFocus: true,
        controller: searchController,
        // focusNode: viewModel.foc,
        buttonType: ButtonType.SMALL,
        buttonIcon: Icon(
          searchController.text.trim().isEmpty ? Icons.search : Icons.close,
          color: Colors.black,
        ),
        onTextChange: (value) {
          if (value.isEmpty) {
            onSearchTermCleared.call();
          }
          if (value.length > 2) {
            onSearchTermEntered(searchTerm: value).call();
          }
        },
        onButtonPressed: () {
          if (searchController.text.trim().isNotEmpty) {
            searchController.clear();
            onSearchTermCleared.call();
          }
        },
        onEditingComplete: () =>
            onSearchTermEntered(searchTerm: searchController.text).call(),
        onFieldSubmitted: (value) =>
            onSearchTermEntered(searchTerm: value).call(),
        innerHintText: innerHintText,
        hintText: hintText,
      ),
    );
  }
}
