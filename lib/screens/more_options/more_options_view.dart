import 'package:flutter/material.dart';
import 'package:scm/screens/more_options/more_options_viewmodel.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:stacked/stacked.dart';

class MoreOptionsView extends StatelessWidget {
  const MoreOptionsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final MoreOptionsViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreOptionsViewModel>.reactive(
      onModelReady: (model) => model.init(args: arguments),
      builder: (context, model, child) => Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: model.optionsList.elementAt(index).icon,
            onTap: model.optionsList.elementAt(index).onPressed,
            title: Text(model.optionsList
                .elementAt(
                  index,
                )
                .title),
            subtitle: Text(
              model.optionsList
                  .elementAt(
                    index,
                  )
                  .subTitle,
            ),
          ),
          separatorBuilder: (context, index) => const DottedDivider(),
          itemCount: model.optionsList.length,
        ),
      ),
      viewModelBuilder: () => MoreOptionsViewModel(),
    );
  }
}

class MoreOptionsViewArguments {}
