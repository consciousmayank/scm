import 'package:scm/enums/profile_api_operations_type.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/supply_profile_response.dart';
import 'package:scm/model_classes/user_authenticate_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ProfileApis {
  Future<SupplyProfileResponse?> getSupplierProfile();

  Future<ApiResponse?> updateBusinessName(
      {required String businessNameJsonBody});

  // Future<ApiResponse?> updateViewProfileImage({required XFile files});

  Future<ApiResponse?>? updatePhoneNumber(
      {required String? phoneNumberJsonBody});

  Future<ApiResponse?>? updateMobileNumber(
      {required String? mobileNumberJsonBody});

  Future<ApiResponse?>? updateEmail({required String? emailJsonBody});

  Future<ApiResponse?>? updateContactPerson(
      {required String? contactPersonJsonBody});
}

class ProfileApisImpl extends BaseApi implements ProfileApis {
  @override
  Future<SupplyProfileResponse?> getSupplierProfile() async {
    SupplyProfileResponse? profileResponse;

    ParentApiResponse apiResponse = await apiService.profile(
      apiType: ProfileApiType.GET_PROFILE,
    );

    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      profileResponse =
          SupplyProfileResponse.fromMap(apiResponse.response?.data);
    }

    if (profileResponse != null) {
      return profileResponse;
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse?> updateBusinessName(
      {required String? businessNameJsonBody}) async {
    ApiResponse? updateProfile;
    ParentApiResponse? apiResponse = await apiService.updateBusinessName(
        businessNameJsonBody: businessNameJsonBody);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
    }
    if (updateProfile != null) {
      return updateProfile;
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse?>? updateContactPerson(
      {required String? contactPersonJsonBody}) async {
    ApiResponse? updateProfile;
    ParentApiResponse? apiResponse = await apiService.updateContactPerson(
        contactPersonJsonBody: contactPersonJsonBody);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
    }
    if (updateProfile != null) {
      return updateProfile;
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse?>? updateEmail({required String? emailJsonBody}) async {
    ApiResponse? updateProfile;
    ParentApiResponse? apiResponse =
        await apiService.updateEmail(emailJsonBody: emailJsonBody);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
    }
    if (updateProfile != null) {
      return updateProfile;
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse?>? updateMobileNumber(
      {required String? mobileNumberJsonBody}) async {
    ApiResponse? updateProfile;
    ParentApiResponse? apiResponse = await apiService.updateMobileNumber(
        mobileNumberJsonBody: mobileNumberJsonBody);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
    }
    if (updateProfile != null) {
      return updateProfile;
    } else {
      return null;
    }
  }

  @override
  Future<ApiResponse?>? updatePhoneNumber(
      {required String? phoneNumberJsonBody}) async {
    ApiResponse? updateProfile;
    ParentApiResponse? apiResponse = await apiService.updatePhoneNumber(
        phoneNumberJsonBody: phoneNumberJsonBody);
    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
    }
    if (updateProfile != null) {
      return updateProfile;
    } else {
      return null;
    }
  }

  // @override
  // Future<ApiResponse?>? updateViewProfileImage({required XFile files}) async {
  //   ApiResponse? updateProfile;
  //   ParentApiResponse? apiResponse =
  //       await apiService.updateViewProfileImage(files: files);
  //   if (filterResponse(apiResponse, showSnackBar: false) != null) {
  //     updateProfile = ApiResponse.fromMap(apiResponse.response?.data);
  //   }
  //   if (updateProfile != null) {
  //     return updateProfile;
  //   } else {
  //     return null;
  //   }
  // }
}
