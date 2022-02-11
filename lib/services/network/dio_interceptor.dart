import 'package:dio/dio.dart';
import 'package:scm/routes/routes_constants.dart';

import 'package:scm/app/app.logger.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/di.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/login_reasons.dart';
import 'package:scm/model_classes/refresh_token_response.dart';
import 'package:scm/services/network/api_endpoints.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked_services/stacked_services.dart' as stacked_service;

class ApiServiceAppDioInterceptor extends QueuedInterceptor {
  List<RequestOptions> apisQueue = [];
  final log = getLogger('ApiServiceAppDioInterceptor');
  bool refreshTokenApiLoading = false;
  Dio refreshTokenDioClient = Dio();
  // void setRefreshTokenListner(
  //     Function({required RequestOptions requestOptions}) onFetchRefreshToken) {
  //   this.onFetchRefreshToken = onFetchRefreshToken;
  // }

  RequestInterceptorHandler requestInterceptorHandler =
      RequestInterceptorHandler();

  // late final Function({required RequestOptions requestOptions})
  //     onFetchRefreshToken;
  final AppPreferencesService _appPreferences =
      locator<AppPreferencesService>();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Map<String, dynamic> headersMap = err.response?.data ?? {};
      if (headersMap.isNotEmpty) {
        String tokenStatus = headersMap[TOKEN_STATUS] ?? '';
        if (tokenStatus == EXPIRED) {
          if (refreshTokenApiLoading) {
            apisQueue.add(err.requestOptions);
          } else {
            apisQueue.add(err.requestOptions);
            refreshTokenApiLoading = true;
            refreshTokenDioClient.get(REFRESH_TOKEN).then(
              (value) {
                //Refresh token success
                RefreshTokenResponse refreshTokenResponse =
                    RefreshTokenResponse.fromJson(value.data);
                locator<AppPreferencesService>()
                    .saveApiToken(tokenString: refreshTokenResponse.token);

                for (var requestOption in apisQueue) {
                  // onRequest(requestOption, requestInterceptorHandler);
                  requestInterceptorHandler.next(requestOption);
                }
              },
            ).onError(
              (error, stackTrace) {
                //Refresh token failure
                _appPreferences.clearPreferences();
                takeToLoginPage(
                  description: invalidTokenDescription,
                );
                // locator<stacked_service.NavigationService>()
                //     .clearStackAndShow(
                //   mainViewRoute,
                //   arguments: SplashScreenArguments(
                //     reasons: LoginReasons(
                //       title: invalidTokenTitle,
                //       description: invalidTokenDescription,
                //     ),
                //   ),
                // );
              },
            );
          }
        } else if (tokenStatus == INVALID_TOKEN) {
          _appPreferences.clearPreferences();
          takeToLoginPage(
            description: invalidTokenDescription,
          );
          // locator<stacked_service.NavigationService>().clearStackAndShow(
          //   mainViewRoute,
          //   arguments: SplashScreenArguments(
          //     reasons: LoginReasons(
          //       title: invalidTokenTitle,
          //       description: invalidTokenDescription,
          //     ),
          //   ),
          // );
        } else {
          return handler.next(
            getErrors(
              error: err,
            ),
          );
        }
      }
      // return handler.next(e);
    } else {
      return handler.next(
        getErrors(
          error: err,
        ),
      );
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    requestInterceptorHandler = handler;
    if (options.path != USER_AUTH) {
      if (options.path != USER_AUTH) {
        if (options.path == REFRESH_TOKEN) {
          options.headers.addAll({"isRefreshToken": true});
        }
        // if (EnvironmentConfig.SHOW_LOGS) {
        log.wtf("Api Token :: ${_appPreferences.getApiToken()}");
        // }
        options.headers.addAll(
          getAuthHeader(
            token: _appPreferences.getApiToken(),
          ),
        );
      }
    }
    return handler.next(options); //continue
  }

  void takeToLoginPage({required String description}) {
    _appPreferences.clearPreferences();
    locator<stacked_service.NavigationService>().clearStackAndShow(
      mainViewRoute,
      arguments: LoginReasons(
        title: invalidTokenTitle,
        description: description,
      ),
    );
  }

  void setDioOptions({required BaseOptions options}) {
    refreshTokenDioClient.options = options;
  }

  DioError getErrors({required DioError error}) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        // TODO: Handle this case.
        break;
      case DioErrorType.sendTimeout:
        // TODO: Handle this case.
        break;
      case DioErrorType.receiveTimeout:
        // TODO: Handle this case.
        break;
      case DioErrorType.response:
        // TODO: Handle this case.
        break;
      case DioErrorType.cancel:
        // TODO: Handle this case.
        break;
      case DioErrorType.other:
        if (error.error.message == 'Connection failed') {
          error = DioError(
            response:
                Response(statusCode: 100, requestOptions: error.requestOptions),
            requestOptions: error.requestOptions,
          );
        } else {
          error = DioError(
            response:
                Response(statusCode: 700, requestOptions: error.requestOptions),
            requestOptions: error.requestOptions,
          );
        }
        // TODO: Handle this case.
        break;
    }
    return error;
  }
}
