import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/product_image_types.dart';
import 'package:scm/model_classes/image_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/services/app_api_service_classes/image_api.dart';
import 'package:scm/utils/utils.dart';

const String getImageBusyKey = 'get-image-busy-key';
const String getProductImageBusyKey = 'get-product-image-busy-key';

class AppImageViewModel extends GeneralisedBaseViewModel {
  late String? image;
  late final Function? onImageLoaded;
  List<Image> productImages = [];

  final ImageApi _imageApi = locator<ImageApi>();

  init({
    String? imageUrlString,
    String? imageDownloadString,
    int? productId,
    int? supplierId,
    bool? isForCatalog,
    Function? onImageLoaded,
  }) {
    this.onImageLoaded = onImageLoaded;
    if (imageUrlString != null) {
      image = checkImageUrl(
        imageUrl: imageUrlString,
      );
      notifyListeners();
    } else if (imageDownloadString != null) {
      getImageFromApi(imageString: imageDownloadString);
    } else if (productId != null) {
      getProductImageFromApi(
        productId: productId,
        supplierId: supplierId,
        isForCatalog: isForCatalog,
      );
    } else {
      image = null;
      notifyListeners();
    }
  }

  void getImageFromApi({required String imageString}) async {
    ImageResponse imageResponse = await runBusyFuture(
      _imageApi.getImage(
        imageTitle: imageString,
      ),
      busyObject: getImageBusyKey,
    );
    image = checkImageUrl(
      imageUrl: imageResponse.image,
    );
    onImageLoaded?.call();

    // notifyListeners();
  }

  void getProductImageFromApi({
    required int productId,
    int? supplierId,
    bool? isForCatalog,
  }) async {
    ProductImagesType productImagesType = ProductImagesType.STANDARD;
    if (isForCatalog != null && isForCatalog) {
      productImagesType = ProductImagesType.SUPPLIER_CATALOG;
      supplierId = preferences.getSupplierDemandProfile()?.id;
    } else if (supplierId != null) {
      productImagesType = ProductImagesType.DEMAND;
    } else {
      productImagesType = ProductImagesType.STANDARD;
    }

    productImages = await runBusyFuture(
      _imageApi.getProductImage(
        productId: productId,
        productImagesType: productImagesType,
        supplierId: supplierId,
      ),
      busyObject: getProductImageBusyKey,
    );
    if (productImages.isNotEmpty) {
      image = checkImageUrl(
        imageUrl: productImages[0].image,
      );
    } else {
      image = null;
    }
    onImageLoaded?.call();
    // notifyListeners();
  }
}
