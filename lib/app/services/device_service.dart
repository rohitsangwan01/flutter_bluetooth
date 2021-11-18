import 'dart:async';

import 'package:flutter_bluetooth/app/data/validators.dart';
import 'package:flutter_bluetooth/app/routes/app_pages.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DeviceService extends GetxService {
  static DeviceService get to => Get.find();

  Future<DeviceService> init() async => this;

  //Instances
  late FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  //Streams
  StreamSubscription? _deviceStream;
  StreamSubscription? _scanStream;

  //Device
  Rx<DiscoveredDevice?> device = Rx(null);
  RxBool isScanning = false.obs;
  RxList DiscoveredDevices = [].obs;

  onScanClick() async {
    isScanning(true);
    DiscoveredDevices.clear();
    if (await Validators.checkBluetoothPermission() &&
        await Validators.checkLocationPermission()) {
      //here will be main Scanning Code
      _scanStream = flutterReactiveBle.scanForDevices(
          withServices: [Uuid.parse('81f12000-59c5-4255-bad2-7685cc587fd3')],
          scanMode: ScanMode.lowLatency).listen((event) {
        //here will be devices

        if (DiscoveredDevices.every((element) => element.id != event.id)) {
          print(event);
          DiscoveredDevices.add(event);
        }
      });
      await Future.delayed(Duration(seconds: 2));
      _scanStream!.cancel();
      isScanning(false);
    }
  }

  onConnectClick(DiscoveredDevice de) {
    _deviceStream = flutterReactiveBle
        .connectToDevice(id: de.id, connectionTimeout: Duration(seconds: 5))
        .listen((state) {
      if (state.connectionState == DeviceConnectionState.connected) {
        // device.value = de;
        print('Connected');
        Get.toNamed(Routes.CONNECTED_DEVICE, arguments: de);
      } else if (state.connectionState == DeviceConnectionState.disconnected) {
        print('Disconnected');
        //  device.value = null;
        Get.offAllNamed(Routes.CHOOSE_DEVICE);
      }
    });
  }

  onDisconnectClick() {
    if (_deviceStream != null) {
      _deviceStream!.cancel();
    }
    Get.offAllNamed(Routes.CHOOSE_DEVICE);
  }
}
