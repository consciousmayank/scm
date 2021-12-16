import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/model_classes/app_versioning_request.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/user_authenticate_request.dart';
import 'package:scm/services/network/api_endpoints.dart';
import 'package:scm/services/network/dio_client.dart';

class ApiService {
  final dioClient = di<DioConfig>();
  final preferences = di<AppPreferences>();

  Future<ParentApiResponse> login({
    required String base64string,
  }) async {
    // dioClient.addHeaders(getAuthHeader(base64String: base64string));
    Response? response;
    DioError? error;
    try {
      response = await dioClient.getDio().get(LOGIN);
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getAppVersions(
      {required AppVersioningRequest request}) async {
    Response? response;
    DioError? error;
    try {
      response = await dioClient
          .getDio()
          .post(GET_APP_VERSION, data: request.toJson());
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future updateFCMID({required String fcmId}) async {
    var body = {'fcmId': fcmId};
    Response? response;
    DioError? error;
    try {
      response = await dioClient.getDio().put(UPDATE_FCM_ID, data: body);
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future<ParentApiResponse> getBrandsList({
    required int? pageIndex,
    String? brandTitle,
    String? productTitle,
    List<String?>? checkedCategoryFilterList,
    List<String?>? checkedSubCategoryFilterList,
  }) async {
    Response? response;
    DioError? error;
    Map<String, dynamic> params = Map<String, dynamic>();

    // / if searched by brand title
    // if (brandTitle != null) {
    //   params = <String, dynamic>{
    //     'title': brandTitle,
    //     'page': pageIndex,
    //   };
    //
    // }

    /// SUB-CATEGORY + CATEGORY
    if (checkedCategoryFilterList != null &&
        checkedSubCategoryFilterList != null) {
      params = <String, dynamic>{
        'subType': checkedSubCategoryFilterList,
        'type': checkedCategoryFilterList,
        'page': pageIndex,
      };
    }

    /// CATEGORY
    else if (checkedCategoryFilterList != null &&
        checkedSubCategoryFilterList == null) {
      params = <String, dynamic>{
        'type': checkedCategoryFilterList,
        'page': pageIndex,
      };
    }

    /// SUB-Category
    else if (checkedCategoryFilterList == null &&
        checkedSubCategoryFilterList != null) {
      params = <String, dynamic>{
        'subType': checkedSubCategoryFilterList,
        'page': pageIndex,
      };
    } else {
      /// only page in params
      params = <String, dynamic>{
        'page': pageIndex,
      };
    }

    if (brandTitle != null) {
      final tempMap = <String, dynamic>{
        'title': brandTitle,
      };
      params.addAll(tempMap);
    }
    if (productTitle != null) {
      if (productTitle.length > 0) {
        final tempMap = <String, dynamic>{
          'pTitle': productTitle,
        };
        params.addAll(tempMap);
      }
    }

    try {
      response = await dioClient.getDio().get(
            GET_BRAND_LIST,
            queryParameters: params,
          );
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future<ParentApiResponse> getProductSubCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedCategoryList,
    String? subCategoryTitle,
    String? productTitle,
  }) async {
    Response? response;
    DioError? error;
    Map<String, dynamic> params = Map<String, dynamic>();

    // /// if searched by sub-category title
    // if (subCategoryTitle != null) {
    //   params = <String, dynamic>{
    //     'title': subCategoryTitle,
    //     'page': pageIndex,
    //   };
    // }

    /// BRAND + CATEGORY
    if (checkedBrandList != null && checkedCategoryList != null) {
      params = <String, dynamic>{
        'brand': checkedBrandList,
        'type': checkedCategoryList,
        'page': pageIndex,
      };
    }

    /// CATEGORY
    else if (checkedCategoryList != null && checkedBrandList == null) {
      params = <String, dynamic>{
        'type': checkedCategoryList,
        'page': pageIndex,
      };
    }

    /// BRAND
    else if (checkedCategoryList == null && checkedBrandList != null) {
      params = <String, dynamic>{
        'brand': checkedBrandList,
        'page': pageIndex,
      };
    } else {
      /// only page in params
      params = <String, dynamic>{
        'page': pageIndex,
      };
    }

    if (subCategoryTitle != null) {
      final tempMap = <String, dynamic>{
        'title': subCategoryTitle,
      };
      params.addAll(tempMap);
    }
    if (productTitle != null) {
      if (productTitle.length > 0) {
        final tempMap = <String, dynamic>{
          'pTitle': productTitle,
        };
        params.addAll(tempMap);
      }
    }
    try {
      response = await dioClient.getDio().get(
            GET_PRODUCT_SUB_CATEGORIES_LIST,
            queryParameters: params,
          );
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future<ParentApiResponse> getProductCategoriesList({
    required int? pageIndex,
    List<String?>? checkedBrandList,
    List<String?>? checkedSubCategoriesList,
    String? categoryTitle,
    String? productTitle,
  }) async {
    Response? response;
    DioError? error;
    Map<String, dynamic> params = Map<String, dynamic>();

    /// BRAND + SUB-CATEGORY
    if (checkedBrandList != null && checkedSubCategoriesList != null) {
      params = <String, dynamic>{
        'brand': checkedBrandList,
        'subType': checkedSubCategoriesList,
        'page': pageIndex,
      };
    }

    /// CATEGORY
    else if (checkedSubCategoriesList != null && checkedBrandList == null) {
      params = <String, dynamic>{
        'subType': checkedSubCategoriesList,
        'page': pageIndex,
      };
    }

    /// BRAND
    else if (checkedSubCategoriesList == null && checkedBrandList != null) {
      params = <String, dynamic>{
        'brand': checkedBrandList,
        'page': pageIndex,
      };
    } else {
      /// only page in params
      params = <String, dynamic>{
        'page': pageIndex,
      };
    }

    if (categoryTitle != null) {
      final tempMap = <String, dynamic>{
        'title': categoryTitle,
      };
      params.addAll(tempMap);
    }
    if (productTitle != null) {
      if (productTitle.length > 0) {
        final tempMap = <String, dynamic>{
          'pTitle': productTitle,
        };
        params.addAll(tempMap);
      }
    }

    try {
      response = await dioClient.getDio().get(
            GET_CATEGORIES_LIST,
            queryParameters: params,
          );
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future<ParentApiResponse> getProductList({
    List<String?>? brandsFilterList,
    List<String?>? categoryFilterList,
    List<String?>? subCategoryFilterList,
    String? productTitle,
    int? pageIndex,
    int? supplierId,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    /// case 2 - product list by title
    if (brandsFilterList == null &&
        categoryFilterList == null &&
        subCategoryFilterList == null &&
        productTitle != null) {
      params = <String, dynamic>{
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 3 - product list by sub category
    else if (brandsFilterList == null &&
        categoryFilterList == null &&
        subCategoryFilterList != null &&
        productTitle == null) {
      params = <String, dynamic>{
        'subType': subCategoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 4 - product list by sub category and title
    else if (brandsFilterList == null &&
        categoryFilterList == null &&
        subCategoryFilterList != null &&
        productTitle != null) {
      params = <String, dynamic>{
        'subType': subCategoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 5 - product list by category
    else if (brandsFilterList == null &&
        categoryFilterList != null &&
        subCategoryFilterList == null &&
        productTitle == null) {
      params = <String, dynamic>{
        'type': categoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 6 - product list by category and title
    else if (brandsFilterList == null &&
        categoryFilterList != null &&
        subCategoryFilterList == null &&
        productTitle != null) {
      params = <String, dynamic>{
        'type': categoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 7 - product list by category and sub-category
    else if (brandsFilterList == null &&
        categoryFilterList != null &&
        subCategoryFilterList != null &&
        productTitle == null) {
      params = <String, dynamic>{
        'type': categoryFilterList,
        'subType': subCategoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 8 - product list by category, sub-category, and title
    else if (brandsFilterList == null &&
        categoryFilterList != null &&
        subCategoryFilterList != null &&
        productTitle != null) {
      params = <String, dynamic>{
        'type': categoryFilterList,
        'subType': subCategoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 9 - product list by brand
    else if (brandsFilterList != null &&
        categoryFilterList == null &&
        subCategoryFilterList == null &&
        productTitle == null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'page': pageIndex,
      };
    }

    /// case 10 - product list by brand and title
    else if (brandsFilterList != null &&
        categoryFilterList == null &&
        subCategoryFilterList == null &&
        productTitle != null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 11 - product list by brand and sub category
    else if (brandsFilterList != null &&
        categoryFilterList == null &&
        subCategoryFilterList != null &&
        productTitle == null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'subType': subCategoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 12 - product list by brand and sub category and title
    else if (brandsFilterList != null &&
        categoryFilterList == null &&
        subCategoryFilterList != null &&
        productTitle != null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'subType': subCategoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 13 - product list by brand and category
    else if (brandsFilterList != null &&
        categoryFilterList == null &&
        subCategoryFilterList == null &&
        productTitle == null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'type': categoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 14 - product list by brand and category and title
    else if (brandsFilterList != null &&
        categoryFilterList != null &&
        subCategoryFilterList == null &&
        productTitle != null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'type': categoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    /// case 15 - product list by brand and sub-category, category
    else if (brandsFilterList != null &&
        categoryFilterList != null &&
        subCategoryFilterList != null &&
        productTitle == null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'subType': subCategoryFilterList,
        'type': categoryFilterList,
        'page': pageIndex,
      };
    }

    /// case 16 - product list by brand and sub-category, category, title
    else if (brandsFilterList != null &&
        categoryFilterList != null &&
        subCategoryFilterList != null &&
        productTitle != null) {
      params = <String, dynamic>{
        'brand': brandsFilterList,
        'subType': subCategoryFilterList,
        'type': categoryFilterList,
        'title': productTitle,
        'page': pageIndex,
      };
    }

    Response? response;
    DioError? error;
    try {
      if (supplierId != null) {
        response = await dioClient
            .getDio()
            .get(GET_SUPPLIER_PRODUCTS(supplierId), queryParameters: params);
      } else {
        response = await dioClient
            .getDio()
            .get(GET_PRODUCT_LIST, queryParameters: params);
      }
    } on DioError catch (e) {
      error = e;
    }
    return ParentApiResponse(response: response, error: error);
  }

  Future<ParentApiResponse> getAllBrands(
      {required int pageNumber,
      required int pageSize,
      required String brandToSearch}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(GET_BRANDS_FOR_DASHBOARD,
          queryParameters: {
            'page': pageNumber,
            'size': pageSize,
            'title': brandToSearch
          });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getProductImage({required imageName}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(GET_PRODUCT_IMAGE(imageName));
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> orderDetails(
      {required int? orderId,
      required OrderSummaryApiType? apiType,
      String? deliveryJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      switch (apiType) {
        case OrderSummaryApiType.ORDER_DETAILS:
          response = await dioClient.getDio().get(GET_ORDER_SUMMARY(orderId));
          break;
        case OrderSummaryApiType.ACCEPT_ORDER:
          response = await dioClient.getDio().post(GET_ORDER_SUMMARY(orderId));
          break;
        case OrderSummaryApiType.REJECT_ORDER:
          response =
              await dioClient.getDio().delete(GET_ORDER_SUMMARY(orderId));
          break;

        case OrderSummaryApiType.DELIVER_ORDER:
          response = await dioClient.getDio().patch(
                GET_ORDER_SUMMARY(orderId),
                data: deliveryJsonBody,
              );
          break;
        default:
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> supplyOrders({
    int? pageIndex,
    required OrderApiType? apiType,
    String? orderJsonBody,
  }) async {
    Response? response;
    DioError? error;
    Map<String, dynamic> params = Map<String, dynamic>();
    params = <String, dynamic>{
      'page': pageIndex,
    };

    try {
      switch (apiType) {
        case OrderApiType.GET_ORDERS:
          response =
              await dioClient.getDio().get(ORDERS, queryParameters: params);
          break;
        case OrderApiType.UPDATE_ORDERS:
          response = await dioClient.getDio().put(
                ORDERS,
                data: orderJsonBody,
              );
          break;
        default:
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> authenticateUser({
    required UserAuthenticateRequest authenticatUserRequest,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient
          .getDio()
          .post(USER_AUTH, data: authenticatUserRequest.toJson());
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> checkIfUserExists({
    required UserAuthenticateRequest authenticatUserRequest,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(USER_AUTH, queryParameters: {
        'username': authenticatUserRequest.username,
      });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> resendOtp({required String? username}) async {
    Response? response;
    DioError? error;

    Map<String, dynamic>? params = Map<String, dynamic>();
    params = <String, dynamic>{
      'username': username,
    };

    try {
      response =
          await dioClient.getDio().get(RESEND_OTP, queryParameters: params);
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> registerUser(
      {String? registerUserRequestJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient
          .getDio()
          .post(USER_REGISTER, data: registerUserRequestJsonBody);
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getProductById({int? productId}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(GET_PRODUCT_BY_ID(productId));
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> refreshToken() async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(REFRESH_TOKEN);
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = new Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return dioClient.re<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }

  Future<ParentApiResponse> profile({
    required ProfileApiType? apiType,
    String? profileJsonBody,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (apiType) {
        case ProfileApiType.GET_PROFILE:
          response = await dioClient.getDio().get(SUPPLY_PROFILE);
          break;
        case ProfileApiType.UPDATE_PROFILE:
          response = await dioClient.getDio().put(
                SUPPLY_PROFILE,
                data: profileJsonBody,
              );
          break;
        default:
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> verifyOtp(
      {required String? verifyOtpJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response =
          await dioClient.getDio().post(VERIFY_OTP, data: verifyOtpJsonBody);
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> addProduct({
    required Product productToBeAdded,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient
          .getDio()
          .post(ADD_PRODUCT, data: productToBeAdded.toMap());
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateProduct({
    required Product productToBeAdded,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient
          .getDio()
          .put(ADD_PRODUCT, data: productToBeAdded.toMap());
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateProductById({
    required int? productId,
    // required int? supplierId,
    required UpdateProductApiSelection? apiToHit,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (apiToHit) {
        case UpdateProductApiSelection.ADD_PRODUCT:
          response =
              await dioClient.getDio().put(ADD_REMOVE_PRODUCT_BY_ID(productId));
          break;
        case UpdateProductApiSelection.DELETE_PRODUCT:
          response = await dioClient
              .getDio()
              .delete(ADD_REMOVE_PRODUCT_BY_ID(productId));
          break;
        default:
          break;
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getAllAddedProductsList({
    required int pageNumber,
    required int pageSize,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(ADD_PRODUCT, queryParameters: {
        'page': pageNumber,
        'size': pageSize,
      });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getAllPublishedProductsList({
    required int pageNumber,
    required int pageSize,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(ADD_PRODUCT, queryParameters: {
        'page': pageNumber,
        'size': pageSize,
        'status': true,
        'sort': 'DESC'
      });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> addBrand({
    required Brand brand,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().post(GET_BRANDS_FOR_DASHBOARD,
          data: brand.image == null
              ? {
                  'title': brand.title,
                }
              : {
                  'title': brand.title,
                  'image': brand.image,
                });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }
}

enum AuthApiType { CHECK_USER_EXISTENCE, AUTHENTICATE_USER }

enum ProfileApiType { GET_PROFILE, UPDATE_PROFILE }

enum OrderApiType { GET_ORDERS, UPDATE_ORDERS }

enum OrderSummaryApiType {
  ORDER_DETAILS,
  ACCEPT_ORDER,
  DELIVER_ORDER,
  REJECT_ORDER,
}
