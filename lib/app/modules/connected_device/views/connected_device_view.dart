import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/app/services/device_service.dart';

import 'package:get/get.dart';

import '../controllers/connected_device_controller.dart';

class ConnectedDeviceView extends GetView<ConnectedDeviceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.device!.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              controller.device!.id,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    controller.onDisconnect();
                  },
                  child: Text('Disconnect')),
            )
          ],
        ),
      ),
    );
  }
}
