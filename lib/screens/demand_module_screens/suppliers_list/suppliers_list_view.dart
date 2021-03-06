import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_view.dart';
import 'package:scm/screens/demand_module_screens/suppliers_list/suppliers_list_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/app_table_widget.dart';
import 'package:scm/widgets/app_textfield.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/loading_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/page_bar_widget.dart';
import 'package:stacked/stacked.dart';

class SuppliersListView extends StatefulWidget {
  const SuppliersListView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SuppliersListViewArguments arguments;

  @override
  _SuppliersListViewState createState() => _SuppliersListViewState();
}

class _SuppliersListViewState extends State<SuppliersListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuppliersListViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => Scaffold(
        body: getValueForScreenType(
          context: context,
          mobile: Container(),
          tablet: Container(),
          desktop: Row(
            children: [
              Expanded(
                child: Card(
                  shape: Dimens().getCardShape(),
                  elevation: Dimens().getDefaultElevation,
                  color: AppColors().white,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SupplierListWidget(),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: model.selectedSupplier == null
                    ? const Center(
                        child: Text(suppliersListNoSupplierFoundError),
                      )
                    : SuppplierProfileView(
                        key: UniqueKey(),
                        arguments: SuppplierProfileViewArguments(
                          selectedSupplier: model.selectedSupplier,
                        ),
                      ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SuppliersListViewModel(),
    );
  }
}

class SuppliersListViewArguments {}

class SupplierListWidget extends ViewModelWidget<SuppliersListViewModel> {
  const SupplierListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, SuppliersListViewModel viewModel) {
    return Column(
      children: [
        AppTableWidget.header(
          values: [
            AppTableSingleItem.string(
              suppliersListTitle,
              flexValue: 1,
              textStyle: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        hSizedBox(height: 8),
        AppTextField(
          autoFocus: true,
          controller: viewModel.searchController,
          hintText: suppliersListSearchTitle,
          onTextChange: (value) {
            if (value.isEmpty) {
              viewModel.supplierTitle = null;
            } else {
              viewModel.supplierTitle = value;
            }
            if (value.length > 2 || value.isEmpty) {
              viewModel.getSuppliersList();
            }
          },
          buttonType: ButtonType.SMALL,
          buttonIcon: viewModel.supplierTitle == null ||
                  viewModel.supplierTitle!.isEmpty
              ? const Icon(Icons.search)
              : const Icon(Icons.close),
          onButtonPressed: () {
            if (viewModel.supplierTitle!.isNotEmpty) {
              viewModel.supplierTitle = null;
              viewModel.searchController.clear();
            }
            viewModel.getSuppliersList();
          },
        ),
        wSizedBox(
          width: 8,
        ),
        Flexible(
          child: viewModel.isBusy
              ? const Center(
                  child: LoadingWidgetWithText(
                      text: 'Fetching Suppliers List. Please Wait...'),
                )
              : viewModel.suppliersListResponse.suppliers!.isEmpty
                  ? const Center(
                      child: Text(suppliersListNoSupplierFoundError),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return AppInkwell.withBorder(
                          onTap: () {
                            if (viewModel.selectedSupplier!.id !=
                                viewModel.suppliersListResponse
                                    .suppliers![index].id) {
                              viewModel.selectedSupplier = viewModel
                                  .suppliersListResponse.suppliers!
                                  .elementAt(index);
                              viewModel.notifyListeners();
                            }
                          },
                          borderderRadius: Dimens().getBorderRadius(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: viewModel.selectedSupplier!.id ==
                                      viewModel.suppliersListResponse.suppliers!
                                          .elementAt(index)
                                          .id
                                  ? Theme.of(context).primaryColorLight
                                  : AppColors().white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  Dimens().suppliersListItemImageCircularRaduis,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NullableTextWidget(
                                  stringValue: viewModel
                                      .suppliersListResponse.suppliers!
                                      .elementAt(index)
                                      .businessName,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                NullableTextWidget(
                                  stringValue: viewModel.getAddress(
                                    viewModel.suppliersListResponse.suppliers!
                                        .elementAt(index)
                                        .address,
                                  ),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const DottedDivider(),
                      itemCount:
                          viewModel.suppliersListResponse.suppliers!.length,
                    ),
        )
      ],
    );
  }
}
