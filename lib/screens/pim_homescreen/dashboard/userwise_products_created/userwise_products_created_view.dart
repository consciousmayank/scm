import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/enums/work_summary_table_options.dart';
import 'package:scm/model_classes/statistics_product_created.dart';
import 'package:scm/screens/pim_homescreen/dashboard/userwise_products_created/userwise_products_created_viewmodel.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/dashboard_sub_views_title_text.dart';
import 'package:scm/widgets/decorative_container.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';

class UserwiseProductsCreatedView extends StatefulWidget {
  const UserwiseProductsCreatedView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final UserwiseProductsCreatedViewArguments arguments;

  @override
  _UserwiseProductsCreatedViewState createState() =>
      _UserwiseProductsCreatedViewState();
}

class _UserwiseProductsCreatedViewState
    extends State<UserwiseProductsCreatedView> {
  Future<DateTime?> selectDate() async {
    DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: Theme.of(context).colorScheme,
          ),
          child: child!,
        );
      },
      helpText: 'Select Date',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Expiration Date',
      fieldHintText: 'Month/Date/Year',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 30,
        ),
      ),
      lastDate: DateTime.now(),
    );

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserwiseProductsCreatedViewModel>.reactive(
      onModelReady: (model) => model.getProductsCreatedStatistics(),
      builder: (context, model, child) => Card(
        shape: Dimens().getCardShape(),
        color: Colors.white,
        elevation: Dimens().getDefaultElevation,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DashboardSubViewsTitleWidget(
                    titleText: dailyEntriesTitle),
                Wrap(
                  children: [
                    FilterChip(
                      label: const Text('OverAll'),
                      labelStyle: TextStyle(
                        color: model.workSummaryTableOptions ==
                                WorkSummaryTableOptions.OVER_ALL
                            ? Colors.black
                            : Colors.white,
                      ),
                      selected: model.workSummaryTableOptions ==
                          WorkSummaryTableOptions.OVER_ALL,
                      onSelected: (bool selected) {
                        if (selected) {
                          model.workSummaryTableOptions =
                              WorkSummaryTableOptions.OVER_ALL;
                          model.notifyListeners();
                        }
                      },
                      selectedColor: Theme.of(context).primaryColorLight,
                      checkmarkColor: Colors.black,
                    ),
                    wSizedBox(width: 4),
                    FilterChip(
                      label: const Text('Today'),
                      labelStyle: TextStyle(
                        color: model.workSummaryTableOptions ==
                                WorkSummaryTableOptions.TODAY
                            ? Colors.black
                            : Colors.white,
                      ),
                      selected: model.workSummaryTableOptions ==
                          WorkSummaryTableOptions.TODAY,
                      onSelected: (bool selected) {
                        if (selected) {
                          model.workSummaryTableOptions =
                              WorkSummaryTableOptions.TODAY;
                          model.notifyListeners();
                        }
                      },
                      selectedColor: Theme.of(context).primaryColorLight,
                      checkmarkColor: Colors.black,
                    ),
                    wSizedBox(width: 4),
                    FilterChip(
                      label: const Text('Yesterday'),
                      labelStyle: TextStyle(
                        color: model.workSummaryTableOptions ==
                                WorkSummaryTableOptions.YESTERDAY
                            ? Colors.black
                            : Colors.white,
                      ),
                      selected: model.workSummaryTableOptions ==
                          WorkSummaryTableOptions.YESTERDAY,
                      onSelected: (bool selected) {
                        if (selected) {
                          model.workSummaryTableOptions =
                              WorkSummaryTableOptions.YESTERDAY;
                          model.notifyListeners();
                        }
                      },
                      selectedColor: Theme.of(context).primaryColorLight,
                      checkmarkColor: Colors.black,
                    ),
                    wSizedBox(width: 4),
                    FilterChip(
                      label: const Text('Custom'),
                      labelStyle: TextStyle(
                        color: model.workSummaryTableOptions ==
                                WorkSummaryTableOptions.CUSTOM
                            ? Colors.black
                            : Colors.white,
                      ),
                      selected: model.workSummaryTableOptions ==
                          WorkSummaryTableOptions.CUSTOM,
                      onSelected: (bool selected) async {
                        if (selected) {
                          model.selectedDate = await selectDate();
                          if (model.selectedDate != null) {
                            model.workSummaryTableOptions =
                                WorkSummaryTableOptions.CUSTOM;
                            model.notifyListeners();
                          }
                        }
                      },
                      selectedColor: Theme.of(context).primaryColorLight,
                      checkmarkColor: Colors.black,
                    ),
                    wSizedBox(width: 4),
                  ],
                )
              ],
            ),
            const ProductCreatedHeader(),
            Flexible(
              child: ListView.separated(
                  itemBuilder: (context, index) => ProductCreatedListItem(
                      item: model.productsCreated.elementAt(index)),
                  separatorBuilder: (context, index) => const DottedDivider(),
                  itemCount: model.productsCreated.length),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => UserwiseProductsCreatedViewModel(),
    );
  }
}

class ProductCreatedListItem extends StatelessWidget {
  const ProductCreatedListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final StatisticsProductsCreated item;

  getUserRole({required String role}) {
    if (role == AuthenticatedUserRoles.ROLE_DEO.getStatusString) {
      return 'Data Entry Operator';
    } else if (role == AuthenticatedUserRoles.ROLE_GD.getStatusString) {
      return 'Designer';
    } else if (role == AuthenticatedUserRoles.ROLE_SUPVR.getStatusString) {
      return 'Supervisor';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecorativeContainer.transparent(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: item.user,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: item.authority != null
                  ? getUserRole(role: item.authority!)
                  : null,
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: item.productCreated.toString(),
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: item.brandCount.toString(),
            ),
          ),
          Expanded(
            flex: 1,
            child: NullableTextWidget(
              stringValue: item.typeCount.toString(),
            ),
          ),
        ],
      ),
    );
  }
}

class UserwiseProductsCreatedViewArguments {}

class ProductCreatedHeader extends StatelessWidget {
  const ProductCreatedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        (AppTextStyles(context: context).getNormalTableTextStyle).copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return DecorativeContainer(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'User',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Role',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Products Created',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Brands',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Types',
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
