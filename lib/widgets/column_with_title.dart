import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';

class ColumnWithTitle extends StatelessWidget {
  const ColumnWithTitle({
    Key? key,
    required this.title,
    required this.child,
    this.titleWidthFull = true,
  }) : super(key: key);

  final Widget child;
  final String title;
  final bool titleWidthFull;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Dimens().getCardShape(),
      shadowColor: Colors.black,
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: titleWidthFull ? double.infinity : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens().getDefaultRadius),
                topRight: Radius.circular(Dimens().getDefaultRadius),
              ),
              color: AppColors().getColumnWithTitleHeaderColor,
            ),
            padding: EdgeInsets.all(
              Dimens().getColumnWithTitleHeaderPadding,
            ),
            child: Text(
              title,
              style: AppTextStyles(
                context: context,
              ).getColumnWithTitleTextStyle,
            ),
          ),
          Flexible(
            flex: 1,
            child: child,
          ),
        ],
      ),
    );
  }
}
