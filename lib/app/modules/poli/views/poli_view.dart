import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/models/poli.dart';
import '../controllers/poli_controller.dart';

class PoliView extends GetView<PoliController> {
  const PoliView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A896); // Teal Utama

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
        title: const Text(
          "Data Poliklinik",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          final poliC = TextEditingController();

          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor:
                  0.6, // Kita sesuaikan biar lebih proporsional dengan 1 inputan
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
                        "Tambah Poliklinik",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: poliC,
                        decoration: const InputDecoration(
                          labelText: "Nama Poli",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                            final pol = Poli(
                              namaPoli: poliC.text,
                            );
                            controller.tambahPoli(pol);
                            // await controller.tambahPoli({
                            //   'nama_poli': poliC.text,
                            // });
                            Get.back();
                          },
                          child: const Text("Simpan"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
      body: Obx(() {
        if (controller.poliList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_hospital_rounded,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  "Belum ada data unit poliklinik",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.poliList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) {
            final p = controller.poliList[index];
            return ListTile(
              title: Text(p.namaPoli),
              // subtitle: Text(p.id ?? '-'),
            );
          },
          /**   itemBuilder: (context, index) {
            final data = controller.poliList[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.door_sliding_rounded,
                      color: Colors.redAccent, size: 24),
                ),
                title: Text(
                  data['nama_poli'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Hapus Poli",
                      middleText:
                          "Hapus unit ${data['nama_poli']} dari sistem?",
                      textConfirm: "Hapus",
                      textCancel: "Batal",
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.redAccent,
                      onConfirm: () {
                        controller.hapusPoli(data['id']);
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            );
          },
     **/
        );
      }),
    );
  }
}
