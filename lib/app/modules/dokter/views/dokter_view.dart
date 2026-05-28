import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dokter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dokter_controller.dart';

class DokterView extends GetView<DokterController> {
  const DokterView({super.key});

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
          "Data Dokter",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final namaC = TextEditingController();
          final spesialisC = TextEditingController();
          final teleponC = TextEditingController();

          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Tambah Dokter",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: namaC,
                    decoration: const InputDecoration(
                      labelText: "Nama Dokter",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: spesialisC,
                    decoration: const InputDecoration(
                      labelText: "Spesialis",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: teleponC,
                    decoration: const InputDecoration(
                      labelText: "Telepon",
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.tambahDokter({
                          'nama': namaC.text,
                          'spesialis': spesialisC.text,
                          'telepon': teleponC.text,
                        });

                        Get.back();
                      },
                      child: const Text("Simpan"),
                    ),
                  )
                ],
              ),
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.dokterList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off_rounded,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  "Belum ada data Dokter",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.dokterList.length,
          itemBuilder: (context, index) {
            final data = controller.dokterList[index];
            final String nama = data['nama'] ?? '-';
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
                          Icon(Icons.health_and_safety,
                              size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            data['spesialis'] ?? '-',
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
                                    "Apakah Anda yakin ingin menghapus data dokter ini?",
                                textConfirm: "Ya",
                                textCancel: "Batal",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.redAccent,
                                onConfirm: () {
                                  controller.hapusDokter(data['id']);
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
                            _buildDetailRow(Icons.health_and_safety,
                                "Spelsialis", data['spesialis']),
                            const SizedBox(height: 8),
                            _buildDetailRow(Icons.phone_rounded, "No. Telepon",
                                data['telepon']),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                /** child: Card(
                  child: ListTile(
                    title: Text(data['nama']),
                    subtitle: Text(data['spesialis']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.hapusDokter(data['id']);
                      },
                    ),
                  ),
                ),
              **/
              ),
            );
          },
        );
      }),
    );
  }

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
