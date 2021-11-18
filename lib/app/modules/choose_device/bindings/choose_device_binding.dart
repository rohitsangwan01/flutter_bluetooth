import 'package:get/get.dart';

import '../controllers/choose_device_controller.dart';

class ChooseDeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDeviceController>(
      () => ChooseDeviceController(),
    );
  }
}
