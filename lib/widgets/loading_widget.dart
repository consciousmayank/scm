import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 100,
      width: 100,
      child: Padding(
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
