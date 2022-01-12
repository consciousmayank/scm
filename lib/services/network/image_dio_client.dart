import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/network/api_endpoints.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked_services/stacked_services.dart' as stacked_service;

class ImageDioConfig {
  ImageDioConfig({
    required this.baseUrl,
  }) {
    configureDio();
  }

  final appPreferences = locator<SharedPreferencesService>();
  final String baseUrl;

  final _dio = Dio();

  Interceptor get element => Interceptor();

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  configureDio() {
    _dio.options
      ..baseUrl = baseUrl
      ..contentType = "application/json"
      ..headers = {
        "X-Requested-With": "XmlHttpRequest",
        "content-type": "application/json"
      };
    if (EnvironmentConfig.SHOW_LOGS) {
      _dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        if (options.path != USER_AUTH) {
          if (options.path == REFRESH_TOKEN) {
            options.headers.addAll({"isRefreshToken": true});
          }
          if (EnvironmentConfig.SHOW_LOGS) {
            log("Api Token :: ${appPreferences.getApiToken()}");
          }
          options.headers.addAll(
            getAuthHeader(
              token: appPreferences.getApiToken(),
            ),
          );
        }
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          Map<String, dynamic>? headersMap = e.response?.headers.map;
          if (headersMap != null) {
            if (headersMap.containsKey('tokenstatus')) {
              List? tokenStatusList = headersMap['tokenstatus'];
              if (tokenStatusList?.first == 'EXPIRED') {
                appPreferences.clearPreferences();
                locator<stacked_service.NavigationService>()
                    .clearStackAndShow(logInPageRoute);
                locator<stacked_service.SnackbarService>()
                    .showSnackbar(message: 'Login again as token expired');

                // log('path lock');
                // log(e.response?.requestOptions.path);

                // _dio.interceptors.requestLock.lock();
                // _dio.interceptors.responseLock.lock();

                /// 1st approach below
                // await locator<LoginApisImpl>().refreshToken()?.then((value)  {
                // await _dio.request(REFRESH_TOKEN).then((value) {
                // UserAuthenticateResponse? newToken;
                //   newToken = value as UserAuthenticateResponse;
                //   MyPreferences().saveApiToken(tokenString: newToken?.token);
                // }).whenComplete(() async {
                //   log('un auth path unlock');
                //   log(e.response?.requestOptions.path);
                //   _dio.interceptors.errorLock.unlock();
                //   // _dio.interceptors.requestLock.unlock();
                //   // _dio.interceptors.responseLock.unlock();
                //   // return _retry(e.requestOptions);
                //   final opts = new Options(method: e.requestOptions.method);
                //   _dio.options.headers["Authorization"] =
                //       "Bearer ${newToken?.token}";
                //   final response = await _dio.request(e.requestOptions.path,
                //       options: opts,
                //       data: e.requestOptions.data,
                //       queryParameters: e.requestOptions.queryParameters);
                //   handler.resolve(response);
                // });
                /// 1st approach above

                /// another approach below
                // _dio.interceptors.requestLock.lock();
                // _dio.interceptors.responseLock.lock();
                // // locator<stackedService.SnackbarService>().showSnackbar(
                // //   message:
                // //       'Getting the new token last one got ${tokenStatusList?.first}',
                // // );
                // Response? response = await _dio.get(REFRESH_TOKEN);
                // //     ?.then((value) {
                // //     UserAuthenticateResponse? newToken = value;
                // //     MyPreferences().saveApiToken(tokenString: newToken?.token);
                // //
                // //   }).whenComplete(() {
                // //     _dio.interceptors.errorLock.unlock();
                // //   _dio.interceptors.requestLock.unlock();
                // //   _dio.interceptors.responseLock.unlock();
                // // }).then((value){
                //   _retry(e.requestOptions);
                // // });
                // if (response != null) {
                //   UserAuthenticateResponse? refreshTokenResponse =
                //       UserAuthenticateResponse.fromMap(response.data);
                //   MyPreferences().saveApiToken(tokenString: refreshTokenResponse.token);
                // }
                // _dio.interceptors.errorLock.unlock();
                // _dio.interceptors.requestLock.unlock();
                // _dio.interceptors.responseLock.unlock();
                // final options = Options(
                //   method: e.requestOptions.method,
                //   headers: e.requestOptions.headers,
                // );
                // final repeatRequest = await _dio.request<dynamic>(
                //   e.requestOptions.path,
                //   data: e.requestOptions.data,
                //   queryParameters: e.requestOptions.queryParameters,
                //   options: options,
                // );
                //
                // return handler.resolve(repeatRequest);
                // // _retry(e.requestOptions);
              }
            }
          }
          return handler.next(e);
        } else {
          switch (e.type) {
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
              if (e.error.message == 'Connection failed') {
                e = DioError(
                  response: Response(
                      statusCode: 100, requestOptions: e.requestOptions),
                  requestOptions: e.requestOptions,
                );
              } else {
                e = DioError(
                  response: Response(
                      statusCode: 700, requestOptions: e.requestOptions),
                  requestOptions: e.requestOptions,
                );
              }
              // TODO: Handle this case.
              break;
          }
        }
        // Do something with response error

        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      }),
    );
  }

  Dio getDio() {
    return _dio;
  }
}
