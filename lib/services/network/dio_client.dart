import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/di.dart';
import 'package:scm/services/network/dio_interceptor.dart';
import 'package:scm/services/sharepreferences_service.dart';

class DioConfig {
  DioConfig() {
    configureDio();
  }

  final apiCancelToken = CancelToken();
  final ApiServiceAppDioInterceptor apiServiceAppDioInterceptor =
      ApiServiceAppDioInterceptor();

  List<RequestOptions> apisQueue = [];
  final appPreferences = locator<AppPreferencesService>();
  late String baseUrl;

  final _dio = Dio();

  configureDio() {
    _dio.options
      ..baseUrl = EnvironmentConfig.BASE_URL
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
    apiServiceAppDioInterceptor.setDioOptions(options: _dio.options);
    _dio.interceptors.add(apiServiceAppDioInterceptor);
    // _dio.interceptors.add(
    //   InterceptorsWrapper(onRequest: (options, handler) async {
    //     if (options.path != USER_AUTH) {
    //       if (options.path == REFRESH_TOKEN) {
    //         options.headers.addAll({"isRefreshToken": true});
    //       }
    //       if (EnvironmentConfig.SHOW_LOGS) {
    //         log("Api Token :: ${appPreferences.getApiToken()}");
    //       }
    //       options.headers.addAll(
    //         getAuthHeader(
    //           token: appPreferences.getApiToken(),
    //         ),
    //       );
    //     }
    //     return handler.next(options); //continue
    //   }, onResponse: (response, handler) {
    //     // Do something with response data
    //     return handler.next(response); // continue
    //     // If you want to reject the request with a error message,
    //     // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    //   }, onError: (DioError e, handler) async {
    //     if (e.response?.statusCode == 401) {
    //       Map<String, dynamic> headersMap = e.response?.data ?? {};
    //       if (headersMap.isNotEmpty) {
    //         String tokenStatus = headersMap[TOKEN_STATUS] ?? '';
    //         if (tokenStatus == EXPIRED) {
    //           if (refreshTokenApiStatus == ApiStatus.LOADING) {
    //             apisQueue.add(e.requestOptions);
    //           } else {
    //             apisQueue.add(e.requestOptions);
    //             Dio refreshTokenDioClient = Dio();
    //             refreshTokenDioClient.options = getDio().options;
    //             refreshTokenApiStatus = ApiStatus.LOADING;
    //             refreshTokenDioClient.get(REFRESH_TOKEN).then(
    //               (value) {
    //                 //Refresh token success
    //                 RefreshTokenResponse refreshTokenResponse =
    //                     RefreshTokenResponse.fromJson(value.data);
    //                 locator<SharedPreferencesService>()
    //                     .saveApiToken(tokenString: refreshTokenResponse.token);
    //                 processApiQueue();

    //                 for (var requestOption in apisQueue) {
    //                   getDio().fetch(requestOption).then((value) {
    //                     asd
    //                     return handler.next(requestOption);
    //                   });
    //                 }
    //               },
    //             ).onError(
    //               (error, stackTrace) {
    //                 //Refresh token failure
    //                 appPreferences.clearPreferences();
    //                 locator<stacked_service.NavigationService>()
    //                     .clearStackAndShow(
    //                   mainViewRoute,
    //                   arguments: SplashScreenArguments(
    //                     reasons: LoginReasons(
    //                       title: invalidTokenTitle,
    //                       description: invalidTokenDescription,
    //                     ),
    //                   ),
    //                 );
    //               },
    //             );
    //           }
    //         } else if (tokenStatus == INVALID_TOKEN) {
    //           appPreferences.clearPreferences();
    //           locator<stacked_service.NavigationService>().clearStackAndShow(
    //             mainViewRoute,
    //             arguments: SplashScreenArguments(
    //               reasons: LoginReasons(
    //                 title: invalidTokenTitle,
    //                 description: invalidTokenDescription,
    //               ),
    //             ),
    //           );
    //         } else {
    //           switch (e.type) {
    //             case DioErrorType.connectTimeout:
    //               // TODO: Handle this case.
    //               break;
    //             case DioErrorType.sendTimeout:
    //               // TODO: Handle this case.
    //               break;
    //             case DioErrorType.receiveTimeout:
    //               // TODO: Handle this case.
    //               break;
    //             case DioErrorType.response:
    //               // TODO: Handle this case.
    //               break;
    //             case DioErrorType.cancel:
    //               // TODO: Handle this case.
    //               break;
    //             case DioErrorType.other:
    //               if (e.error.message == 'Connection failed') {
    //                 e = DioError(
    //                   response: Response(
    //                       statusCode: 100, requestOptions: e.requestOptions),
    //                   requestOptions: e.requestOptions,
    //                 );
    //               } else {
    //                 e = DioError(
    //                   response: Response(
    //                       statusCode: 700, requestOptions: e.requestOptions),
    //                   requestOptions: e.requestOptions,
    //                 );
    //               }
    //               // TODO: Handle this case.
    //               break;
    //           }
    //         }
    //       }
    //       // return handler.next(e);
    //     } else {
    //       switch (e.type) {
    //         case DioErrorType.connectTimeout:
    //           // TODO: Handle this case.
    //           break;
    //         case DioErrorType.sendTimeout:
    //           // TODO: Handle this case.
    //           break;
    //         case DioErrorType.receiveTimeout:
    //           // TODO: Handle this case.
    //           break;
    //         case DioErrorType.response:
    //           // TODO: Handle this case.
    //           break;
    //         case DioErrorType.cancel:
    //           // TODO: Handle this case.
    //           break;
    //         case DioErrorType.other:
    //           if (e.error.message == 'Connection failed') {
    //             e = DioError(
    //               response: Response(
    //                   statusCode: 100, requestOptions: e.requestOptions),
    //               requestOptions: e.requestOptions,
    //             );
    //           } else {
    //             e = DioError(
    //               response: Response(
    //                   statusCode: 700, requestOptions: e.requestOptions),
    //               requestOptions: e.requestOptions,
    //             );
    //           }
    //           // TODO: Handle this case.
    //           break;
    //       }

    //       return handler.next(e);
    //     }
    //     // Do something with response error

    //     // return handler.next(e); //continue
    //     // If you want to resolve the request with some custom data，
    //     // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    //   }),
    // );
  }

  Dio getDio() {
    return _dio;
  }

  void processApiQueue() {}
}
