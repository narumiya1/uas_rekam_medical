import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/app/services/my_pref_service.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final MyPrefService _authService = Get.find<MyPrefService>();

  @override
  void onInit() {
    super.onInit();
  }

  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  final RxBool isLoading = false.obs;

  Future<void> login() async {
    final email = userController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Gagal', 'Email dan password wajib diisi.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    // LOGIN UNTUK ADMIN DI SET admin & admin123
    try {
      if (email == 'admin' && password == 'admin123') {
        await saveLoginStatusPreff(
          username: email,
          password: password,
          role: 'admin',
          uid: 'admin-uid',
        );
        // ke view home
        Get.offAllNamed('/home');
        return;
      } else {
        Get.snackbar(
          'Gagal Login',
          'Email atau password salah.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    } catch (e) {
      Get.snackbar(
        'Gagal Login',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveLoginStatusPreff({
    required String username,
    required String password,
    required String role,
    required String uid,
  }) async {
    await _authService.setLoggedIn(true);

    await _authService.setUserRoleAdmin(username);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
