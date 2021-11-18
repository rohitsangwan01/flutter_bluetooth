import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/app/data/helper.dart';
import 'package:flutter_bluetooth/app/services/device_service.dart';

import 'package:get/get.dart';

import '../controllers/connected_device_controller.dart';

class ConnectedDeviceView extends GetView<ConnectedDeviceController> {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      onFirstBackPress: () {
        DeviceService.to.onDisconnectClick();
      },
      waitForSecondBackPress: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.device!.name),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'ID : ' +
                      controller.device!.id +
                      '\n' +
                      '\n' +
                      'Name : ' +
                      controller.device!.name +
                      '\n' +
                      '\n' +
                      'ManufactureData : ' +
                      controller.device!.manufacturerData.toString() +
                      '\n' +
                      '\n' +
                      'RSSI : ' +
                      controller.device!.rssi.toString() +
                      '\n' +
                      '\n' +
                      'Service Data : ' +
                      controller.device!.serviceData.toString() +
                      '\n' +
                      '\n' +
                      'Service UUIDS : ' +
                      controller.device!.serviceUuids.toString(),
                  //textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              KButton(
                  onTap: () {
                    controller.onDisconnect();
                  },
                  child: Text('Disconnect')),
            ],
          ),
        ),
      ),
    );
  }
}
