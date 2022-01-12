import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      // Initialise the asynchronous shared preferences
      _preferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService();
    }

    return Future.value(_instance);
  }

  static SharedPreferencesService? _instance;

  static SharedPreferences? _preferences;

  static const _ThemeIndexKey = 'user_key';
  static const _UserThemeModeKey = 'user_theme_mode_key';

  final String apiToken = "api_token";
  final String authenticatedUserName = "authenticated_user_name";
  final String authenticatedUserRoles = "authenticated_user_roles";
  final String demandersCart = "demanders_cart";
  final String loggedInUserCredentials = "logged_in_user_credentials";
  final String selectedUserRole = "selected_user_role";
  final String supplierBusinessName = "supplier_info";

  String? getApiToken() {
    // return "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI5NjExODg2MzM5IiwiaXNTdXBwbHkiOnRydWUsImlzcyI6ImdlZWt0ZWNobm90b25pYyIsImV4cCI6MTY0MTkzMjgzNSwiaWF0IjoxNjQxOTA0MDM1fQ.iGrsNsM8Bs6wE9kg0IGKLiglwuhjrIrK6GgRWVeJ2E6SK1NUoH7Oa9-jE-BZvTFyvr-QOwMPMPR5H1E8NfAh2A";
    String? savedToken = _preferences?.getString(apiToken);
    if (savedToken != null) {
      return savedToken;
    } else {
      return null;
    }
  }

  String getAuthenticatedUserName() {
    return _preferences?.getString(
          authenticatedUserName,
        ) ??
        '';
  }

  List<String> getAuthenticatedUserRoles() {
    return _preferences?.getString(authenticatedUserRoles) == null
        ? []
        : _preferences!.getString(authenticatedUserRoles)!.split(',');
  }

  Cart getDemandersCart() {
    Cart cart = Cart().empty();

    String? cartJson = _preferences?.getString(demandersCart);
    if (cartJson != null) {
      cart = Cart.fromJson(cartJson);
    }
    return cart;
  }

  String getSelectedUserRole() {
    return _preferences?.getString(selectedUserRole) ?? '';
  }

  String? getSupplierBusinessName() {
    String? savedBusinessName = _preferences?.getString(supplierBusinessName);
    if (savedBusinessName != null) {
      return savedBusinessName;
    } else {
      return null;
    }
  }

  void saveApiToken({String? tokenString}) {
    if (tokenString == null) {
      _preferences?.remove(apiToken);
    } else {
      _preferences?.setString(apiToken, tokenString);
    }
  }

  void saveCredentials(String value) {
    _preferences?.setString(loggedInUserCredentials, value);
  }

  void saveSupplierBusinessName({required String? name}) {
    if (name == null) {
      _preferences?.remove(supplierBusinessName);
    } else {
      _preferences?.setString(supplierBusinessName, name);
    }
  }

  void setAuthenticatedUserName({String? user}) {
    if (user == null) {
      _preferences?.remove(authenticatedUserName);
    } else {
      _preferences?.setString(
        authenticatedUserName,
        user,
      );
    }
  }

  void setAuthenticatedUserRoles({List<String>? userRoles}) {
    if (userRoles == null) {
      _preferences?.remove(authenticatedUserRoles);
    } else {
      _preferences?.setString(authenticatedUserRoles, userRoles.join(","));
    }
  }

  void setDemandersCart({required Cart? cart}) {
    if (cart == null) {
      _preferences?.remove(demandersCart);
    } else {
      _preferences?.setString(demandersCart, cart.toJson());
    }
  }

  void setSelectedUserRole({required String userRole}) {
    _preferences?.setString(selectedUserRole, userRole);
  }

  void clearPreferences() async {
    await FirebaseMessaging.instance.deleteToken();
    _preferences?.clear();
  }

  int? get themeIndex => _getFromDisk(_ThemeIndexKey);

  set themeIndex(int? value) => _saveToDisk(_ThemeIndexKey, value);

  ThemeMode? get userThemeMode {
    var userThemeString = _getFromDisk(_UserThemeModeKey);
    if (userThemeString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    }

    if (userThemeString == ThemeMode.light.toString()) {
      return ThemeMode.light;
    }

    return null;
  }

  set userThemeMode(ThemeMode? value) {
    if (value == null) {
      _saveToDisk(_UserThemeModeKey, value);
    } else {
      var userTheme = value.toString();
      _saveToDisk(_UserThemeModeKey, userTheme);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences?.get(key);
    return value;
  }

  void _saveToDisk(String key, dynamic content) {
    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }
}
