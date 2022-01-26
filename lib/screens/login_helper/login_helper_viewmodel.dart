import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/widgets/demand_app_qr_code_dialog_box.dart';
import 'package:scm/widgets/supply_app_qr_code_dialog_box.dart';

class LoginHelperViewModel extends GeneralisedBaseViewModel {
  void showDemandAppQrCodesDialogBox() async {
    await dialogService.showCustomDialog(
      variant: DialogType.DEMAND_APP_QR_CODE,
      data: DemandAppQrCodeDialogBoxViewArguments(title: ''),
    );
  }

  void showSupplyAppQrCodesDialogBox() async {
    await dialogService.showCustomDialog(
      variant: DialogType.SUPPLY_APP_QR_CODE,
      data: SupplyAppQrCodeDialogBoxViewArguments(title: ''),
    );
  }
}
