import 'package:scm/app/di.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/user_authenticate_request.dart';
import 'package:scm/model_classes/user_authenticate_response.dart';
import 'package:scm/services/network/api_service.dart';
import 'package:scm/services/network/base_api.dart';

abstract class LoginApiAbstractClass {
  Future<UserAuthenticateResponse> login({
    required String userName,
    required String password,
  });

  Future<UserAuthenticateResponse> changePassword({
    required String userName,
    required String password,
    required String newPassword,
  });
}

class LoginApi extends BaseApi implements LoginApiAbstractClass {
  final ApiService _apiService = locator<ApiService>();

  @override
  Future<UserAuthenticateResponse> changePassword({
    required String userName,
    required String password,
    required String newPassword,
  }) async {
    UserAuthenticateResponse authResponse = UserAuthenticateResponse().empty();

    ParentApiResponse? apiResponse = await _apiService.updatePassword(
      userName: userName,
      password: password,
      newPassword: newPassword,
    );

    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      authResponse =
          UserAuthenticateResponse.fromMap(apiResponse.response?.data);
    }

    return authResponse;
  }

  @override
  Future<UserAuthenticateResponse> login({
    required String userName,
    required String password,
  }) async {
    UserAuthenticateResponse authResponse = UserAuthenticateResponse().empty();

    ParentApiResponse? apiResponse = await _apiService.authenticateUser(
      authenticatUserRequest: UserAuthenticateRequest(
        username: userName,
        password: password,
      ),
    );

    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      authResponse =
          UserAuthenticateResponse.fromMap(apiResponse.response?.data);
    }

    return authResponse;
  }
}
