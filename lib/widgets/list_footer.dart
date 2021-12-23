import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/styles.dart';

class ListFooter extends StatelessWidget {
  const ListFooter.firstLast(
      {Key? key,
      required this.pageNumber,
      required this.totalPages,
      required this.onFirstPageClick,
      required this.onLastPageClick,
      this.onPreviousPageClick,
      this.onNextPageClick})
      : super(key: key);

  const ListFooter.firstPreviousNextLast({
    Key? key,
    required this.pageNumber,
    required this.totalPages,
    required this.onFirstPageClick,
    required this.onLastPageClick,
    required this.onPreviousPageClick,
    required this.onNextPageClick,
  }) : super(key: key);

  const ListFooter.previousNext({
    Key? key,
    required this.pageNumber,
    required this.totalPages,
    required this.onPreviousPageClick,
    required this.onNextPageClick,
    this.onFirstPageClick,
    this.onLastPageClick,
  }) : super(key: key);

  final Function? onFirstPageClick;
  final Function? onLastPageClick;
  final Function? onNextPageClick;
  final Function? onPreviousPageClick;
  final int pageNumber;
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
              label: const Text('Previous Page'),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Page ${pageNumber + 1} of ${totalPages + 1}',
            ),
          ),
          if (onNextPageClick != null)
            TextButton.icon(
              style: AppTextButtonsStyles().textButtonStyle,
              onPressed: pageNumber == (totalPages) || onNextPageClick == null
                  ? null
                  : () {
                      onNextPageClick?.call();
                    },
              icon: const Text('Next Page'),
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
