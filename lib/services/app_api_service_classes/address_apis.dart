import 'package:scm/enums/address_api_type.dart';
import 'package:scm/model_classes/address.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class AddressApisAbstractClass {
  Future<List<Address>> getAddressList();

  Future<ApiResponse> updateAddress({required String? addressJsonBody});
}

class AddressApis extends BaseApi implements AddressApisAbstractClass {
  @override
  Future<List<Address>> getAddressList() async {
    List<Address>? addressList = [];

    ParentApiResponse apiResponse = await apiService.performAddressOperations(
      apiType: AddressApiType.GET_ADDRESS,
    );

    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      var list = apiResponse.response?.data as List;
      for (Map<String, dynamic> value in list) {
        Address address = Address.fromMap(value);
        addressList.add(address);
      }
    }

    return addressList;
  }

  Future<ApiResponse> updateAddress({required String? addressJsonBody}) async {
    ApiResponse? response;
    ParentApiResponse parentApiResponse =
        await apiService.performAddressOperations(
      apiType: AddressApiType.UPDATE_ADDRESS,
      newAddressJsonBody: addressJsonBody,
    );

    if (filterResponse(parentApiResponse) != null) {
      response = ApiResponse.fromMap(parentApiResponse.response?.data);
    }
    return response!;
  }
}
