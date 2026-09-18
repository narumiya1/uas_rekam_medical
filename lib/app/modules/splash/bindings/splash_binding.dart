import 'package:get/get.dart';
import 'package:uas_medical/app/services/my_pref_service.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut(() => MyPrefService());
  }
}
