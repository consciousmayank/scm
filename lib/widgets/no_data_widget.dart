import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.text,
  })  : encloseInCard = true,
        encloseInSizedBox = true,
        super(key: key);

  const NoDataWidget.noCard({
    Key? key,
    required this.text,
  })  : encloseInCard = false,
        encloseInSizedBox = true,
        super(key: key);

  const NoDataWidget.noCardNoSizedBox({
    Key? key,
    required this.text,
  })  : encloseInCard = false,
        encloseInSizedBox = false,
        super(key: key);

  const NoDataWidget.noSizedBox({
    Key? key,
    required this.text,
  })  : encloseInCard = false,
        encloseInSizedBox = true,
        super(key: key);

  final bool encloseInCard;
  final bool encloseInSizedBox;
  final String text;

  getCard({
    required BuildContext context,
  }) {
    return encloseInCard
        ? Card(
            shape: Dimens().getCardShape(),
            elevation: Dimens().getDefaultElevation,
            color: Colors.white,
            child: getText(context: context),
          )
        : getText(context: context);
  }

  getText({required BuildContext context}) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return encloseInSizedBox
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width,
            child: getCard(context: context),
          )
        : getCard(context: context);
  }
}
