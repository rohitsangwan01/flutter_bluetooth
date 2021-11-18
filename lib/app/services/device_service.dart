// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'dart:async';

import 'package:flutter_bluetooth/app/data/UI.dart';
import 'package:flutter_bluetooth/app/data/helper.dart';
import 'package:flutter_bluetooth/app/data/validators.dart';
import 'package:flutter_bluetooth/app/routes/app_pages.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DeviceService extends GetxService {
  static DeviceService get to => Get.find();

  Future<DeviceService> init() async => this;

  @override
  void onInit() {
    //Here Place any Initial Code you want to Execute
    super.onInit();
  }

  //Instances
  late FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  //Streams
  StreamSubscription? _deviceStream;
  StreamSubscription? _scanStream;

  //Device
  Rx<DiscoveredDevice?> device = Rx(null);
  RxBool isScanning = false.obs;
  RxList DiscoveredDevices = [].obs;
  int ScanTime = 4;

  ///Call This Method To Start Scanning and Auto Stop
  onScanClick() async {
    isScanning(true);
    DiscoveredDevices.clear();
    if (await Validators.checkBluetoothPermission() &&
        await Validators.checkLocationPermission()) {
      //here will be main Scanning Code
      _scanStream = flutterReactiveBle.scanForDevices(withServices: [
        // Uuid.parse('your_service_UUID_here')
      ], scanMode: ScanMode.lowLatency).listen((event) {
        //here We Will Get Device Lists
        if (DiscoveredDevices.every((element) => element.id != event.id)) {
          print(event);
          DiscoveredDevices.add(event);
        }
      });

      ///Here After [ScanTime] Scan will Auto Stop
      await Future.delayed(Duration(seconds: ScanTime));
      _scanStream!.cancel();
      isScanning(false);
    }
  }

  ///Call This Method To Connect To Selected Device
  onConnectClick(DiscoveredDevice de) {
    _deviceStream = flutterReactiveBle
        .connectToDevice(id: de.id, connectionTimeout: Duration(seconds: 5))
        .listen((state) {
      switch (state.connectionState) {
        case DeviceConnectionState.connecting:
          print('Connecting');
          break;
        case DeviceConnectionState.connected:
          print('Connected');
          device.value = de;
          Get.toNamed(Routes.CONNECTED_DEVICE, arguments: de);
          break;
        case DeviceConnectionState.disconnecting:
          print('Disconnecting');
          break;
        case DeviceConnectionState.disconnected:
          print('Disconnected');
          device.value = null;
          Get.offAllNamed(Routes.CHOOSE_DEVICE);
          break;
      }
    });
  }

  ///Call This Method To Disconnect To Device
  onDisconnectClick() {
    kDialog('', 'Do you really want to disconnect from the device ?', () {
      Get.back();
      try {
        if (_deviceStream != null) _deviceStream!.cancel();
        device.value = null;
        Get.offAllNamed(Routes.CHOOSE_DEVICE);
        Ui.defaultSnackBar(title: "Alert", message: "Device Disconnected ")
            .show();
      } catch (e) {
        Ui.ErrorSnackBar(message: e.toString()).show();
      }
    });
  }

  //Use These Methods If You are Working with Single Device
  Future ReadCharacterstic(Uuid Service, Uuid CharID,
      {bool Convert = true}) async {
    try {
      if (DeviceService.to.device.value == null) {
        Ui.Error("No Device Connected");
        return 'NO_DATA';
      }
      final characteristic = QualifiedCharacteristic(
          serviceId: Service,
          characteristicId: CharID,
          deviceId: DeviceService.to.device.value!.id);

      final response = await DeviceService.to.flutterReactiveBle
          .readCharacteristic(characteristic);

      return Convert ? String.fromCharCodes(response) : response;
    } catch (e) {
      Get.log(e.toString());
      throw e.toString();
    }
  }

  Future WriteCharacterstic(Uuid Service, Uuid CharID, Data,
      {bool WithResponse = false, String? deviceID}) async {
    try {
      if (DeviceService.to.device.value == null) {
        Ui.Error("No Device Connected");
        return 'NO_DATA';
      }
      final characteristic = QualifiedCharacteristic(
          serviceId: Service,
          characteristicId: CharID,
          deviceId: deviceID ?? DeviceService.to.device.value!.id);

      if (WithResponse) {
        await DeviceService.to.flutterReactiveBle
            .writeCharacteristicWithResponse(characteristic, value: Data);
      } else {
        await DeviceService.to.flutterReactiveBle
            .writeCharacteristicWithoutResponse(characteristic, value: Data);
      }
    } catch (e) {
      Get.log(e.toString());
      Ui.Error(e.toString());
      throw e.toString();
    }
  }

  @override
  void onClose() {
    if (_deviceStream != null) _deviceStream!.cancel();
    if (_scanStream != null) _scanStream!.cancel();
    super.onClose();
  }
}
