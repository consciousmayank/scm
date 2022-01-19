import 'package:flutter/material.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NotificationsScreenTablet
    extends ViewModelWidget<NotificationsListViewModel> {
  const NotificationsScreenTablet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, NotificationsListViewModel viewModel) {
    return Container(
      color: Colors.green,
    );
  }
}
