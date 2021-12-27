import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';

class ProcessingItemsListTable extends StatelessWidget {
  final List<Widget> values;
  final List<int> flexValues;
  // final List<TextAlign> textAlignValues;
  final bool isHeader;
  const ProcessingItemsListTable.normal({
    Key? key,
    required this.values,
    required this.flexValues,
    // required this.textAlignValues,
  })  : isHeader = false,
        assert(flexValues.length == values.length,
            'flexValues.length != values.length'),
        super(key: key);

  const ProcessingItemsListTable.header({
    Key? key,
    required this.values,
    required this.flexValues,
    // required this.textAlignValues,
  })  : isHeader = true,
        assert(flexValues.length == values.length,
            'flexValues.length != values.length'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          color: isHeader ? AppColors().orderDetailsContainerBg : Colors.white,
          border: Border.all(
            color: AppColors().orderDetailsContainerBg,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: values
              .map(
                (e) => Expanded(
                  child: values.elementAt(
                    values.indexOf(
                      e,
                    ),
                  ),
                  flex: flexValues.elementAt(
                    values.indexOf(
                      e,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}