import 'package:egyptians_abroad/app/core/custom_widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:freerasp/freerasp.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../language/app_string.dart';
import 'dpi_helper.dart';
import 'storage_helper.dart';

class SecurityHelper {
  String sha256HashHex =
      '00:63:25:C6:CB:8F:0C:B6:8C:36:80:5C:AF:6A:EE:3D:0E:A7:EA:17:7E:93:58:9D:D3:51:F3:A9:01:F8:D5:05';
  late TalsecConfig _config;
  late ThreatCallback _callback;

  SecurityHelper() {
    String base64Hash = hashConverter.fromSha256toBase64(sha256HashHex);
    _config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.getgroup.egyptians_abroad',
        signingCertHashes: [base64Hash],
      ),
      iosConfig: IOSConfig(
        bundleIds: ['com.getgroup.egyptians_abroad'],
        teamId: 'B397UC72J4',
      ),
      watcherMail: 'getgroupss@gmail.com',
      isProd: true,
    );
    _callback = ThreatCallback(
        onAppIntegrity: () => _isNotNormal(),
        onObfuscationIssues: () => _isNotNormal(),
        onDebug: () => _isNotNormal(),
        onDeviceBinding: () => _isNotNormal(),
        onDeviceID: () => _isNotNormal(),
        onHooks: () => _isNotNormal(),
        onPasscode: () => _isNotNormal(),
        onPrivilegedAccess: () => _isNotNormal(),
        onSecureHardwareNotAvailable: () => _isNotNormal(),
        onSimulator: () => _isNotNormal(),
        onUnofficialStore: () => _isNotNormal());
    Talsec.instance.attachListener(_callback);
  }

  Future<void> securityInit() async {
    SecurityHelper();
    Talsec.instance.start(_config).then((value) {
      print("success");
    }, onError: (e) {
      print(e);
    });
  }

  void _isNotNormal() {
    GetStorage().write(StorageHelper().encrypt(AppStrings.splashDiscription),
        StorageHelper().encrypt(AppStrings.sorry));
    checkIsNotNormal();
  }

  static void checkIsNotNormal() {
    if (GetStorage()
            .read(StorageHelper().encrypt(AppStrings.splashDiscription)) !=
        StorageHelper().encrypt(AppStrings.splashDiscription)) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialogWidget(
            textheight: fixDpiHeight(120),
            isSuccess: false,
            showButton: false,
            buttonText: '',
            onPress: () {},
            subtitle: 'هذا الجهاز غير مصرح له باستخدام التطبيق.',
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
