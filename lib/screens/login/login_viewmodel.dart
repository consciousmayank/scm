import 'package:flutter/widgets.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/user_authenticate_response.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/app_api_service_classes/login_apis.dart';
import 'package:scm/utils/strings.dart';

class LoginViewModel extends GeneralisedBaseViewModel {
  bool isPasswordVisible = false;
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  final LoginApi _loginApi = di<LoginApi>();

  void login() async {
    if (userNameController.text.trim().isEmpty) {
      showErrorSnackBar(message: errorUserNameRequired);
      return;
    } else if (passwordController.text.trim().isEmpty) {
      showErrorSnackBar(message: errorPasswordRequired);
    } else {
      setBusy(true);
      UserAuthenticateResponse authenticateResponse = await _loginApi.login(
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (authenticateResponse.token != null) {
        userNameController.clear();
        passwordController.clear();
        //save token
        preferences.saveApiToken(tokenString: authenticateResponse.token);
        //save username
        preferences.setAuthenticatedUserName(
            user: authenticateResponse.username);

        if (authenticateResponse.authorities != null) {
          //authenticated user has roles.
          if (authenticateResponse.authorities!.length == 1) {
            //this is a data entry user
            preferences.setSelectedUserRole(
                userRole: authenticateResponse.authorities!.first);
            navigationService.replaceWith(pimHomeScreenRoute);
          } else {
            //this is a demand or supply user
            preferences.setAuthenticatedUserRoles(
                userRoles: authenticateResponse.authorities!);
            showInfoSnackBar(
                message:
                    'View is coming Soon for this user role ${authenticateResponse.authorities!.join(',')}');
          }
        } else {
          showErrorSnackBar(
              message:
                  'You don\'t have any role assigned to you. Hence no access to the app');
        }
      }
      setBusy(false);
    }
  }

  String getLoginLabel() {
    if (EnvironmentConfig.BASE_URL == EnvironmentConfig.LOCAL_URL) {
      return labelLogin2(url: 'Local');
    } else if (EnvironmentConfig.BASE_URL ==
        EnvironmentConfig.LOCAL_LAPTOP_URL) {
      return labelLogin2(url: 'Local LapTop');
    } else {
      return labelLogin2(url: 'Global');
    }
  }
}
