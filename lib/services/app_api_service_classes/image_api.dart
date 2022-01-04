import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ImageApiAbstractClass {
  Future<ImageResponse> getImage({
    required String imageTitle,
  });
}

class ImageApi extends BaseApi implements ImageApiAbstractClass {
  @override
  Future<ImageResponse> getImage({required String imageTitle}) async {
    ImageResponse returningResponse = ImageResponse();

    ParentApiResponse parentApiResponse = await apiService.getProductImage(
      imageName: imageTitle,
    );

    if (filterResponse(parentApiResponse, showSnackBar: false) != null) {
      if (parentApiResponse.response!.data is String) {
        returningResponse = ImageResponse().empty();
      } else {
        returningResponse =
            ImageResponse.fromMap(parentApiResponse.response!.data);
      }
    }

    return returningResponse;
  }
}
