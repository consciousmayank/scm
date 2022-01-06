import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/utils/utils.dart';

class PageBarWidget extends StatefulWidget {
  const PageBarWidget({
    Key? key,
    required this.title,
    this.subTitle,
    this.showBackButton,
    this.options,
  })  : filledColor = Colors.white,
        super(key: key);

  const PageBarWidget.withBackArrowAndText({
    Key? key,
    required this.title,
    required this.showBackButton,
    this.subTitle,
    this.options,
  })  : filledColor = Colors.white,
        super(key: key);

  const PageBarWidget.withBackArrowOnly({
    Key? key,
    this.title,
    this.options,
    this.subTitle,
    required this.showBackButton,
  })  : filledColor = Colors.white,
        super(key: key);

  const PageBarWidget.withCustomFiledColor({
    Key? key,
    required this.title,
    required this.filledColor,
    this.subTitle,
    this.showBackButton,
    this.options,
  }) : super(key: key);

  final Color filledColor;
  final List<Widget>? options;
  final bool? showBackButton;
  final String? title, subTitle;

  @override
  _PageBarWidgetState createState() => _PageBarWidgetState();
}

class _PageBarWidgetState extends State<PageBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      color: widget.filledColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.showBackButton == null
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors().black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                widget.title == null
                    ? Container()
                    : Text(
                        widget.title!,
                        style: Dimens().pageTitleHeadingStyle,
                      ),
                if (widget.subTitle != null) wSizedBox(width: 20),
                widget.subTitle == null
                    ? Container()
                    : Chip(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryVariant,
                        label: Text(
                          widget.subTitle!,
                          style: Dimens().pageSubTitleHeadingStyle.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
              ],
            ),
          ),
          widget.options != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: widget.options!,
                )
              : Container(),
        ],
      ),
    );
  }
}
