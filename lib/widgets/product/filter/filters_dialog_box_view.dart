import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/widgets/product/filter/filters_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductFilterDialogBoxView extends StatefulWidget {
  final Function(DialogResponse) completer;
  final DialogRequest request;

  const ProductFilterDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

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
  final String title;
  final List<String?>? selectedBrand;
  final List<String?>? selectedCategory;
  final List<String?>? selectedSuCategory;
  final String? searchProductTitle;

  ProductFilterDialogBoxViewArguments({
    required this.title,
    required this.selectedBrand,
    required this.selectedCategory,
    required this.selectedSuCategory,
    required this.searchProductTitle,
  });
}

class ProductFilterDialogBoxViewOutputArgs {
  // todo: later change String to String array
  final List<String?>? checkedBrands;
  final List<String?>? checkedCategories;
  final List<String?>? checkedSubCategories;

  ProductFilterDialogBoxViewOutputArgs({
    this.checkedBrands,
    this.checkedCategories,
    this.checkedSubCategories,
  });
}
