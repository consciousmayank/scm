import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/product_list/product_list_view.dart';
import 'package:scm/widgets/brands_dialog_box/brands_dialogbox_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PimHomeScreenViewModel extends IndexTrackingViewModel {
  bool navRailIsExtended = false;

  final AppPreferences _appPreferences = di<AppPreferences>();

  void logout() {
    _appPreferences.clearPreferences();
    di<NavigationService>().pushNamedAndRemoveUntil(logInPageRoute);
  }

  getSelectedView() {
    switch (currentIndex) {
      case 0:
        return AddProductView(
          arguments: AddProductViewArguments(),
        );

      case 1:
        return ProductsListView(
          arguments: ProductsListViewArguments(),
        );

      default:
        return AddProductView(
          arguments: AddProductViewArguments(),
        );
    }
  }

  initScreen() {
    _appPreferences.setSelectedUserRole(
        userRole: AuthenticatedUserRoles.ROLE_DEO.getStatusString);

    if (_appPreferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_DEO.getStatusString) {
      setIndex(0);
    } else if (_appPreferences.getSelectedUserRole() ==
        AuthenticatedUserRoles.ROLE_DEO.getStatusString) {
      setIndex(1);
    }
    notifyListeners();
  }
}
