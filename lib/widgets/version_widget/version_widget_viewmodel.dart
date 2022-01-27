import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';

class VersionWidgetViewModel extends BaseViewModel {
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v ${packageInfo.version}.'
        '${packageInfo.buildNumber}';
  }
}
