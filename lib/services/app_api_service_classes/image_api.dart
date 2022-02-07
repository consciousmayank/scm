import 'package:scm/enums/product_image_types.dart';
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ImageApiAbstractClass {
  Future<ImageResponse> getImage({
    required String imageTitle,
  });

  Future<List<Image>> getProductImage({
    required int productId,
    required ProductImagesType productImagesType,
    required int? supplierId,
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

  @override
  Future<List<Image>> getProductImage({
    required int productId,
    required ProductImagesType productImagesType,
    required int? supplierId,
  }) async {
    List<Image> returningResponse = [];

    ParentApiResponse parentApiResponse =
        await apiService.getProductImageViaProductId(
      productId: productId,
      productImagesType: productImagesType,
      supplierId: supplierId,
    );

    if (filterResponse(parentApiResponse, showSnackBar: false) != null) {
      returningResponse = parentApiResponse.response!.data["images"] != null
          ? List<Image>.from(parentApiResponse.response!.data["images"]
              .map((x) => Image.fromMap(x)))
          : [];

      // if (parentApiResponse.response!.data is List) {
      //   List<dynamic> list = parentApiResponse.response!.data;

      //   for (var item in parentApiResponse.response!.data) {
      //     returningResponse.add(Image.fromMap(item));
      //   }
      // } else {
      //   returningResponse = [];
      // }
    }

    return returningResponse;
  }
}
