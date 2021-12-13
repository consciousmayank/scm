import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/services/network/api_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/routes/routes_constants.dart';

abstract class BaseApi {
  ApiService apiService = di<ApiService>();
  AppPreferences preferences = di<AppPreferences>();
  SnackbarService snackBarService = di<SnackbarService>();

  ParentApiResponse? filterResponse(ParentApiResponse apiResponse,
      {bool showSnackBar = true}) {
    ParentApiResponse returningResponse = apiResponse;
    if (apiResponse.error == null) {
      if (apiResponse.isNoDataFound()) {
        if (showSnackBar) {
          snackBarService.showSnackbar(
              message:
                  ParentApiResponse(error: null, response: null).emptyResult);
        }
      } else {
        returningResponse = ParentApiResponse(
            error: apiResponse.error, response: apiResponse.response);
      }
    } else {
      if (apiResponse.error?.response?.statusCode == 401) {
        // if (preferences.getUserLoggedIn() != null) {
        //   preferences.setLoggedInUser(null);
        //   preferences.saveCredentials(null);
        //   preferences.saveSelectedClient(null);
        //   locator<NavigationService>().clearStackAndShow(logInPageRoute);
        //   snackBarService.showSnackbar(
        //       message: ParentApiResponse(
        //     error: null,
        //     response: null,
        //   ).badCredentials);
        //   return null;
        // }
      } else if (apiResponse.error?.response?.statusCode == 400) {
        snackBarService.showCustomSnackBar(
          message: apiResponse.error?.response?.data['message'],
          variant: SnackbarType.ERROR,
          duration: const Duration(seconds: 5),
        );
      } else if (apiResponse.error?.response?.statusCode == 500) {
        snackBarService.showCustomSnackBar(
          message: apiResponse.error?.response?.data['errors'].first,
          title: apiResponse.error?.response?.data['status'],
          variant: SnackbarType.ERROR,
          duration: const Duration(seconds: 5),
        );
      } else {
        if (showSnackBar) {
          snackBarService.showSnackbar(
            message: apiResponse.getErrorReason() ?? "",
          );
        }
      }

      return null;
    }

    return returningResponse;
  }
}
