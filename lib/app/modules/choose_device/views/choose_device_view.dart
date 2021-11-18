// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/app/services/device_service.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'package:get/get.dart';

import '../controllers/choose_device_controller.dart';

class ChooseDeviceView extends GetView<ChooseDeviceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Choose Device View'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.onScanClick();
                },
                icon: Icon(Icons.refresh))
          ]),
      body: Center(
        child: Obx(() => DeviceService.to.isScanning.value
            ? CircularProgressIndicator()
            : DeviceService.to.DiscoveredDevices.isEmpty
                ? Text('Scan to Show Devices')
                : ListView.builder(
                    itemCount: DeviceService.to.DiscoveredDevices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DeviceList(
                          DeviceService.to.DiscoveredDevices[index]);
                    },
                  )),
      ),
    );
  }

  Widget DeviceList(DiscoveredDevice device) {
    return InkWell(
      onTap: () {
        controller.OnConnect(device);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            title: Text(device.id),
            trailing: Text(device.name),
          ),
        ),
      ),
    );
  }
}
