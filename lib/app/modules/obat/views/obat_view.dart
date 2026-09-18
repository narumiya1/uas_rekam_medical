import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/currency.dart';
import 'package:uas_medical/models/obat.dart';

import '../controllers/obat_controller.dart';

class ObatView extends GetView<ObatController> {
  const ObatView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A896); // Warna teal senada
    const accentColor = Color(0xFF028090);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background dasar yang bersih
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
        title: const Text(
          "Data Inventaris Obat",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      // FloatingActionButton dengan desain modern melengkung
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          final namaC = TextEditingController();
          final stokC = TextEditingController();
          final hargaC = TextEditingController();

          // Bottom Sheet dibiarkan perilakunya sesuai request asli
          Get.bottomSheet(
            isScrollControlled: true,
            FractionallySizedBox(
              heightFactor: 0.6,
              child: Container(
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
                    TextField(
                      controller: namaC,
                      decoration: const InputDecoration(
                        labelText: "Nama Obat",
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: stokC,
                      decoration: const InputDecoration(
                        labelText: "Stok",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: hargaC,
                      decoration: const InputDecoration(
                        labelText: "Harga",
                      ),
                      keyboardType: TextInputType.number,
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
                          final obat = Obat(
                            namaObat: namaC.text,
                            stok: int.parse(stokC.text),
                            harga: int.parse(
                              hargaC.text.replaceAll(".", ""),
                            ),
                          );
                          controller.tambahObat(obat);

                          /** await controller.tambahObat({
                            'nama_obat': namaC.text,
                            'stok': int.parse(stokC.text),
                            'harga': int.parse(
                              hargaC.text.replaceAll(".", ""),
                            ),
                          }); **/

                          Get.back();
                        },
                        child: const Text("Simpan"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),

      // Tampilan daftar data obat yang di-uplift
      body: Obx(() {
        if (controller.obatList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medication_liquid_rounded,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  "Belum ada data obat tersedia",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.obatList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) {
            final p = controller.obatList[index];
            return ListTile(
              title: Text(p.namaObat),
              subtitle: Text('Stok: ${p.stok}, Harga: ${p.harga}'),
            );
          },
          /**  itemBuilder: (context, index) {
            final data = controller.obatList[index];
            final int stok = data['stok'] ?? 0;

            // Logika sederhana penentu warna penanda stok
            final Color stokBadgeColor =
                stok < 10 ? Colors.orange.shade50 : Colors.teal.shade50;
            final Color stokTextColor =
                stok < 10 ? Colors.orange.shade800 : Colors.teal.shade800;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.medication_rounded,
                      color: primaryColor, size: 26),
                ),
                title: Text(
                  data['nama_obat'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      // Badge untuk info stok obat
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: stokBadgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Stok: $stok",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: stokTextColor),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Teks info harga obat
                      Text(
                        CurrencyHelper.formatRupiah(data['harga']),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: accentColor),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Colors.redAccent),
                  onPressed: () {
                    // Dialog konfirmasi hapus agar operasional aman
                    Get.defaultDialog(
                      title: "Hapus Obat",
                      middleText:
                          "Hapus data obat ${data['nama_obat']} dari sistem?",
                      textConfirm: "Hapus",
                      textCancel: "Batal",
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.redAccent,
                      onConfirm: () {
                        controller.hapusObat(data['id']);
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
