import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/screens/login_helper/login_helper_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:stacked/stacked.dart';

class LoginHelperView extends StatelessWidget {
  const LoginHelperView.showInLogin({
    Key? key,
  })  : showFooterView = false,
        super(key: key);

  final bool showFooterView;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double maxWidthOfOuterContainer = screenWidth * 0.45;
    double maxWidthOfItems = screenWidth * 0.40;

    return ViewModelBuilder<LoginHelperViewModel>.reactive(
      builder: (context, model, child) => Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   screenWidth.toString(),
            // ),
            // Text(
            //   screenHeight.toString(),
            // ),
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                maxWidth: maxWidthOfOuterContainer,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: maxWidthOfItems,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'HOW TO GET APP?',
                                style: TextStyle(
                                  fontSize: 36,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'SCAN',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 48,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' QR CODE',
                                      style: TextStyle(
                                          color: AppColors()
                                              .loginPageQrCodeTextColor,
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Image.asset(
                            qrCodeImage,
                            width: 162,
                            height: 179,
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
                    const Text(
                      'Download Application to Register and Reset Password.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (showFooterView) const Spacer(),
            if (showFooterView)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Of Geek Technotonic @2021',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Terms and Conditions',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        wSizedBox(width: 16),
                        Text('Privacy Policy',
                            style: Theme.of(context).textTheme.caption),
                        wSizedBox(width: 16),
                        Text('Cookies Policy',
                            style: Theme.of(context).textTheme.caption),
                      ],
                    )
                  ],
                ),
              ),
          ],
        ),
        elevation: Dimens().getDefaultElevation,
        color: AppColors().white,
      ),
      viewModelBuilder: () => LoginHelperViewModel(),
    );
  }
}
