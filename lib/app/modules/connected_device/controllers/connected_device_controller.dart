import 'package:flutter_bluetooth/app/services/device_service.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class ConnectedDeviceController extends GetxController {
  DiscoveredDevice? device;

  @override
  void onInit() {
    device = Get.arguments;
    super.onInit();
  }

  onDisconnect() {
    DeviceService.to.onDisconnectClick();
  }
}
