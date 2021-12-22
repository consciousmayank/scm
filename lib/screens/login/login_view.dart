import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/login/login_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final LoginViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType<double>(
              context: context,
              mobile: MediaQuery.of(context).size.width * 0.15,
              tablet: MediaQuery.of(context).size.width * 0.25,
              desktop: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
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
                          Text(
                            model.getLoginLabel(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          hSizedBox(
                            height: 16,
                          ),
                          Text(
                            labelCredentials,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          hSizedBox(
                            height: 16,
                          ),
                          AppTextField(
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
                            obscureText: !model.isPasswordVisible,
                            buttonType: ButtonType.SMALL,
                            buttonIcon: model.isPasswordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
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
                          TextButton(
                            style: AppTextButtonsStyles().textButtonStyle,
                            onPressed: model.login,
                            child: const Text(
                              labelLoginButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        )),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class LoginViewArguments {}
