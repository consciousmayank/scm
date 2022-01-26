import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DemandAppQrCodeDialogBoxView extends StatefulWidget {
  const DemandAppQrCodeDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _DemandAppQrCodeDialogBoxViewState createState() =>
      _DemandAppQrCodeDialogBoxViewState();
}

class _DemandAppQrCodeDialogBoxViewState
    extends State<DemandAppQrCodeDialogBoxView> {
  @override
  Widget build(BuildContext context) {
    DemandAppQrCodeDialogBoxViewArguments arguments =
        widget.request.data as DemandAppQrCodeDialogBoxViewArguments;
    return ViewModelBuilder<DemandAppQrCodeDialogBoxViewModel>.reactive(
      viewModelBuilder: () => DemandAppQrCodeDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          noColorOnTop: true,
          contentPadding: const EdgeInsets.only(
            left: 150,
            right: 150,
            top: 50,
            bottom: 50,
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Column(
            children: [
              hSizedBox(height: 16),
              const Text(
                'Demand Application',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              hSizedBox(height: 16),
              const Text(
                'Scan QR Code to Download Application',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              hSizedBox(height: 32),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 72,
                              width: 282,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 32,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF646464),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    playStoreIcon,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  const Text(
                                    'Google Play',
                                    style: TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hSizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors().loginPageBg,
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: QrImage(
                                data: model.getPlayStoreUrl(),
                                version: QrVersions.auto,
                                size: 300.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    Image.asset(
                      verticalSeperatorIcon,
                      height: 300,
                      width: 10,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              height: 72,
                              width: 282,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 32,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF646464),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    appStoreIcon,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  const Text(
                                    'App Store',
                                    style: TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hSizedBox(
                              height: 32,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors().loginPageBg,
                                  width: 10,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: QrImage(
                                data: model.getAppStoreUrl(),
                                version: QrVersions.auto,
                                size: 300.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DemandAppQrCodeDialogBoxViewArguments {
  DemandAppQrCodeDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}

class DemandAppQrCodeDialogBoxViewModel extends BaseViewModel {
  String getPlayStoreUrl() {
    return "https://play.google.com/store/apps/details?id=com.geektecnotonic.demand";
  }

  String getAppStoreUrl() {
    //TODO :- To be changed when Appstore is ready
    return "https://play.google.com/store/apps/details?id=com.geektecnotonic.demand";
  }
}
