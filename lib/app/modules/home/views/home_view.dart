import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "Sistem Informasi Rekam Medis",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.local_hospital_rounded, size: 30),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            menu(title: "Pasien", icon: Icons.people, route: "/pasien"),
            menu(
                title: "Dokter",
                icon: Icons.medical_services,
                route: "/dokter"),
            menu(title: "Obat", icon: Icons.medication, route: "/obat"),
            menu(title: "Poli", icon: Icons.local_hospital, route: "/poli"),
            menu(title: "Pendaftaran", icon: Icons.edit, route: "/pendaftaran"),
            menu(title: "Laporan", icon: Icons.print, route: "/laporan"),
          ],
        ),
      ),
      // BAGIAN BAWAH
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: const Text(
          // " © Sri Sumarni - 25403024 - MIK-L41/25",
          "Devina Qurrota ‘Aini Setiawan - 25403043 -\nMIK-EL41/25",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget menu({
    required String title,
    required IconData icon,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
