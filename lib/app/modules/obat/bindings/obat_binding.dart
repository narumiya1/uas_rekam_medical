import 'package:get/get.dart';

import '../controllers/obat_controller.dart';

class ObatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObatController>(
      () => ObatController(),
    );
  }
}
