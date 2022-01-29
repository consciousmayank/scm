import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/more_options/more_options_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<MoreOptionsViewModel>.reactive(
      onModelReady: (model) => model.init(args: arguments),
      builder: (context, model, child) => Scaffold(
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: model.orderStatuses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getValueForScreenType(
              context: context,
              mobile: 1,
              tablet: 2,
              desktop: 3,
            ),
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            mainAxisExtent: screenHeight * 0.50,
          ),
          itemBuilder: (BuildContext context, int index) {
            return AppInkwell.withBorder(
              onTap: () {
                model.takeToOrderReports(
                  orderStatus: model.orderStatuses.values.elementAt(
                    index,
                  ),
                );
              },
              borderderRadius: Dimens().getBorderRadius(),
              child: Card(
                shape: Dimens().getCardShape(),
                color: AppColors().white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      model.orderIcons.elementAt(
                        index,
                      ),
                      height: screenHeight * 0.30,
                      width: screenHeight * 0.30,
                    ),
                    hSizedBox(height: 8),
                    Text(
                      model.orderStatuses.keys
                          .elementAt(
                            index,
                          )
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // ListView.separated(
        //   itemBuilder: (context, index) => ListTile(
        //     leading: model.optionsList.elementAt(index).icon,
        //     onTap: model.optionsList.elementAt(index).onPressed,
        //     title: Text(model.optionsList
        //         .elementAt(
        //           index,
        //         )
        //         .title),
        //     subtitle: Text(
        //       model.optionsList
        //           .elementAt(
        //             index,
        //           )
        //           .subTitle,
        //     ),
        //   ),
        //   separatorBuilder: (context, index) => const DottedDivider(),
        //   itemCount: model.optionsList.length,
        // ),
      ),
      viewModelBuilder: () => MoreOptionsViewModel(),
    );
  }
}

class MoreOptionsViewArguments {}
