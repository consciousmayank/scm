import 'package:flutter/material.dart';
import 'package:scm/model_classes/product_list_response.dart';

class ProductListDataSource extends DataTableSource {
  List<Product> productList = [];
  late Function(Product product) onTap;

  void setProductList(List<Product> productList) {
    if (productList.isEmpty) {
      this.productList = productList;
    } else {
      this.productList.addAll(productList);
    }
  }

  void addOnTap({required Function(Product product) onTap}) {
    this.onTap = onTap;
  }

  bool get isRowCountApproximate => false;
  int get rowCount => productList.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            productList.elementAt(index).id!.toString(),
          ),
        ),
        DataCell(
          Text(
            productList.elementAt(index).brand!.toString(),
          ),
        ),
        DataCell(
          Text(
            productList.elementAt(index).type!.toString(),
          ),
        ),
        DataCell(
          Text(
            productList.elementAt(index).subType!.toString(),
          ),
        ),
        DataCell(
          Text(
            productList.elementAt(index).title!.toString(),
          ),
        ),
      ],
      onSelectChanged: (value) {
        if (value != null && value) {
          onTap(productList.elementAt(index));
        }
      },
    );
  }
}
