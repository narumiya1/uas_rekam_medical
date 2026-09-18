import 'package:get/get.dart';

import '../controllers/halaman_laporan_pkm_controller.dart';

class HalamanLaporanPkmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HalamanLaporanPkmController>(
      () => HalamanLaporanPkmController(),
    );
  }
}
