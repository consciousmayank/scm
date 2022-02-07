import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/selected_suppliers_brands_response.dart';
import 'package:scm/model_classes/selected_suppliers_sub_types_response.dart';
import 'package:scm/model_classes/selected_suppliers_types_response.dart';
import 'package:scm/widgets/product/filter/filters_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductFilterDialogBoxView extends StatefulWidget {
  const ProductFilterDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _ProductFilterDialogBoxState createState() => _ProductFilterDialogBoxState();
}

class _ProductFilterDialogBoxState extends State<ProductFilterDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    ProductFilterDialogBoxViewArguments arguments =
        widget.request.data as ProductFilterDialogBoxViewArguments;
    return CenteredBaseDialog(
      arguments: CenteredBaseDialogArguments(
        contentPadding: const EdgeInsets.all(
          64,
        ),
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductsFilterView(
            arguments: ProductsFilterViewArguments(
              supplierId: arguments.supplierId,
              selectedBrand: arguments.selectedBrand,
              selectedCategory: arguments.selectedCategory,
              selectedSuCategory: arguments.selectedSuCategory,
              searchProductTitle: arguments.searchProductTitle,
              isSupplierCatalog: arguments.isSupplierCatalog,
              onApplyFilterButtonClicked: (
                  {required ProductsFilterViewOutputArguments outArgs}) {
                widget.completer(
                  DialogResponse(
                    confirmed: true,
                    data: ProductFilterDialogBoxViewOutputArgs(
                      checkedBrands: outArgs.checkedBrands,
                      checkedCategories: outArgs.checkedCategories,
                      checkedSubCategories: outArgs.checkedSubCategories,
                    ),
                  ),
                );
              },
              onCancelButtonClicked: () {
                widget.completer(
                  DialogResponse(
                    confirmed: false,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProductFilterDialogBoxViewArguments {
  ProductFilterDialogBoxViewArguments({
    required this.title,
    required this.selectedBrand,
    required this.selectedCategory,
    required this.selectedSuCategory,
    required this.searchProductTitle,
    required this.supplierId,
    this.isSupplierCatalog = false,
  });

  final bool isSupplierCatalog;
  final String? searchProductTitle;
  final List<Brand?>? selectedBrand;
  final List<Type?>? selectedCategory;
  final List<SubType?>? selectedSuCategory;
  final int? supplierId;
  final String title;
}

class ProductFilterDialogBoxViewOutputArgs {
  ProductFilterDialogBoxViewOutputArgs({
    this.checkedBrands,
    this.checkedCategories,
    this.checkedSubCategories,
  });

  // todo: later change String to String array
  final List<Brand?>? checkedBrands;

  final List<Type?>? checkedCategories;
  final List<SubType?>? checkedSubCategories;
}
