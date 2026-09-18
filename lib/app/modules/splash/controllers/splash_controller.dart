import 'package:get/get.dart';
import 'dart:async';

import 'package:uas_medical/app/routes/app_pages.dart';
import 'package:uas_medical/app/services/my_pref_service.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  Timer? _splashTimer;

  final MyPrefService _authService = Get.find<MyPrefService>();
  @override
  void onClose() {
    print('🔥 SplashController ON CLOSE');

    _splashTimer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    print('🔥 SplashController ON INIT');

    startSplash();
  }

  @override
  void onReady() {
    super.onReady();
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     RGet.offNamed(Routes.HOME);
    //   },
    // );
  }

  void movePage() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    Get.offAllNamed(Routes.HOME);
  }

  void startSplash() async {
    // await Future.delayed(const Duration(seconds: 3));
    // Get.offAllNamed(Routes.HOME);
    print("Splash Init");
    _splashTimer = Timer(const Duration(seconds: 5), () async {
      print("PINDAH HALAMAN");
      // Get.offAllNamed(Routes.HOME);

      print('🔥 5 detik selesai, menuju HOME');
      print('cek status login ${_authService.isLoggedIn}');

      if (_authService.isLoggedIn) {
        final userRole = _authService.isLoggedIn;
        print('status login ${userRole}');

        if (userRole == true) {
          print('Navigasi ke halaman Admin');
          Get.offAllNamed('/home');
        } else {
          print('Navigasi ke halaman default (login)');
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    });
  }
}
