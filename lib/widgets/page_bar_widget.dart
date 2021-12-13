import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class PageBarWidget extends StatefulWidget {
  const PageBarWidget({
    Key? key,
    required this.title,
    this.subTitle,
    this.showBackButton,
    this.options,
  }) : super(key: key);

  const PageBarWidget.withBackArrowAndText({
    Key? key,
    required this.title,
    required this.showBackButton,
    this.subTitle,
    this.options,
  }) : super(key: key);

  const PageBarWidget.withBackArrowOnly({
    Key? key,
    this.title,
    this.options,
    this.subTitle,
    required this.showBackButton,
  }) : super(key: key);

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
      padding: const EdgeInsets.all(16.0),
      color: AppColors().white,
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
                widget.subTitle == null
                    ? Container()
                    : Text(
                        " - ${widget.subTitle!}",
                        style: Dimens().pageSubTitleHeadingStyle,
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
