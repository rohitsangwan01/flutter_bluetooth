import 'package:flutter/material.dart';
import 'package:flutter_bluetooth/app/services/device_service.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future initGetServices() async {
  await Get.putAsync(() => DeviceService().init());
}

void main() async {
  await initGetServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
