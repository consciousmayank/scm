import 'package:flutter/material.dart';
import 'package:scm/app/dimens.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_viewmodel.dart';
import 'package:scm/utils/utils.dart';
import 'package:scm/widgets/dotted_divider.dart';
import 'package:stacked/stacked.dart';

class NotificationsScreenDesktop
    extends ViewModelWidget<NotificationsListViewModel> {
  const NotificationsScreenDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, NotificationsListViewModel viewModel) {
    return Scaffold(
      appBar: appbarWidget(
        context: context,
        title: 'Notifications',
        automaticallyImplyLeading: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Card(
              shape: Dimens().getCardShape(),
              child: Flexible(
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      viewModel.appNotificationsList[index].notification.title,
                    ),
                    subtitle: Text(
                      viewModel.appNotificationsList[index].notification.body,
                    ),
                  ),
                  separatorBuilder: (context, index) => const DottedDivider(),
                  itemCount: viewModel.appNotificationsList.length,
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: viewModel.getSelectedView(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
