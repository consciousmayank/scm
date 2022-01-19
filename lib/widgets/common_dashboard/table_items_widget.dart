import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

class TopOrderedBrandsCategoryTable extends StatelessWidget {
  const TopOrderedBrandsCategoryTable.header({
    Key? key,
    this.values = const ['#', 'NAME', 'COUNT'],
    this.isHeader = true,
  }) : super(key: key);

  const TopOrderedBrandsCategoryTable.values({
    Key? key,
    required this.values,
    this.isHeader = false,
  }) : super(key: key);

  final bool isHeader;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isHeader
                  ? Theme.of(context).colorScheme.background
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).colorScheme.background,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                values[0],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isHeader
                  ? Theme.of(context).colorScheme.background
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).colorScheme.background,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                values[1],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          flex: 4,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: isHeader
                  ? Theme.of(context).colorScheme.background
                  : Colors.white,
              border: Border.all(
                color: Theme.of(context).colorScheme.background,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                values[2],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          flex: 3,
        ),
      ],
    );
  }
}
