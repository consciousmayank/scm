import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key})
      : height = 100,
        width = 100,
        super(key: key);

  const LoadingWidget.image({Key? key})
      : height = 40,
        width = 40,
        super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: height,
      width: width,
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: CircularProgressIndicator(),
      ),
    ));
  }
}

class LoadingWidgetWithText extends StatelessWidget {
  const LoadingWidgetWithText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(text),
        ),
      ],
    );
  }
}
