import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/model_classes/login_reasons.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/network/api_endpoints.dart';
import 'package:scm/services/network/dio_client.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked_services/stacked_services.dart' as stacked_service;

class ApiServiceAppDioInterceptor extends QueuedInterceptor {
  Dio getTokenDioClient = Dio();
  ApiStatus refreshTokenApiStatus = ApiStatus.LOADING;
  late final Function({required RequestOptions requestOptions})
      onFetchRefreshToken;
  final AppPreferences _appPreferences = di<AppPreferences>();

  void setRefreshTokenListner(
      Function({required RequestOptions requestOptions}) onFetchRefreshToken) {
    this.onFetchRefreshToken = onFetchRefreshToken;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path != USER_AUTH) {
      if (options.path == REFRESH_TOKEN) {
        options.headers.addAll({"isRefreshToken": true});
      }
      if (EnvironmentConfig.SHOW_LOGS) {
        if (kDebugMode) {
          print("Api Token :: ${_appPreferences.getApiToken()}");
        }
      }

      // if (DioConfig.count % 5 == 0) {
      //   options.headers.addAll(
      //     getAuthHeader(
      //       token:
      //           "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5NjExODg2MzM5IiwiaXNTdXBwbHkiOnRydWUsImlzcyI6ImdlZWt0ZWNobm90b25pYyIsImV4cCI6MTY0MTkzMjgzNSwiaWF0IjoxNjQxOTA0MDM1fQ.iGrsNsM8Bs6wE9kg0IGKLiglwuhjrIrK6GgRWVeJ2E6SK1NUoH7Oa9-jE-BZvTFyvr-QOwMPMPR5H1E8NfAh2A",
      //     ),
      //   );
      // } else {
      options.headers.addAll(
        getAuthHeader(
          token: _appPreferences.getApiToken(),
        ),
      );
      // }
      options.headers.addAll(
        getAuthHeader(
          token: _appPreferences.getApiToken(),
        ),
      );
    }

    // return handler.next(options);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Map<String, dynamic> headersMap = err.response?.data ?? {};

      if (headersMap.isNotEmpty) {
        String tokenStatus = headersMap[TOKEN_STATUS] ?? '';

        if (tokenStatus == EXPIRED) {
          onFetchRefreshToken(requestOptions: err.requestOptions);
          // return;
          // refreshToken().then((value) => null);
          // _retry(err.requestOptions);
          // _appPreferences.clearPreferences();
          // di<stacked_service.NavigationService>().clearStackAndShow(
          //   mainViewRoute,
          //   arguments: LoginReasons(
          //     title: invalidTokenTitle,
          //     description: expiredTokenDescription,
          //   ),
          // );
        } else if (tokenStatus == INVALID_TOKEN) {
          takeToLoginPage(
            description: invalidTokenDescription,
          );
        }
      }

      // return handler.next(err);
    } else if (err.response?.statusCode == 404) {
      Map<String, dynamic> headersMap = err.response?.data ?? {};
      if (headersMap.isNotEmpty) {
        String message = headersMap['message'] ?? '';
        if (message.contains('INVALID EXPIRED TOKEN')) {
          takeToLoginPage(
            description: invalidTokenDescription,
          );
          return;
        }
      }
    } else {
      switch (err.type) {
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
          if (err.error.message == 'Connection failed') {
            err = DioError(
              response:
                  Response(statusCode: 100, requestOptions: err.requestOptions),
              requestOptions: err.requestOptions,
            );
          } else {
            err = DioError(
              response:
                  Response(statusCode: 700, requestOptions: err.requestOptions),
              requestOptions: err.requestOptions,
            );
          }
          // TODO: Handle this case.
          break;
      }
      // return handler.next(err);
    }
    super.onError(err, handler);
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  // final options = Options(
  //   method: requestOptions.method,
  //   headers: requestOptions.headers,
  // );
  // return _dio.getDio().request<dynamic>(requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options);
  // }

  // Future<void> refreshToken() async {
  //   // final refreshToken = appPreferences.getApiToken();
  //   final response = await _dio.getDio().get(
  //         REFRESH_TOKEN,
  //       );
  //   if (response.statusCode == 200) {}
  // }

  void takeToLoginPage({required String description}) {
    _appPreferences.clearPreferences();
    di<stacked_service.NavigationService>().clearStackAndShow(
      mainViewRoute,
      arguments: LoginReasons(
        title: invalidTokenTitle,
        description: description,
      ),
    );
  }

  void setDioOptions({required BaseOptions options}) {
    getTokenDioClient.options = options;
  }
}
