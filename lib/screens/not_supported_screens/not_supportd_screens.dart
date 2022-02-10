import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/login_helper/login_helper_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NotSupportedScreensView extends StatelessWidget {
  const NotSupportedScreensView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double maxWidthOfOuterContainer = screenWidth * 0.45;
    double maxWidthOfItems = ResponsiveValue<double>(context,
        defaultValue: screenWidth * 0.40,
        valueWhen: [
          Condition.smallerThan(
            name: MOBILE,
            value: screenWidth,
          ),
        ]).value!;
    return ViewModelBuilder<LoginHelperViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color(0xFF287AA2),
        body: Padding(
          padding: EdgeInsets.all(
            ResponsiveValue<double>(
              context,
              defaultValue: 64,
              valueWhen: [
                const Condition.smallerThan(
                  name: MOBILE,
                  value: 4,
                ),
              ],
            ).value!,
          ),
          child: Material(
            borderRadius: ResponsiveValue<BorderRadius>(
              context,
              valueWhen: [
                Condition.smallerThan(
                  name: MOBILE,
                  value: BorderRadius.circular(
                    4.0,
                  ),
                ),
                Condition.smallerThan(
                  name: TABLET,
                  value: BorderRadius.circular(
                    4.0,
                  ),
                )
              ],
              defaultValue: BorderRadius.circular(
                16.0,
              ),
            ).value,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('Screen Height: $screenHeight'),
                  // Text('Screen Width: $screenWidth'),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'You seem to be on a',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ResponsiveValue<double>(
                                      context,
                                      defaultValue: 40,
                                      valueWhen: [
                                        const Condition.smallerThan(
                                          name: MOBILE,
                                          value: 14,
                                        ),
                                        const Condition.smallerThan(
                                          name: TABLET,
                                          value: 18,
                                        ),
                                      ],
                                    ).value,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' LOWER RESOLUTION,',
                                      style: TextStyle(
                                        color: AppColors()
                                            .loginPageQrCodeTextColor,
                                        fontSize: ResponsiveValue<double>(
                                          context,
                                          defaultValue: 40,
                                          valueWhen: [
                                            const Condition.smallerThan(
                                              name: MOBILE,
                                              value: 14,
                                            ),
                                            const Condition.smallerThan(
                                              name: TABLET,
                                              value: 18,
                                            ),
                                          ],
                                        ).value,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Kindly',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ResponsiveValue<double>(
                                      context,
                                      defaultValue: 40,
                                      valueWhen: [
                                        const Condition.smallerThan(
                                          name: MOBILE,
                                          value: 14,
                                        ),
                                        const Condition.smallerThan(
                                          name: TABLET,
                                          value: 18,
                                        ),
                                      ],
                                    ).value,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' DOWNLOAD OUR APP',
                                      style: TextStyle(
                                          color: AppColors()
                                              .loginPageQrCodeTextColor,
                                          fontSize: ResponsiveValue<double>(
                                            context,
                                            defaultValue: 40,
                                            valueWhen: [
                                              const Condition.smallerThan(
                                                name: MOBILE,
                                                value: 14,
                                              ),
                                              const Condition.smallerThan(
                                                name: TABLET,
                                                value: 18,
                                              ),
                                            ],
                                          ).value,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: ' for better viewing experience.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ResponsiveValue<double>(
                                          context,
                                          defaultValue: 40,
                                          valueWhen: [
                                            const Condition.smallerThan(
                                              name: MOBILE,
                                              value: 14,
                                            ),
                                            const Condition.smallerThan(
                                              name: TABLET,
                                              value: 18,
                                            ),
                                          ],
                                        ).value,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        hSizedBox(height: 32),
                        AppInkwell.withBorder(
                          borderderRadius: BorderRadius.circular(
                            Dimens().defaultBorder,
                          ),
                          onTap: () {
                            model.showDemandAppQrCodesDialogBox();
                          },
                          child: Image.asset(
                            loginPageRowIcon1,
                            width: maxWidthOfItems,
                            fit: BoxFit.cover,
                          ),
                        ),
                        hSizedBox(height: 16),
                        AppInkwell.withBorder(
                          borderderRadius: BorderRadius.circular(
                            Dimens().defaultBorder,
                          ),
                          onTap: () {
                            model.showSupplyAppQrCodesDialogBox();
                          },
                          child: Image.asset(
                            loginPageRowIcon2,
                            width: maxWidthOfItems,
                            fit: BoxFit.cover,
                          ),
                        ),
                        hSizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            elevation: Dimens().getDefaultElevation,
            color: AppColors().white,
          ),
        ),
      ),
      viewModelBuilder: () => LoginHelperViewModel(),
    );
  }
}
