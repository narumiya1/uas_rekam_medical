import 'package:get/get.dart';
import 'dart:async';

import 'package:uas_medical/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  Timer? _splashTimer;

  @override
  void onInit() {
    super.onInit();
    print("Splash Init");
    _splashTimer = Timer(const Duration(seconds: 3), () async {
      print("PINDAH HALAMAN");
      Get.offAllNamed(Routes.HOME);
    });
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offNamed(Routes.HOME);
      },
    );
  }

  void movePage() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    Get.offAllNamed(Routes.HOME);
  }

  void startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(Routes.HOME);
  }
}
