import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

class ColumnWithTitle extends StatelessWidget {
  const ColumnWithTitle({
    Key? key,
    required this.title,
    required this.child,
    this.titleWidthFull = true,
    this.dialogClose,
  })  : noColorOnTop = false,
        super(key: key);

  const ColumnWithTitle.noColorOnTop({
    Key? key,
    required this.title,
    required this.child,
    this.titleWidthFull = true,
    this.dialogClose,
  })  : noColorOnTop = true,
        super(key: key);

  final Function()? dialogClose;
  final Widget child;
  final bool titleWidthFull, noColorOnTop;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Dimens().getCardShape(),
      color: AppColors().white,
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
              color: noColorOnTop ? null : Theme.of(context).primaryColorLight,
            ),
            padding: EdgeInsets.all(
              Dimens().getColumnWithTitleHeaderPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  title,
                  style: AppTextStyles(
                    context: context,
                  ).getColumnWithTitleTextStyle,
                ),
                if (dialogClose != null)
                  AppInkwell(
                    child: Icon(
                      Icons.close,
                      color:
                          noColorOnTop ? AppColors().black : AppColors().white,
                    ),
                    onTap: dialogClose,
                  )
              ],
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
