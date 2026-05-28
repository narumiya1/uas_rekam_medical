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
          children: [
            Row(
              children: [
                Icon(Icons.local_hospital_rounded, size: 30),
                const Text("SIM Rekam Medis", style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Sri Sumarni \t\t",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          menu(title: "Pasien", icon: Icons.people, route: "/pasien"),
          menu(title: "Dokter", icon: Icons.medical_services, route: "/dokter"),
          menu(title: "Obat", icon: Icons.medication, route: "/obat"),
          menu(title: "Poli", icon: Icons.local_hospital, route: "/poli"),
          menu(
              title: "Pendaftaran",
              icon: Icons.app_registration,
              route: "/pendaftaran"),
          menu(title: "Laporan", icon: Icons.print, route: "/laporan"),
        ],
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
        elevation: 5,
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
