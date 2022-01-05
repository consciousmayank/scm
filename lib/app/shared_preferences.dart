import 'dart:developer';

import 'package:scm/model_classes/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InterFaceAppPreferences {
  void saveSupplierBusinessName({required String? name});

  void saveCredentials(String value);

  String? getSupplierBusinessName();

  void saveApiToken({String? tokenString});

  void setAuthenticatedUserRoles({List<String>? userRoles});

  void setSelectedUserRole({required String userRole});

  List<String> getAuthenticatedUserRoles();

  String getSelectedUserRole();

  String? getApiToken();

  String getAuthenticatedUserName();

  void setAuthenticatedUserName({required String user});

  void setDemandersCart({
    required Cart cart,
  });

  Cart getDemandersCart();
}

class AppPreferences implements InterFaceAppPreferences {
  final String apiToken = "api_token";
  final String authenticatedUserName = "authenticated_user_name";
  final String authenticatedUserRoles = "authenticated_user_roles";
  final String demandersCart = "demanders_cart";
  final String loggedInUserCredentials = "logged_in_user_credentials";
  final String selectedUserRole = "selected_user_role";
  final String supplierBusinessName = "supplier_info";

  late SharedPreferences _sharedPrefs;

  @override
  String? getApiToken() {
    String? savedToken = _sharedPrefs.getString(apiToken);
    if (savedToken != null) {
      return savedToken;
    } else {
      return null;
    }
  }

  @override
  String getAuthenticatedUserName() {
    return _sharedPrefs.getString(
          authenticatedUserName,
        ) ??
        '';
  }

  @override
  List<String> getAuthenticatedUserRoles() {
    return _sharedPrefs.getString(authenticatedUserRoles) == null
        ? []
        : _sharedPrefs.getString(authenticatedUserRoles)!.split(',');
  }

  @override
  Cart getDemandersCart() {
    Cart cart = Cart().empty();

    String? cartJson = _sharedPrefs.getString(demandersCart);
    if (cartJson != null) {
      cart = Cart.fromJson(cartJson);
    }
    return cart;
  }

  @override
  String getSelectedUserRole() {
    return _sharedPrefs.getString(selectedUserRole) ?? '';
  }

  @override
  String? getSupplierBusinessName() {
    String? savedBusinessName = _sharedPrefs.getString(supplierBusinessName);
    if (savedBusinessName != null) {
      return savedBusinessName;
    } else {
      return null;
    }
  }

  @override
  void saveApiToken({String? tokenString}) {
    if (tokenString == null) {
      _sharedPrefs.remove(apiToken);
    } else {
      _sharedPrefs.setString(apiToken, tokenString);
    }
  }

  @override
  void saveCredentials(String value) {
    _sharedPrefs.setString(loggedInUserCredentials, value);
  }

  @override
  void saveSupplierBusinessName({required String? name}) {
    if (name == null) {
      _sharedPrefs.remove(supplierBusinessName);
    } else {
      _sharedPrefs.setString(supplierBusinessName, name);
    }
  }

  @override
  void setAuthenticatedUserName({String? user}) {
    if (user == null) {
      _sharedPrefs.remove(authenticatedUserName);
    } else {
      _sharedPrefs.setString(
        authenticatedUserName,
        user,
      );
    }
  }

  @override
  void setAuthenticatedUserRoles({List<String>? userRoles}) {
    if (userRoles == null) {
      _sharedPrefs.remove(authenticatedUserRoles);
    } else {
      _sharedPrefs.setString(authenticatedUserRoles, userRoles.join(","));
    }
  }

  @override
  void setDemandersCart({required Cart? cart}) {
    if (cart == null) {
      _sharedPrefs.remove(demandersCart);
    } else {
      _sharedPrefs.setString(demandersCart, cart.toJson());
    }
  }

  @override
  void setSelectedUserRole({required String userRole}) {
    _sharedPrefs.setString(selectedUserRole, userRole);
  }

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void clearPreferences() {
    _sharedPrefs.clear();
  }
}
