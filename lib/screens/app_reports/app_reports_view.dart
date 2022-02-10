import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/screens/app_reports/app_reports_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class AppReportsView extends StatelessWidget {
  const AppReportsView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final AppReportsViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AppReportsViewModel>.reactive(
      onModelReady: (model) => model.init(args: arguments),
      builder: (context, model, child) => Scaffold(
        body: model.orderInfoApi == ApiStatus.FETCHED
            ? GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: model.orderStatuses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveValue<int>(
                    context,
                    defaultValue: 3,
                    valueWhen: const [
                      Condition.smallerThan(
                        name: MOBILE,
                        value: 1,
                      ),
                      Condition.largerThan(
                        name: TABLET,
                        value: 2,
                      )
                    ],
                  ).value!,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: screenHeight * 0.40,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return AppInkwell.withBorder(
                    onTap: model.orderStatuses
                                .elementAt(
                                  index,
                                )
                                .count <
                            1
                        ? null
                        : () {
                            model.takeToOrderReports(
                              orderStatus: model.orderStatuses
                                  .elementAt(
                                    index,
                                  )
                                  .orderStatus,
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
                            model.orderStatuses
                                .elementAt(
                                  index,
                                )
                                .title,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          hSizedBox(height: 8),
                          Text(
                            "(${model.orderStatuses.elementAt(
                                  index,
                                ).count})",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Padding(
                padding: EdgeInsets.all(
                  64,
                ),
                child: Center(
                  child: LoadingWidgetWithText(text: 'Fetching Orders Info'),
                ),
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
      viewModelBuilder: () => AppReportsViewModel(),
    );
  }
}

class AppReportsViewArguments {}
