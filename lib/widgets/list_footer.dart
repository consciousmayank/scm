import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:stacked_services/stacked_services.dart';

class ListFooter extends StatelessWidget {
  const ListFooter.firstLast({
    Key? key,
    required this.pageNumber,
    this.onJumpToPage,
    required this.totalPages,
    required this.onFirstPageClick,
    required this.onLastPageClick,
    this.onPreviousPageClick,
    this.onNextPageClick,
    this.showJumpToPage = false,
  })  : allIcons = false,
        super(key: key);

  const ListFooter.firstPreviousNextLast({
    Key? key,
    required this.pageNumber,
    required this.totalPages,
    required this.onFirstPageClick,
    this.onJumpToPage,
    required this.onLastPageClick,
    required this.onPreviousPageClick,
    this.showJumpToPage = false,
    required this.onNextPageClick,
  })  : allIcons = false,
        super(key: key);

  const ListFooter.previousNext({
    Key? key,
    required this.pageNumber,
    required this.totalPages,
    required this.onPreviousPageClick,
    required this.onNextPageClick,
    this.showJumpToPage = false,
    this.onJumpToPage,
    this.onFirstPageClick,
    this.onLastPageClick,
  })  : allIcons = false,
        super(key: key);

  const ListFooter.previousNextCompact({
    Key? key,
    required this.pageNumber,
    required this.totalPages,
    required this.onPreviousPageClick,
    required this.onNextPageClick,
    this.onFirstPageClick,
    this.showJumpToPage = false,
    this.onJumpToPage,
    this.onLastPageClick,
  })  : allIcons = true,
        super(key: key);

  final Function({required int pageNumber})? onJumpToPage;
  final Function? onFirstPageClick;
  final Function? onLastPageClick;
  final Function? onNextPageClick;
  final Function? onPreviousPageClick;
  final int pageNumber;
  final bool allIcons, showJumpToPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors().primaryColor.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (onFirstPageClick != null)
            TextButton.icon(
              style: AppTextButtonsStyles().textButtonStyle,
              onPressed: pageNumber == 0 || onFirstPageClick == null
                  ? null
                  : () {
                      onFirstPageClick?.call();
                    },
              icon: const Icon(
                Icons.arrow_left,
              ),
              label: const Text('First Page'),
            ),
          if (onPreviousPageClick != null)
            TextButton.icon(
              style: AppTextButtonsStyles().textButtonStyle,
              onPressed: pageNumber == 0 || onPreviousPageClick == null
                  ? null
                  : () {
                      onPreviousPageClick?.call();
                    },
              icon: const Icon(
                Icons.arrow_left,
              ),
              label: allIcons
                  ? const SizedBox.shrink()
                  : const Text('Previous Page'),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: !showJumpToPage
                ? Text('Page ${pageNumber + 1} of ${totalPages + 1}')
                : Row(
                    children: [
                      const Text(
                        'Page ',
                      ),
                      SizedBox(
                        width: 80,
                        child: AppTextField(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          formatter: <TextInputFormatter>[
                            Dimens().getNumericTextInputFormatter,
                          ],
                          initialValue: (pageNumber + 1).toString(),
                          onFieldSubmitted: (value) {
                            if (int.parse(value) <= 0) {
                              onJumpToPage?.call(
                                pageNumber: 0,
                              );
                            } else if (int.parse(value) >= totalPages) {
                              onJumpToPage?.call(
                                pageNumber: totalPages,
                              );
                            } else {
                              onJumpToPage?.call(
                                pageNumber: int.parse(
                                  value,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      // DropdownButton<int>(
                      //   value: pageNumber + 1,
                      //   icon: Icon(
                      //     Icons.arrow_drop_down,
                      //     color: AppColors().primaryColor.shade900,
                      //   ),
                      //   iconSize: 30,
                      //   underline: Container(),
                      //   onChanged: (int? value) {
                      //     onJumpToPage?.call(pageNumber: value ?? 0);
                      //   },
                      //   items: [for (var i = 1; i < totalPages; i++) i]
                      //       .map<DropdownMenuItem<int>>(
                      //     (int location) {
                      //       return DropdownMenuItem<int>(
                      //         child: Text(
                      //           location.toString(),
                      //         ),
                      //         value: location,
                      //       );
                      //     },
                      //   ).toList(),
                      // ),
                      Text(
                        ' of ${totalPages + 1}',
                      ),
                    ],
                  ),
          ),
          if (onNextPageClick != null)
            TextButton.icon(
              style: AppTextButtonsStyles().textButtonStyle,
              onPressed: pageNumber == (totalPages) ||
                      onNextPageClick == null ||
                      totalPages < 0
                  ? null
                  : () {
                      onNextPageClick?.call();
                    },
              icon:
                  allIcons ? const SizedBox.shrink() : const Text('Next Page'),
              label: const Icon(
                Icons.arrow_right,
              ),
            ),
          if (onLastPageClick != null)
            TextButton.icon(
              style: AppTextButtonsStyles().textButtonStyle,
              onPressed: pageNumber == (totalPages) || onLastPageClick == null
                  ? null
                  : () {
                      onLastPageClick?.call();
                    },
              icon: const Text('Last Page'),
              label: const Icon(
                Icons.arrow_right,
              ),
            ),
        ],
      ),
    );
  }
}
