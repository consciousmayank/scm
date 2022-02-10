import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/app_themes_types.dart';
import 'package:scm/model_classes/login_reasons.dart';
import 'package:scm/screens/login/login_viewmodel.dart';
import 'package:scm/screens/login_helper/login_helper_view.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
    this.arguments,
  }) : super(key: key);

  final LoginViewArgs? arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => model.init(args: arguments),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: model.getLoginLabel(),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: LoginHelperView.showInLogin(),
                flex: 7,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 64,
                  ),
                  child: model.isBusy
                      ? const LoadingWidget()
                      : Card(
                          elevation: Dimens().getDefaultElevation,
                          shape: Dimens().getCardShape(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Image.asset(
                                    scmLogo,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                                Text(
                                  appName,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                hSizedBox(
                                  height: 16,
                                ),
                                AppTextField(
                                  innerHintText: 'Your Registered Mobile',
                                  controller: model.userNameController,
                                  focusNode: model.userNameFocusNode,
                                  hintText: labelUserName,
                                  onFieldSubmitted: (value) {
                                    model.userNameFocusNode.unfocus();
                                    model.passwordFocusNode.requestFocus();
                                  },
                                ),
                                hSizedBox(
                                  height: 16,
                                ),
                                AppTextField(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  innerHintText: 'Your Password',
                                  obscureText: !model.isPasswordVisible,
                                  buttonType: ButtonType.SMALL,
                                  buttonIcon: model.isPasswordVisible
                                      ? const Icon(
                                          Icons.visibility_off,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          size: 20,
                                        ),
                                  onButtonPressed: () {
                                    model.isPasswordVisible =
                                        !model.isPasswordVisible;
                                    model.notifyListeners();
                                  },
                                  hintText: labelPassword,
                                  controller: model.passwordController,
                                  focusNode: model.passwordFocusNode,
                                  onFieldSubmitted: (value) => model.login(),
                                ),
                                hSizedBox(
                                  height: 16,
                                ),
                                AppButton(
                                  disabled: false,
                                  buttonBg: AppColors().loginPageBg,
                                  onTap: model.login,
                                  buttonTextColor: Colors.white,
                                  title: labelLoginButton,
                                ),
                                hSizedBox(
                                  height: 32,
                                ),
                                FutureBuilder<String>(
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return NullableTextWidget(
                                        stringValue: snapshot.data,
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      return const NullableTextWidget(
                                        stringValue: '',
                                      );
                                    }
                                  },
                                  future: model.getAppVersion(),
                                ),
                                hSizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class LoginViewArgs {
  LoginViewArgs({this.reasons});

  final LoginReasons? reasons;
}
