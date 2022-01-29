import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SupplyAppQrCodeDialogBoxView extends StatefulWidget {
  const SupplyAppQrCodeDialogBoxView({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  final Function(DialogResponse) completer;
  final DialogRequest request;

  @override
  _SupplyAppQrCodeDialogBoxViewState createState() =>
      _SupplyAppQrCodeDialogBoxViewState();
}

class _SupplyAppQrCodeDialogBoxViewState
    extends State<SupplyAppQrCodeDialogBoxView> {
  late double screenWidth,
      screenHeight,
      maxWidthOfOuterContainer,
      maxWidthOfItems;

  List<Widget> getAppStoreQrCode({
    required SupplyAppQrCodeDialogBoxViewModel model,
  }) {
    return [
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              appStoreIcon,
              height: getValueForScreenType(
                context: context,
                mobile: 40,
                tablet: 20,
                desktop: 40,
              ),
              width: getValueForScreenType(
                context: context,
                mobile: 40,
                tablet: 20,
                desktop: 40,
              ),
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
        height: screenWidth / 2,
        alignment: Alignment.center,
        child: QrImage(
          data: model.getAppStoreUrl(),
          version: QrVersions.auto,
          size: screenWidth / 2,
        ),
      ),
    ];
  }

  List<Widget> getGooglePlayStoreQrCode({
    required SupplyAppQrCodeDialogBoxViewModel model,
  }) {
    return [
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              playStoreIcon,
              height: getValueForScreenType(
                context: context,
                mobile: 40,
                tablet: 20,
                desktop: 40,
              ),
              width: getValueForScreenType(
                context: context,
                mobile: 40,
                tablet: 20,
                desktop: 40,
              ),
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
        height: screenWidth / 2,
        alignment: Alignment.center,
        child: QrImage(
          data: model.getPlayStoreUrl(),
          version: QrVersions.auto,
          size: screenWidth / 2,
        ),
      ),
    ];
  }

  getBarcodesRow({required SupplyAppQrCodeDialogBoxViewModel model}) {
    return Expanded(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          playStoreIcon,
                          height: getValueForScreenType(
                            context: context,
                            mobile: 20,
                            tablet: 20,
                            desktop: 40,
                          ),
                          width: getValueForScreenType(
                            context: context,
                            mobile: 20,
                            tablet: 20,
                            desktop: 40,
                          ),
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Google Play',
                          style: TextStyle(
                            fontSize: getValueForScreenType(
                                context: context,
                                mobile: 12,
                                desktop: 28,
                                tablet: 16),
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
                      size: getValueForScreenType(
                        context: context,
                        mobile: MediaQuery.of(context).size.width / 4,
                        tablet: MediaQuery.of(context).size.height / 4,
                        desktop: MediaQuery.of(context).size.height / 3,
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          appStoreIcon,
                          height: getValueForScreenType(
                            context: context,
                            mobile: 20,
                            tablet: 20,
                            desktop: 40,
                          ),
                          width: getValueForScreenType(
                            context: context,
                            mobile: 20,
                            tablet: 20,
                            desktop: 40,
                          ),
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'App Store',
                          style: TextStyle(
                            fontSize: getValueForScreenType(
                                context: context,
                                mobile: 12,
                                desktop: 28,
                                tablet: 16),
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
                      size: getValueForScreenType(
                        context: context,
                        mobile: MediaQuery.of(context).size.width / 4,
                        tablet: MediaQuery.of(context).size.height / 4,
                        desktop: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    maxWidthOfOuterContainer = screenWidth * 0.45;
    maxWidthOfItems = getValueForScreenType(
      context: context,
      mobile: screenWidth,
      tablet: screenWidth * 0.40,
      desktop: screenWidth * 0.40,
    );

    SupplyAppQrCodeDialogBoxViewArguments arguments =
        widget.request.data as SupplyAppQrCodeDialogBoxViewArguments;
    return ViewModelBuilder<SupplyAppQrCodeDialogBoxViewModel>.reactive(
      viewModelBuilder: () => SupplyAppQrCodeDialogBoxViewModel(),
      builder: (context, model, child) => CenteredBaseDialog(
        arguments: CenteredBaseDialogArguments(
          noColorOnTop: true,
          contentPadding: EdgeInsets.only(
            left: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: 0,
              desktop: screenWidth * 0.20,
            ),
            right: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: 0,
              desktop: screenWidth * 0.20,
            ),
            top: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: screenWidth * 0.05,
              desktop: screenWidth * 0.020,
            ),
            bottom: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: screenWidth * 0.05,
              desktop: screenWidth * 0.020,
            ),
          ),
          request: widget.request,
          completer: widget.completer,
          title: arguments.title,
          child: Column(
            children: [
              hSizedBox(height: 16),
              const Text(
                'Supply Application',
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
              getValueForScreenType(
                context: context,
                mobile: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ...getGooglePlayStoreQrCode(model: model),
                        hSizedBox(height: 16),
                        RotatedBox(
                          quarterTurns: -1,
                          child: Image.asset(
                            verticalSeperatorIcon,
                            height: 300,
                            width: 10,
                            fit: BoxFit.cover,
                          ),
                        ),
                        hSizedBox(height: 16),
                        ...getAppStoreQrCode(model: model),
                      ],
                    ),
                  ),
                ),
                tablet: getBarcodesRow(
                  model: model,
                ),
                desktop: getBarcodesRow(
                  model: model,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupplyAppQrCodeDialogBoxViewArguments {
  SupplyAppQrCodeDialogBoxViewArguments({
    required this.title,
  });

  final String title;
}

class SupplyAppQrCodeDialogBoxViewModel extends BaseViewModel {
  String getPlayStoreUrl() {
    return "https://play.google.com/store/apps/details?id=com.geektechnotonic.supply";
  }

  String getAppStoreUrl() {
    //TODO :- To be changed when Appstore is ready
    return "https://play.google.com/store/apps/details?id=com.geektechnotonic.supply";
  }
}
