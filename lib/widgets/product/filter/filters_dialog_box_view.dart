import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
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
    return RightSidedBaseDialog(
      arguments: RightSidedBaseDialogArguments(
        request: widget.request,
        completer: widget.completer,
        title: arguments.title,
        child: ProductsFilterView(
          arguments: ProductsFilterViewArguments(
            supplierId: arguments.supplierId,
            selectedBrand: arguments.selectedBrand,
            selectedCategory: arguments.selectedCategory,
            selectedSuCategory: arguments.selectedSuCategory,
            searchProductTitle: arguments.searchProductTitle,
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
  });

  final String? searchProductTitle;
  final List<String?>? selectedBrand;
  final List<String?>? selectedCategory;
  final List<String?>? selectedSuCategory;
  final String title;
  final int? supplierId;
}

class ProductFilterDialogBoxViewOutputArgs {
  ProductFilterDialogBoxViewOutputArgs({
    this.checkedBrands,
    this.checkedCategories,
    this.checkedSubCategories,
  });

  // todo: later change String to String array
  final List<String?>? checkedBrands;

  final List<String?>? checkedCategories;
  final List<String?>? checkedSubCategories;
}
