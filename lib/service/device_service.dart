import 'dart:io';

import 'package:bluuffed_app/service/text_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier currentDevice = ValueNotifier(null);

class DeviceService {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final TextService textService = TextService();

  Device() async {
    Map<String, dynamic> device = <String, dynamic>{};

    Platform.isIOS
        ? device = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo)
        : device = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

    currentDevice.value = device;
  }

  String DeviceModel() {
    Device();
    return Platform.isIOS
        ? 'Iphone ${currentDevice.value['model']}' //TODO: rever quando add IOS
        : '${textService.capitalize(currentDevice.value['brand'])} ${currentDevice.value['model']}';
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
