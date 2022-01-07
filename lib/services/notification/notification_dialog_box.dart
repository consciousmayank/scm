import 'package:flutter/material.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/enums/notification_type.dart';
import 'package:scm/screens/order_list_page/helper_widgets/processing_order_widget_view.dart';
import 'package:scm/screens/order_list_page/order_list_page_view.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationDialogBoxView extends StatefulWidget {
  const NotificationDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _NotificationDialogBoxViewState createState() =>
      _NotificationDialogBoxViewState();
}

class _NotificationDialogBoxViewState extends State<NotificationDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    NotificationDialogBoxViewArguments arguments =
        widget.request.data as NotificationDialogBoxViewArguments;
    return ViewModelBuilder<NotificationDialogBoxViewModel>.reactive(
      onModelReady: (model) => model.init(arguments: arguments),
      viewModelBuilder: () => NotificationDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          contentPadding: const EdgeInsets.only(
            left: 50,
            right: 50,
            top: 20,
            bottom: 20,
          ),
          request: widget.request,
          completer: widget.completer,
          title: model.gettitle(),
          child: model.getView(),
        ),
      ),
    );
  }
}

class NotificationDialogBoxViewArguments {
  NotificationDialogBoxViewArguments.orderDetails({
    this.type = NotificationType.ORDERS,
    required this.orderId,
  });

  final int? orderId;
  final NotificationType type;
}

class NotificationDialogBoxViewModel extends BaseViewModel {
  late final NotificationDialogBoxViewArguments arguments;

  init({required NotificationDialogBoxViewArguments arguments}) {
    this.arguments = arguments;
  }

  gettitle() {
    switch (arguments.type) {
      case NotificationType.ORDERS:
        return labelOrderDetail;
    }
  }

  getView() {
    switch (arguments.type) {
      case NotificationType.ORDERS:
        return OrderListPageView(
          arguments: OrderListPageViewArguments.notification(
            orderId: arguments.orderId,
          ),
        );
    }
  }
}
