import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    Key? key,
    this.title,
    this.disabled = false,
    this.onTap,
    this.leading,
    this.toolTipMessage,
    this.suffix,
    this.titleTextStyle,
    this.buttonTextColor = Colors.black,
    this.buttonBg = Colors.white,
  })  : outline = false,
        padding = const EdgeInsets.all(0),
        super(key: key);

  const AppButton.appbar({
    Key? key,
    required this.title,
    this.disabled = false,
    this.onTap,
    this.leading,
    this.suffix,
    this.buttonTextColor = Colors.black,
    this.titleTextStyle,
    this.buttonBg = Colors.white,
    this.toolTipMessage,
  })  : outline = false,
        padding = const EdgeInsets.symmetric(
          vertical: 8,
        ),
        super(key: key);

  const AppButton.outline(
      {Key? key,
      this.title,
      this.onTap,
      this.leading,
      this.suffix,
      this.buttonBg = Colors.white,
      this.toolTipMessage,
      this.buttonTextColor = Colors.black,
      this.titleTextStyle,
      this.disabled = false})
      : padding = const EdgeInsets.all(0),
        outline = true;

  final void Function()? onTap;
  final Color buttonBg, buttonTextColor;
  final bool disabled;
  final Widget? leading;
  final bool outline;
  final EdgeInsets padding;
  final Widget? suffix;
  final String? title, toolTipMessage;
  final TextStyle? titleTextStyle;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool hover = false;

  Widget getChild({required BuildContext context}) {
    return Padding(
      padding: widget.padding,
      child: AppInkwell.withBorder(
        borderderRadius: BorderRadius.circular(8),
        onHover: (value) {
          if (value) {
            setState(() {
              hover = true;
            });
          } else {
            setState(() {
              hover = false;
            });
          }
        },
        onTap: widget.onTap,
        child: Material(
          elevation: hover ? 5 : 0,
          borderRadius: BorderRadius.circular(8),
          color: widget.outline
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              height: Dimens().buttonHeight + 4,
              alignment: Alignment.center,
              decoration: !widget.outline
                  ? BoxDecoration(
                      color:
                          !widget.disabled ? widget.buttonBg : widget.buttonBg,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.buttonBg,
                        width: 1,
                      ),
                    ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null) widget.leading!,
                  if (widget.title != null) SizedBox(width: 5),
                  if (widget.title != null)
                    Text(
                      widget.title!,
                      style: widget.titleTextStyle?.copyWith(
                            fontWeight:
                                hover ? FontWeight.w800 : FontWeight.normal,
                            color: !widget.outline
                                ? widget.buttonTextColor
                                : Colors.black,
                          ) ??
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight:
                                    hover ? FontWeight.w800 : FontWeight.normal,
                                color: !widget.outline
                                    ? widget.buttonTextColor
                                    : Colors.black,
                              ),
                    ),
                  if (widget.title != null) SizedBox(width: 5),
                  if (widget.suffix != null) widget.suffix!,
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.toolTipMessage != null
        ? Tooltip(
            waitDuration: const Duration(
              seconds: 3,
            ),
            message: widget.toolTipMessage,
            child: getChild(context: context),
          )
        : getChild(context: context);
  }
}
