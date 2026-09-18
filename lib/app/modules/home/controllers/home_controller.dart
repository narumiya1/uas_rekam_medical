import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/app/services/my_pref_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  void increment() => count.value++;
  void showLogoutDialog() {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin logout?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back(); // Tutup dialog dulu
        await logout(); // Jalankan logout
      },
    );
  }

  final MyPrefService _authService = Get.find<MyPrefService>();

  Future<void> logout() async {
    try {
      // Clear local data (selalu dilakukan)
      await _authService.logout();
      print("✅ Local logout complete");
      Get.offAllNamed('/login'); // Navigasi ke halaman login
    } catch (e) {
      print("❌ AuthRepository.logout error: $e");
      // Tetap clear local data meskipun API error
      await _authService.logout();
      Get.offAllNamed('/login'); // Navigasi ke halaman login

      rethrow;
    }
  }
}
