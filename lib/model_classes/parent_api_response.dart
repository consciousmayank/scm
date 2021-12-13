import 'package:dio/dio.dart';
import 'package:scm/app/di.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:stacked_services/stacked_services.dart' as stackedService;

class ParentApiResponse {
  ParentApiResponse({
    this.error,
    this.response,
  });

  final String accessDenied = 'You are not authorized.';
  final String allPuccExpired = 'All Pucc Expired.';
  final String badCredentials = 'Bad Credentials.';
  final String defaultError = 'Something went wrong.';
  final String emptyResult = 'No record exists.';
  final DioError? error;
  final String noInternet =
      'You are not connected to Internet. Please Try Again.';

  final String noResource = 'Resource does not exists.';
  final Response? response;

  void handleExpiredToken() {
    Map<String, dynamic>? headersMap = this.error?.response?.headers.map;
    if (headersMap != null) {
      /// if header does not contains the key ['tokenstatus']
      if (!headersMap.containsKey('tokenstatus')) {
        di<stackedService.SnackbarService>().showCustomSnackBar(
            message: error?.response?.data['message'],
            variant: SnackbarType.ERROR);
        return;
      } else {
        /// if header contains the the key ['tokenstatus']
        // headersMap.forEach((key, value) {
        //   log('from map');
        //   log('$key ---BASE API-- $value');
        //   if (key == 'tokenstatus') {
        //     if (value != null) {
        //       List? tokenStatusList = value as List;
        //
        //       /// if Bearer token is  [EXPIRED]
        //       /// hit the refresh token api
        //       if (tokenStatusList.first == 'EXPIRED') {
        //         locator<SignUpViewModel>().refreshToken();
        //
        //         locator<stackedService.SnackbarService>().showSnackbar(
        //           message:
        //               'Get the new token last one got ${tokenStatusList.first}',
        //         );
        //         return null;
        //       } else {
        //         /// if
        //         MyPreferences().saveApiToken(tokenString: null);
        //         locator<stackedService.NavigationService>()
        //             .clearStackAndShow(mainViewRoute);
        //       }
        //     }
        //   }
        // });
      }
    }
  }

  bool isNoDataFound() {
    return response?.statusCode == 204;
  }

  String? getErrorReason() {
    if (this.error?.response == null) {
      return this.error?.message ?? '';
    } else {
      switch (this.error?.response?.statusCode) {
        case 100:
          return noInternet;
        case 101:
          return allPuccExpired;
          break;
        case 401:
          return badCredentials;
          break;
        case 403:
          return accessDenied;
          break;
        // case 400:
        //   ApiResponse response =
        //       ApiResponse.fromMap(this.error?.response?.data);
        //   return response.message;
        case 204:
          return emptyResult;
          break;
        case 404:
          return noResource;
          break;
        default:
          return defaultError;
      }
    }
  }
}
