import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get/instance_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class Validators {
  static Future<bool> checkLocationPermission() async {
    final serviceStatus = await Permission.location.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      //put a Error if Gps is not ON
      return false;
    }
    bool Result = false;
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('permission granted for location');
      Result = true;
    } else if (status == PermissionStatus.denied) {
      //here put a Code for Displaying Error

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
      //display Error
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
    return Result;
  }
}
