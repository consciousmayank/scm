import 'package:flutter/material.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:scm/widgets/version_widget/version_widget_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VersionWidgetView extends StatelessWidget {
  const VersionWidgetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VersionWidgetViewModel>.reactive(
      builder: (context, model, child) => Center(
        child: FutureBuilder<String>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NullableTextWidget(
                stringValue: snapshot.data,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEFEFEF),
                ),
              );
            } else {
              return const NullableTextWidget(
                stringValue: '',
              );
            }
          },
          future: model.getAppVersion(),
        ),
      ),
      viewModelBuilder: () => VersionWidgetViewModel(),
    );
  }
}
