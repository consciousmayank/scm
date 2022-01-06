import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/address_api_type.dart';
import 'package:scm/enums/cart_api_types.dart';
import 'package:scm/enums/order_summary_api_type.dart';
import 'package:scm/enums/product_operations.dart';
import 'package:scm/enums/product_statuses.dart';
import 'package:scm/enums/profile_api_operations_type.dart';
import 'package:scm/enums/update_product_api_type.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/app_versioning_request.dart';
import 'package:scm/model_classes/brands_response_for_dashboard.dart';
import 'package:scm/model_classes/order_summary_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/post_order_request.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/model_classes/user_authenticate_request.dart';
import 'package:scm/services/network/api_endpoints.dart';
import 'package:scm/services/network/dio_client.dart';
import 'package:scm/services/network/image_dio_client.dart';

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
    int? supplierId,
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
            supplierId == null
                ? GET_BRAND_LIST
                : GET_BRANDS_LIST_FOR_SELECTED_SUPPLIER(supplierId: supplierId),
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
    int? supplierId,
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
            supplierId == null
                ? GET_PRODUCT_SUB_CATEGORIES_LIST
                : GET_CATEGORY_SUB_TYPES_LIST_FOR_SELECTED_SUPPLIER(
                    supplierId: supplierId,
                  ),
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
    int? supplierId,
    int? pageSize,
    bool isSupplierCatalog = false,
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

    if (pageIndex != null) {
      final tempMap = <String, dynamic>{
        'pageIndex': pageIndex,
      };
      params.addAll(tempMap);
    }

    try {
      response = await dioClient.getDio().get(
            isSupplierCatalog
                ? GET_SUPPLIER_CATALOG_CATEGORIES_LIST
                : supplierId == null
                    ? GET_CATEGORIES_LIST
                    : GET_CATEGORY_TYPES_LIST_FOR_SELECTED_SUPPLIER(
                        supplierId: supplierId,
                      ),
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
    int size = Dimens.defaultProductListPageSize,
    bool isSupplierCatalog = false,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
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
        'size': size,
      };
    }

    Response? response;
    DioError? error;
    try {
      if (isSupplierCatalog) {
        response = await dioClient
            .getDio()
            .get(GET_SUPPLIER_CATALOG_PRODUCT_LIST, queryParameters: params);
      } else if (supplierId != null && supplierId > 0) {
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

  Future<ParentApiResponse> getAllBrandsForPim({
    required int pageNumber,
    required int pageSize,
    String? brandToSearch,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
            GET_BRANDS_FOR_PIM,
            queryParameters: brandToSearch == null
                ? {
                    'page': pageNumber,
                    'size': pageSize,
                  }
                : {
                    'page': pageNumber,
                    'size': pageSize,
                    'title': brandToSearch
                  },
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getAllBrands({
    required int pageNumber,
    required int pageSize,
    String? brandToSearch,
    int? supplierId,
    bool isSupplierCatalog = false,
  }) async {
    Response? response;
    DioError? error;

    try {
      if (isSupplierCatalog) {
        response = await dioClient.getDio().get(
              GET_SUPPLIER_CATALOG_BRAND_LIST,
              queryParameters: brandToSearch == null
                  ? {
                      'page': pageNumber,
                      'size': pageSize,
                    }
                  : {
                      'page': pageNumber,
                      'size': pageSize,
                      'title': brandToSearch
                    },
            );
      } else if (supplierId == null) {
        //api is for suppliers
        response = await dioClient.getDio().get(
              GET_BRAND_LIST,
              queryParameters: brandToSearch == null
                  ? {
                      'page': pageNumber,
                      'size': pageSize,
                    }
                  : {
                      'page': pageNumber,
                      'size': pageSize,
                      'title': brandToSearch
                    },
            );
      } else {
        //api is for demanders
        response = await dioClient.getDio().get(
              GET_BRANDS_LIST_FOR_SELECTED_SUPPLIER(supplierId: supplierId),
              queryParameters: brandToSearch == null
                  ? {
                      'page': pageNumber,
                      'size': pageSize,
                    }
                  : {
                      'page': pageNumber,
                      'size': pageSize,
                      'title': brandToSearch
                    },
            );
      }
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

  // Future<ParentApiResponse> orderDetails(
  //     {required int? orderId,
  //     required OrderSummaryApiType? apiType,
  //     String? deliveryJsonBody}) async {
  //   Response? response;
  //   DioError? error;

  //   try {
  //     switch (apiType) {
  //       case OrderSummaryApiType.ORDER_DETAILS:
  //         response = await dioClient.getDio().get(GET_ORDER_SUMMARY(orderId));
  //         break;
  //       case OrderSummaryApiType.ACCEPT_ORDER:
  //         response = await dioClient.getDio().post(GET_ORDER_SUMMARY(orderId));
  //         break;
  //       case OrderSummaryApiType.REJECT_ORDER:
  //         response =
  //             await dioClient.getDio().delete(GET_ORDER_SUMMARY(orderId));
  //         break;

  //       case OrderSummaryApiType.DELIVER_ORDER:
  //         response = await dioClient.getDio().patch(
  //               GET_ORDER_SUMMARY(orderId),
  //               data: deliveryJsonBody,
  //             );
  //         break;
  //       default:
  //     }
  //   } on DioError catch (e) {
  //     error = e;
  //   }

  //   return ParentApiResponse(error: error, response: response);
  // }

  // Future<ParentApiResponse> supplyOrders({
  //   int? pageIndex,
  //   required OrderApiType? apiType,
  //   String? orderJsonBody,
  // }) async {
  //   Response? response;
  //   DioError? error;
  //   Map<String, dynamic> params = Map<String, dynamic>();
  //   params = <String, dynamic>{
  //     'page': pageIndex,
  //   };

  //   try {
  //     switch (apiType) {
  //       case OrderApiType.GET_ORDERS:
  //         response =
  //             await dioClient.getDio().get(ORDERS, queryParameters: params);
  //         break;
  //       case OrderApiType.UPDATE_ORDERS:
  //         response = await dioClient.getDio().put(
  //               ORDERS,
  //               data: orderJsonBody,
  //             );
  //         break;
  //       default:
  //     }
  //   } on DioError catch (e) {
  //     error = e;
  //   }

  //   return ParentApiResponse(error: error, response: response);
  // }

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

  Future<ParentApiResponse> updatePassword({
    required String userName,
    required String password,
    required String newPassword,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().post(
        UPDATE_PASSWORD,
        data: {
          "username": userName,
          "password": password,
          "newPassword": newPassword
        },
      );
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
      response = await dioClient.getDio().get(
            GET_PRODUCT_BY_ID(productId),
          );
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

  Future<ParentApiResponse> performOperationOnProduct({
    required Product productToBeAdded,
    required ProductOperations productOperation,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (productOperation) {
        case ProductOperations.ADD:
          response = await dioClient
              .getDio()
              .post(ADD_PRODUCT, data: productToBeAdded.toMap());
          break;
        case ProductOperations.UPDATE:
          response = await dioClient
              .getDio()
              .put(ADD_PRODUCT, data: productToBeAdded.toMap());
          break;
        case ProductOperations.DISCARD:
          response = await dioClient
              .getDio()
              .delete(ADD_PRODUCT, data: productToBeAdded.toMap());
          break;
      }
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
        'status': 'PROCESSED',
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
        'status': 'PUBLISHED',
        'sort': 'DESC'
      });
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getAllDiscardedProductsList({
    required int pageNumber,
    required int pageSize,
  }) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(ADD_PRODUCT, queryParameters: {
        'page': pageNumber,
        'size': pageSize,
        'status': 'DISCARDED',
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
      response = await dioClient.getDio().post(GET_BRANDS_FOR_PIM,
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

  Future<ParentApiResponse> getPimSupervisorDashboardStatistics() async {
    Response? response;
    DioError? error;

    try {
      response =
          await dioClient.getDio().get(GET_DASHBOARD_FOR_SUPERVISOR_DASHBOARD);
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getProductsCreatedStatistics(
      {String? selectedDate}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
            GET_CREATED_PRODUCTS_BY_USER_TYPE,
            queryParameters: selectedDate == null
                ? null
                : {
                    'date': selectedDate,
                  },
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getBarChartBasedOnProductStatuses(
      {required ProductStatuses productStatuses}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
        GET_BAR_CHART_BASED_ON_PRODUCT_STATUSES,
        queryParameters: {
          'status': productStatuses.getStatusString,
        },
      );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  getOrderInfo() async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
            ORDER_INFO(
              role: getLoggedInRole(),
            ),
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  getOrderedBrands({required int pageSize}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
        ORDERED_BRANDS(
          role: getLoggedInRole(),
        ),
        queryParameters: {
          'size': pageSize,
        },
      );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  getOrderedTypes({required int pageSize}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
        ORDERED_TYPES(
          role: getLoggedInRole(),
        ),
        queryParameters: {
          'size': pageSize,
        },
      );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> getOrderStatusList() async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().get(
            GET_ORDER_STATUS_LIST(
              role: getLoggedInRole(),
            ),
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  performOrderApiOperation({
    int? pageSize,
    int? pageNumber,
    String? orderId,
    String? deliveredBy,
    required OrderApiType orderApiType,
    String? status,
    OrderSummaryResponse? orderDetials,
    PostOrderRequest? postOrderRequest,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (orderApiType) {
        case OrderApiType.ORDER_LIST:
          response = await dioClient.getDio().get(
            ORDER(
              role: getLoggedInRole(),
              urlParamOrderId: orderId,
              orderApiType: orderApiType,
            ),
            queryParameters: {
              'size': pageSize,
              'page': pageNumber,
              'orderStatus': status?.replaceAll('ALL', ''),
            },
          );
          break;
        case OrderApiType.ORDER_DETAILS:
          response = await dioClient.getDio().get(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
              );
          break;
        case OrderApiType.ACCEPT_ORDER:
          response = await dioClient.getDio().post(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
              );
          break;
        case OrderApiType.DELIVER_ORDER:
          response = await dioClient.getDio().patch(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
                data: json.encode({
                  'deliverBy': deliveredBy,
                }),
              );
          break;
        case OrderApiType.REJECT_ORDER:
          response = await dioClient.getDio().delete(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
              );
          break;
        case OrderApiType.UPDATE_ORDERS:
          response = await dioClient.getDio().put(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
                data: orderDetials!.toJson(),
              );
          break;
        case OrderApiType.PLACE_ORDER:
          response = await dioClient.getDio().post(
                ORDER(
                  role: getLoggedInRole(),
                  urlParamOrderId: orderId,
                  orderApiType: orderApiType,
                ),
                data: postOrderRequest!.toJson(),
              );
          break;
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  String getLoggedInRole() {
    String userSelectedRole = preferences.getSelectedUserRole();

    if (userSelectedRole ==
        AuthenticatedUserRoles.ROLE_DEMAND.getStatusString) {
      return 'demand';
    } else {
      return 'supply';
    }
  }

  Future<ParentApiResponse> getSuppliersList({
    required int pageNumber,
    required int pageSize,
    String? type,
    String? title,
  }) async {
    Response? response;
    DioError? error;

    Map<String, String> queryParameters = {
      'page': '$pageNumber',
      'size': '$pageSize',
    };

    if (type != null) {
      queryParameters.putIfAbsent('type', () => type);
    }

    if (title != null) {
      queryParameters.putIfAbsent('title', () => title);
    }

    try {
      response = await dioClient.getDio().get(
            GET_SUPPLIERS_LIST,
            queryParameters: queryParameters,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> performCartOperation({
    required CartApiTypes? apiType,
    String? addCartJson,
    String? updateCartJson,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (apiType) {
        case CartApiTypes.GET_CART:
          response = await dioClient.getDio().get(
                GET_USER_CART,
              );
          break;
        case CartApiTypes.UPDATE_CART:
          response = await dioClient.getDio().put(
                GET_USER_CART,
                data: updateCartJson,
              );
          break;
        case CartApiTypes.ADD_TO_CART:
          response = await dioClient.getDio().put(
                GET_USER_CART,
                data: addCartJson,
              );
          break;
        default:
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> performAddressOperations({
    required AddressApiType? apiType,
    String? newAddressJsonBody,
  }) async {
    Response? response;
    DioError? error;

    try {
      switch (apiType) {
        case AddressApiType.GET_ADDRESS:
          response = await dioClient.getDio().get(GET_ADDRESS);
          break;
        case AddressApiType.UPDATE_ADDRESS:
          response = await dioClient
              .getDio()
              .put(GET_ADDRESS, data: newAddressJsonBody);
          break;
        default:
      }
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateBusinessName(
      {required String? businessNameJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().put(
            UPDATE_BUSINESS_NAME,
            data: businessNameJsonBody,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateContactPerson(
      {required String? contactPersonJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().put(
            UPDATE_CONTACT_PERSON,
            data: contactPersonJsonBody,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateEmail(
      {required String? emailJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().put(
            UPDATE_EMAIL,
            data: emailJsonBody,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updateMobileNumber(
      {required String? mobileNumberJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().put(
            UPDATE_MOBILE_NUMBER,
            data: mobileNumberJsonBody,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }

  Future<ParentApiResponse> updatePhoneNumber(
      {required String? phoneNumberJsonBody}) async {
    Response? response;
    DioError? error;

    try {
      response = await dioClient.getDio().put(
            UPDATE_PHONE_NUMBER,
            data: phoneNumberJsonBody,
          );
    } on DioError catch (e) {
      error = e;
    }

    return ParentApiResponse(error: error, response: response);
  }
}

enum AuthApiType { CHECK_USER_EXISTENCE, AUTHENTICATE_USER }
