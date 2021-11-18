// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bluetooth/app/data/UI.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Validators {
  static Future<bool> checkLocationPermission() async {
    //if your Bluetooth dont require gps , u can uncomment this
    // if (GetPlatform.isIOS) return true;

    final serviceStatus = await Permission.location.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      //This will return if Your Gps is OFF
      Ui.ErrorSnackBar(message: "Please Turn on Location").show();
      return false;
    }
    bool Result = false;
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      Result = true;
    } else if (status == PermissionStatus.denied) {
      Ui.ErrorSnackBar(
              message: "Permission denied , app wont work wihtout permission")
          .show();
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page !.');
      await openAppSettings();
    }
    return Result;
  }

  static Future<bool> checkBluetoothPermission() async {
    bool Result = false;
    final status = await Permission.bluetooth.request();

    if (status == PermissionStatus.granted) {
      print('Permission granted');
      Result = true;
    } else if (status == PermissionStatus.denied) {
      Ui.ErrorSnackBar(
              message: "Permission denied , app wont work wihtout permission")
          .show();
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }

    //Here Code For Android To auto Turn on Bluetooth

    if (GetPlatform.isAndroid) {
      bool? isBluetoothOn = await FlutterBluetoothSerial.instance.isEnabled;

      if (!(isBluetoothOn ?? false)) {
        await FlutterBluetoothSerial.instance
            .requestEnable()
            .then((value) async {
          if (value ?? false) {
            Result = true;
          } else {
            Ui.Error("App Can't Work Without Bluetooth");
          }
        });
      } else {
        Result = false;
      }
    }

    return Result;
  }
}
