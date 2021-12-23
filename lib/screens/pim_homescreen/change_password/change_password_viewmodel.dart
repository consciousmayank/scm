import 'package:flutter/cupertino.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/user_authenticate_response.dart';
import 'package:scm/screens/pim_homescreen/change_password/change_password_view.dart';
import 'package:scm/services/app_api_service_classes/login_apis.dart';
import 'package:scm/utils/strings.dart';

class ChangePasswordViewModel extends GeneralisedBaseViewModel {
  late final ChangePasswordViewArguments args;
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();
  TextEditingController currentPasswordController = TextEditingController();
  FocusNode currentPasswordFocusNode = FocusNode();
  bool isConfirmPasswordVisible = false;
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isPasswordsMatch = true;
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();

  final LoginApi _loginApi = di<LoginApi>();

  void changePassword() async {
    if (currentPasswordController.text.trim().isEmpty) {
      showErrorSnackBar(
          message: errorCurrentPasswordRequired,
          onSnackBarOkButton: () {
            currentPasswordFocusNode.requestFocus();
          });
      return;
    } else if (newPasswordController.text.trim().isEmpty) {
      showErrorSnackBar(
          message: errorNewPasswordRequired,
          onSnackBarOkButton: () {
            newPasswordFocusNode.requestFocus();
          });
      return;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      showErrorSnackBar(
          message: errorConfirmPasswordRequired,
          onSnackBarOkButton: () {
            confirmPasswordFocusNode.requestFocus();
          });
      return;
    } else if (confirmPasswordController.text.trim() !=
        newPasswordController.text.trim()) {
      isPasswordsMatch = false;
      notifyListeners();
      showErrorSnackBar(
        message: errorPasswordsDontMatch,
      );
      return;
    } else {
      setBusy(true);
      UserAuthenticateResponse authenticateResponse =
          await _loginApi.changePassword(
        userName: preferences.getAuthenticatedUserName(),
        password: currentPasswordController.text,
        newPassword: newPasswordController.text.trim(),
      );

      if (authenticateResponse.token != null) {
        //save token
        preferences.saveApiToken(tokenString: authenticateResponse.token);
        //save username
        preferences.setAuthenticatedUserName(
            user: authenticateResponse.username);

        args.onPasswordChangeSuccess();
      }
      setBusy(false);
    }
  }

  init({required ChangePasswordViewArguments arguments}) {
    args = arguments;
  }
}
