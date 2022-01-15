import 'package:flutter/material.dart';
import 'package:scm/app/di.dart';

import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/screens/demand_module_screens/suppliers_list/suppliers_list_view.dart';
import 'package:scm/services/app_api_service_classes/suppliers_list_api.dart';

class SuppliersListViewModel extends GeneralisedBaseViewModel {
  late final SuppliersListViewArguments arguments;
  int pageNumber = 0, pageSize = 15;
  TextEditingController searchController = TextEditingController();
  Supplier? selectedSupplier;
  String? supplierTitle;
  String? supplierType;
  SuppliersListResponse suppliersListResponse = SuppliersListResponse().empty();

  final SuppliersListApi _suppliersListApi = locator<SuppliersListApi>();

  init({required SuppliersListViewArguments args}) {
    arguments = args;
    getSuppliersList();
  }

  void getSuppliersList() async {
    setBusy(true);

    suppliersListResponse = await _suppliersListApi.getSuppliersList(
      pageNumber: pageNumber,
      pageSize: pageSize,
      title: supplierTitle,
      type: supplierType,
    );

    if (suppliersListResponse.suppliers!.isNotEmpty) {
      selectedSupplier = suppliersListResponse.suppliers!.first;
    } else {
      selectedSupplier = null;
    }

    setBusy(false);
    notifyListeners();
  }

  String getAddress(List<Address>? address) {
    if (address == null || address.isEmpty) {
      return '';
    }
    var concatenate = StringBuffer();

    address.forEach((item) {
      concatenate.write(
        item.toString(),
      );
    });
    return concatenate.toString();
  }
}
