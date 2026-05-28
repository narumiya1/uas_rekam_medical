import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pasien_controller.dart';

class PasienView extends GetView<PasienController> {
  const PasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A896); // Teal modern senada dengan Home

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background soft
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
        title: const Text(
          "Data Pasien",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      // Modernized FloatingActionButton
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          final namaC = TextEditingController();
          final alamatC = TextEditingController();
          final teleponC = TextEditingController();
          final tanggalC = TextEditingController();

          // BOTTOM SHEET DIASUMSIKAN SAMA (TIDAK DIUBAH SUEAI REQUEST)
          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tambah Pasien",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: namaC,
                        decoration: const InputDecoration(
                          labelText: "Nama Pasien",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: alamatC,
                        decoration: const InputDecoration(
                          labelText: "Alamat",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: teleponC,
                        decoration: const InputDecoration(
                          labelText: "Telepon",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: tanggalC,
                        decoration: const InputDecoration(
                          labelText: "Tanggal Lahir",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () async {
                            await controller.tambahPasien({
                              'nama': namaC.text,
                              'alamat': alamatC.text,
                              'telepon': teleponC.text,
                              'tanggal_lahir': tanggalC.text,
                            });
                            Get.back();
                            Get.snackbar(
                              "Berhasil",
                              "Data pasien berhasil ditambahkan",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black87,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                            );
                          },
                          child: const Text("Simpan"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),

      // Refactored Body List Pasien
      body: Obx(() {
        if (controller.pasienList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off_rounded,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  "Belum ada data pasien",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.pasienList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) {
            final data = controller.pasienList[index];
            final String nama = data['nama'] ?? '-';
            // Ambil inisial nama untuk avatar (Contoh: "Budi" -> "B")
            final String inisial =
                nama.isNotEmpty ? nama[0].toUpperCase() : 'P';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Theme(
                  // Menghilangkan highlight border bawaan expansion/list tile jika ada
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: primaryColor.withOpacity(0.1),
                      child: Text(
                        inisial,
                        style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    title: Text(
                      nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.cake_rounded,
                              size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            data['tanggal_lahir'] ?? '-',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded,
                              color: Colors.redAccent),
                          onPressed: () {
                            // Dialog konfirmasi biar tidak sengaja terhapus
                            Get.defaultDialog(
                                title: "Hapus Data",
                                middleText:
                                    "Apakah Anda yakin ingin menghapus data pasien ini?",
                                textConfirm: "Ya",
                                textCancel: "Batal",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.redAccent,
                                onConfirm: () {
                                  controller.hapusPasien(data['id']);
                                  Get.back();
                                });
                          },
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey[400]),
                      ],
                    ),

                    // Detail info dropdown saat card di-tap/buka
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            const Divider(height: 1),
                            const SizedBox(height: 12),
                            _buildDetailRow(Icons.location_on_rounded, "Alamat",
                                data['alamat']),
                            const SizedBox(height: 8),
                            _buildDetailRow(Icons.phone_rounded, "No. Telepon",
                                data['telepon']),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Helper Widget untuk baris detail agar rapi
  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Color(0xFF00A896).withOpacity(0.7)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 13, color: Colors.black87, fontFamily: 'Roboto'),
              children: [
                TextSpan(
                    text: "$label: ",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey)),
                TextSpan(text: value ?? '-'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
