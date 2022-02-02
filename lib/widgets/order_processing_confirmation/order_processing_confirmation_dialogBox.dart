import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_items_list_table.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/app_button.dart';
import 'package:scm/widgets/app_inkwell_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/order_processing_confirmation/order_processing_confirmation_dialogBox_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderProcessingConfirmationDialogBoxView extends StatefulWidget {
  final Function(DialogResponse) completer;
  final DialogRequest request;

  const OrderProcessingConfirmationDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  _OrderProcessingConfirmationDialogBoxViewState createState() =>
      _OrderProcessingConfirmationDialogBoxViewState();
}

class _OrderProcessingConfirmationDialogBoxViewState
    extends State<OrderProcessingConfirmationDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    OrderProcessingConfirmationDialogBoxViewArguments arguments = widget
        .request.data as OrderProcessingConfirmationDialogBoxViewArguments;
    return ViewModelBuilder<
        OrderProcessingConfirmationDialogBoxViewModel>.reactive(
      viewModelBuilder: () => OrderProcessingConfirmationDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          contentPadding: const EdgeInsets.only(
            left: 150,
            right: 150,
            top: 10,
            bottom: 10,
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Padding(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              children: [
                if (model.isPriceInAnyProductMissing(
                    orderList: arguments.orderList))
                  Text(
                    'Price is missing in Some Products. Please review the order.',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProcessingItemsListTable.header(values: [
                    Text(
                      '#',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                    ),
                    Text(
                      'TITLE',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      labelQuantity,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      'PRICE/UNIT',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                    ),
                    Text(
                      'AMOUNT',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors().primaryHeaderTextColor,
                          ),
                    )
                  ], flexValues: const [
                    1,
                    5,
                    3,
                    3,
                    1,
                    3
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ProcessingItemsListTable.normal(values: [
                          Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            '${arguments.orderList.elementAt(index).itemTitle}',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: NullableTextWidget.int(
                              formatNumber: true,
                              intValue: arguments.orderList
                                  .elementAt(index)
                                  .itemQuantity,
                              textAlign: TextAlign.center,
                              textStyle: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          NullableTextWidget.double(
                            formatNumber: true,
                            doubleValue:
                                arguments.orderList.elementAt(index).itemPrice,
                            textAlign: TextAlign.center,
                            textStyle: Theme.of(context).textTheme.headline6,
                          ),
                          NullableTextWidget.double(
                            formatNumber: true,
                            doubleValue: arguments.orderList
                                .elementAt(index)
                                .itemTotalPrice,
                            textAlign: TextAlign.right,
                            textStyle: Theme.of(context).textTheme.headline6,
                          )
                        ], flexValues: const [
                          1,
                          5,
                          3,
                          3,
                          3
                        ]),
                      );
                    },
                    itemCount: arguments.orderList.length,
                  ),
                ),
                SizedBox(
                  height: Dimens().buttonHeight,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          title: labelCancel,
                          buttonBg: AppColors().buttonRedColor,
                          onTap: () => widget.completer(
                            DialogResponse(
                              confirmed: false,
                              data: null,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      wSizedBox(width: 8),
                      Expanded(
                        child: AppButton(
                          title: labelOk,
                          buttonBg: AppColors().buttonGreenColor,
                          onTap: model.isPriceInAnyProductMissing(
                            orderList: arguments.orderList,
                          )
                              ? null
                              : () => widget.completer(
                                    DialogResponse(
                                      confirmed: true,
                                      data:
                                          OrderProcessingConfirmationDialogBoxViewOutArguments(
                                        orderList: arguments.orderList,
                                      ),
                                    ),
                                  ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderProcessingConfirmationDialogBoxViewArguments {
  final String title;
  final List<OrderItem> orderList;

  OrderProcessingConfirmationDialogBoxViewArguments({
    required this.title,
    required this.orderList,
  });
}

class OrderProcessingConfirmationDialogBoxViewOutArguments {
  final List<OrderItem> orderList;

  OrderProcessingConfirmationDialogBoxViewOutArguments({
    required this.orderList,
  });
}
