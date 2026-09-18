import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna bertema medis/modern
    const primaryColor = Color(0xFF00A896); // Teal modern
    const secondaryColor = Color(0xFF028090);

    return Scaffold(
      backgroundColor:
          Colors.grey[50], // Background agak soft abu-abu biar card menonjol
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Row(
          children: [
            Icon(Icons.home, color: primaryColor, size: 28),
            SizedBox(width: 8),
            Text(
              "Sistem Rekam Medis",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Profil user dibuat lebih rapi di pojok kanan
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Sri Sumarni",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800]),
                    ),
                    const Text(
                      "25403024 - MIK-L41/25",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor.withValues(alpha: 0.1),
                  child: const Icon(Icons.person_rounded,
                      color: primaryColor, size: 20),
                ),
                Divider(),
                IconButton(
                  onPressed: controller.showLogoutDialog,
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Selamat Datang / Informasi Tambahan
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ]),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang di Dashboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Silahkan pilih menu rekam medis di bawah untuk mengelola data.",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Menu Utama",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
            ),

            // Grid Menu Utama
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio:
                  1.1, // Membuat ukuran kotak sedikit lebih proporsional
              children: [
                // BKS Route dan warna disesuaikan dengan tema medis/modern
                _buildMenuItem(
                    title: "Pasien",
                    icon: Icons.people_alt_rounded,
                    route: "/pasien",
                    color: Colors.blue),
                _buildMenuItem(
                    title: "Dokter pkm",
                    icon: Icons.medication_liquid_rounded,
                    route: "/dokter",
                    color: Colors.teal),
                _buildMenuItem(
                    title: "Obat",
                    icon: Icons.medication_rounded,
                    route: "/obat",
                    color: Colors.orange),
                _buildMenuItem(
                    title: "Poli",
                    icon: Icons.local_hospital_rounded,
                    route: "/poli",
                    color: Colors.redAccent),
                _buildMenuItem(
                    title: "Pendaftaran",
                    icon: Icons.assignment_turned_in_rounded,
                    route: "/pendaftaran",
                    color: Colors.purple),
                _buildMenuItem(
                    title: "Riwayat Pasien",
                    icon: Icons.analytics_rounded,
                    route: "/laporan",
                    color: Colors.indigo),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required String route,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          // BKS Ketika menu di klik, navigasi ke halaman yang sesuai
          onTap: () => Get.toNamed(route),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Efek lingkaran di belakang icon biar kekinian
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 32, color: color),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
