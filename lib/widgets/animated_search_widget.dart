import 'package:flutter/material.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/app_textfield.dart';

class AnimatedSearchWidget extends StatefulWidget {
  const AnimatedSearchWidget({
    Key? key,
    required this.hintText,
    // required this.searchFocusNode,
    required this.onSearch,
    required this.onCrossButtonClicked,
  }) : super(key: key);

  final Function({
    required String searchTerm,
  }) onSearch;

  final String hintText;
  final Function onCrossButtonClicked;

  @override
  _AnimatedSearchWidgetState createState() => _AnimatedSearchWidgetState();
}

class _AnimatedSearchWidgetState extends State<AnimatedSearchWidget> {
  bool isSearchIconVisible = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          isSearchIconVisible = true;
        });
      } else {
        if (searchController.text.trim().isEmpty) {
          setState(() {
            isSearchIconVisible = false;
          });
        }
      }
    });

    return AnimatedContainer(
      width: isSearchIconVisible
          ? MediaQuery.of(context).size.width * 0.15
          : MediaQuery.of(context).size.width * 0.05,
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeInOut,
      child: isSearchIconVisible
          ? Row(
              children: [
                Expanded(
                  child: AppTextField(
                    autoFocus: true,
                    controller: searchController,
                    focusNode: searchFocusNode,
                    buttonType: ButtonType.SMALL,
                    buttonIcon: Icon(
                      searchController.text.trim().isEmpty
                          ? Icons.search
                          : Icons.close,
                      color: Colors.black,
                    ),
                    onTextChange: (value) {
                      if (value.isEmpty) {
                        widget.onCrossButtonClicked();
                      }
                      if (value.length > 2) {
                        widget.onSearch(searchTerm: value).call();
                      }
                    },
                    onButtonPressed: () {
                      if (searchController.text.trim().isNotEmpty) {
                        setState(() {
                          searchController.clear();
                          isSearchIconVisible = false;
                          widget.onCrossButtonClicked.call();
                        });
                      }

                      widget
                          .onSearch(searchTerm: searchController.text.trim())
                          .call();
                    },
                    onEditingComplete: () => widget
                        .onSearch(searchTerm: searchController.text.trim())
                        .call(),
                    onFieldSubmitted: (value) =>
                        widget.onSearch(searchTerm: value).call(),
                    innerHintText: widget.hintText,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.search,
                //     color: Colors.black,
                //   ),
                //   onPressed: () {
                //     widget
                //         .onSearch(
                //           searchTerm: searchController.text.trim(),
                //         )
                //         .call();
                //   },
                // ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.close,
                //     color: Colors.black,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       searchController.clear();
                //       isSearchIconVisible = false;
                //       widget.onCrossButtonClicked.call();
                //     });
                //   },
                // ),
              ],
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  isSearchIconVisible = !isSearchIconVisible;
                });
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
    );
  }
}
