import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

class HyperLinkTextView extends StatefulWidget {
  final String text;
  final TextStyle linkStyle;
  final Function onHyperLinkTap;
  const HyperLinkTextView({
    Key? key,
    required this.linkStyle,
    required this.text,
    required this.onHyperLinkTap,
  }) : super(key: key);

  @override
  _HyperLinkTextViewState createState() => _HyperLinkTextViewState();
}

class _HyperLinkTextViewState extends State<HyperLinkTextView> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    TextStyle hyperLinkStyle = widget.linkStyle.copyWith(
      decoration: TextDecoration.underline,
    );

    return AppInkwell.withBorder(
      onHover: (value) {
        setState(() {
          hover = value;
        });
      },
      borderderRadius: Dimens().getBorderRadius(),
      onTap: () => widget.onHyperLinkTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.text,
          style: hover
              ? hyperLinkStyle.copyWith(
                  fontWeight: FontWeight.bold,
                )
              : hyperLinkStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
