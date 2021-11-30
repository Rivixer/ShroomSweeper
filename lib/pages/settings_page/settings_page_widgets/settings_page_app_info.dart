import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static Future<String> getAppVersion() async {
    try {
      var packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      return 'debug';
    }
  }
}

Center getAppVersionWidget() {
  return Center(
      child: FutureBuilder<String>(
    future: AppInfo.getAppVersion(),
    builder: (context, snapshot) => Text("Wersja: ${snapshot.data.toString()}"),
  ));
}
