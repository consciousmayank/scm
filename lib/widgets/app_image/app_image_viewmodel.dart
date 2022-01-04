import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/services/app_api_service_classes/image_api.dart';
import 'package:scm/utils/utils.dart';

class AppImageViewModel extends GeneralisedBaseViewModel {
  late String? image;
  final ImageApi _imageApi = di<ImageApi>();

  init({String? imageUrlString, String? imageDownloadString}) {
    if (imageUrlString != null) {
      image = checkImageUrl(
        imageUrl: imageUrlString,
      );
      notifyListeners();
    } else {
      getImageFromApi(imageString: imageDownloadString ?? '');
    }
  }

  void getImageFromApi({required String imageString}) async {
    setBusy(true);
    ImageResponse imageResponse = await _imageApi.getImage(
      imageTitle: imageString,
    );
    setBusy(false);
    image = checkImageUrl(
      imageUrl: imageResponse.image,
    );

    notifyListeners();
  }
}
