import 'package:flutter_bluetooth/app/services/device_service.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class ChooseDeviceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  onScanClick() async {
    DeviceService.to.onScanClick();
  }

  OnConnect(DiscoveredDevice de) async {
    await DeviceService.to.onConnectClick(de);
  }

  

  
}
