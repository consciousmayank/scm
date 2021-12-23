import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/screens/pim_homescreen/update_product_dialog/update_product_dialog_view.dart';

class UpdateProductDialogBoxViewModel extends GeneralisedBaseViewModel {
  late final UpdateProductDialogBoxViewArguments arguments;

  init({required UpdateProductDialogBoxViewArguments arguments}) {
    this.arguments = arguments;
  }
}
