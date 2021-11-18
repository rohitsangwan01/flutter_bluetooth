import 'package:get/get.dart';

import 'package:flutter_bluetooth/app/modules/choose_device/bindings/choose_device_binding.dart';
import 'package:flutter_bluetooth/app/modules/choose_device/views/choose_device_view.dart';
import 'package:flutter_bluetooth/app/modules/connected_device/bindings/connected_device_binding.dart';
import 'package:flutter_bluetooth/app/modules/connected_device/views/connected_device_view.dart';
import 'package:flutter_bluetooth/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_bluetooth/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHOOSE_DEVICE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_DEVICE,
      page: () => ChooseDeviceView(),
      binding: ChooseDeviceBinding(),
    ),
    GetPage(
      name: _Paths.CONNECTED_DEVICE,
      page: () => ConnectedDeviceView(),
      binding: ConnectedDeviceBinding(),
    ),
  ];
}
