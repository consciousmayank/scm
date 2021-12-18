import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ChangePasswordViewArguments arguments;

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: model.isBusy
              ? const LoadingWidget()
              : Padding(
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
                        labelChangePassword,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      hSizedBox(
                        height: 16,
                      ),
                      //Current password input
                      AppTextField(
                        obscureText: !model.isCurrentPasswordVisible,
                        buttonType: ButtonType.SMALL,
                        buttonIcon: model.isCurrentPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onButtonPressed: () {
                          model.isCurrentPasswordVisible =
                              !model.isCurrentPasswordVisible;
                          model.notifyListeners();
                        },
                        hintText: labelChangePasswordOldPassword,
                        controller: model.currentPasswordController,
                        focusNode: model.currentPasswordFocusNode,
                        onFieldSubmitted: (value) {
                          model.currentPasswordFocusNode.unfocus();
                          model.newPasswordFocusNode.requestFocus();
                        },
                      ),
                      hSizedBox(
                        height: 16,
                      ),
                      AppTextField(
                        obscureText: !model.isNewPasswordVisible,
                        buttonType: ButtonType.SMALL,
                        buttonIcon: model.isNewPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onButtonPressed: () {
                          model.isNewPasswordVisible =
                              !model.isNewPasswordVisible;
                          model.notifyListeners();
                        },
                        hintText: labelChangePasswordNewPassword,
                        controller: model.newPasswordController,
                        focusNode: model.newPasswordFocusNode,
                        onFieldSubmitted: (value) {
                          model.newPasswordFocusNode.unfocus();
                          model.confirmPasswordFocusNode.requestFocus();
                        },
                        onTextChange: (value) {
                          model.newPasswordController.text.trim() == value
                              ? model.isPasswordsMatch = true
                              : model.isPasswordsMatch = false;
                          model.notifyListeners();
                        },
                      ),
                      hSizedBox(
                        height: 16,
                      ),
                      AppTextField(
                        obscureText: !model.isConfirmPasswordVisible,
                        buttonType: ButtonType.SMALL,
                        buttonIcon: model.isConfirmPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onButtonPressed: () {
                          model.isConfirmPasswordVisible =
                              !model.isConfirmPasswordVisible;
                          model.notifyListeners();
                        },
                        hintText: labelChangePasswordConfirmPassword,
                        controller: model.confirmPasswordController,
                        focusNode: model.confirmPasswordFocusNode,
                        onFieldSubmitted: (value) {
                          model.changePassword();
                        },
                        onTextChange: (value) {
                          model.newPasswordController.text.trim() == value
                              ? model.isPasswordsMatch = true
                              : model.isPasswordsMatch = false;
                          model.notifyListeners();
                        },
                      ),
                      Text(
                        model.isPasswordsMatch ? '' : errorPasswordsDontMatch,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                      hSizedBox(height: 16),
                      TextButton(
                        style: AppTextButtonsStyles().textButtonStyle,
                        onPressed: model.isPasswordsMatch &&
                                model.newPasswordController.text
                                    .trim()
                                    .isNotEmpty &&
                                model.confirmPasswordController.text.isNotEmpty
                            ? () {
                                model.changePassword();
                              }
                            : null,
                        child: const Text(
                          labelChangePassword,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      viewModelBuilder: () => ChangePasswordViewModel(),
    );
  }
}

class ChangePasswordViewArguments {
  ChangePasswordViewArguments({
    required this.onPasswordChangeSuccess,
    required this.onCancelButtonClicked,
  });

  final Function onCancelButtonClicked;
  final Function onPasswordChangeSuccess;
}
