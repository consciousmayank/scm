import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/product_list_response.dart';
import 'package:scm/screens/pim_homescreen/discard_product/discard_product_dialog_box.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked_services/src/models/overlay_response.dart';

class DiscardProductReasonDialogBoxViewModel extends GeneralisedBaseViewModel {
  final ProductApis _productApis = di<ProductApis>();
  late final DiscardProductReasonDialogBoxViewArguments args;
  String reason = '';
  late Function(DialogResponse p1) completer;
  void discardProduct() async {
    if (reason.isEmpty) {
      showErrorSnackBar(
        message: errorReasonRequired,
      );
    } else if (reason.length < 8) {
      showErrorSnackBar(
        message: errorReasonLength,
      );
    } else {
      ApiResponse response = await _productApis.discardProduct(
        product: Product().copyWith(
          id: args.productToDiscard.id,
          hsn: args.productToDiscard.hsn,
          brand: args.productToDiscard.brand,
          type: args.productToDiscard.type,
          subType: args.productToDiscard.subType,
          title: args.productToDiscard.title,
          price: args.productToDiscard.price,
          summary: reason,
          measurement: args.productToDiscard.measurement,
          measurementUnit: args.productToDiscard.measurementUnit,
          images: args.productToDiscard.images,
          tags: args.productToDiscard.tags,
        ),
      );

      if (response.isSuccessful()) {
        showInfoSnackBar(message: response.message);
        completer(DialogResponse(
          confirmed: true,
        ));
      } else {
        showErrorSnackBar(
          message: response.message,
        );
      }
    }
  }

  init(
      {required DiscardProductReasonDialogBoxViewArguments arguments,
      required Function(DialogResponse p1) completer}) {
    args = arguments;
    this.completer = completer;
  }
}
