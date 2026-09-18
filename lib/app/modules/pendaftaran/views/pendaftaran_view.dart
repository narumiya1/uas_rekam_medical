import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/models/pendaftaran.dart';
import '../controllers/pendaftaran_controller.dart';

class PendaftaranView extends GetView<PendaftaranController> {
  const PendaftaranView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A896);
    const accentColor = Color(0xFF028090);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
        title: const Text(
          "Antrean & Pendaftaran",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          String? pasienId;
          String? dokterId;
          String? poliId;
          String? status;

          Get.bottomSheet(
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Tambah Pendaftaran",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Dropdown Pasien
                        DropdownButtonFormField<String>(
                          initialValue: pasienId,
                          items: controller.pasienList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e['id'].toString(),
                              child: Text(e['nama']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              pasienId = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Pilih Pasien",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Dropdown Dokter
                        DropdownButtonFormField<String>(
                          initialValue: dokterId,
                          items: controller.dokterList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e['id'].toString(),
                              child: Text(e['nama']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dokterId = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Pilih Dokter",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Dropdown Poli
                        DropdownButtonFormField<String>(
                          initialValue: poliId,
                          items: controller.poliList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e['id'].toString(),
                              child: Text(e['namaPoli']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              poliId = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Pilih Poli",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Dropdown Status
                        DropdownButtonFormField<String>(
                          initialValue: status,
                          items: ['UMUM']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Status Layanan",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: controller.diagnosaController,
                          decoration: const InputDecoration(
                            labelText: "Diagnosa",
                          ),
                        ),
                        TextField(
                          controller: controller.biayaController,
                          decoration: const InputDecoration(
                            labelText: "Biaya",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => DropdownButtonFormField<String>(
                            // 🚨 KUNCI 1: Gunakan properti 'value' (bukan initialValue) agar sinkron dengan Obx
                            value: controller.statusRawat.value,
                            items: ['Rawat Inap', 'Rawat Jalan']
                                .map((e) => DropdownMenuItem<String>(
                                      // 🚨 KUNCI 2: Tambahkan <String> di sini
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (String? value) {
                              // 🚨 KUNCI 3: Hapus total fungsi setState. Cukup update variabel GetX langsung
                              if (value != null) {
                                controller.statusRawat.value = value;

                                // Jika Anda butuh variabel lokal 'status' di halaman ini,
                                // Anda bisa langsung mengisinya tanpa bungkusan setState:
                                // status = value;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "Status Rawat",
                              border: OutlineInputBorder(),
                            ),
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
                              // final pendaftaran = Pendaftaran(
                              //   pasienId: pasienId.toString(),
                              //   dokterId: dokterId.toString(),
                              //   poliId: poliId.toString(),
                              //   status: status.toString(),
                              //   tanggal: DateTime.now().toString(),
                              // );
                              // controller.tambahPendaftaran(pendaftaran);

                              if (pasienId == null ||
                                  dokterId == null ||
                                  poliId == null ||
                                  status == null) {
                                Get.snackbar(
                                    "Gagal", "Harap lengkapi semua data");
                                return;
                              }
                              await controller.tambahPendaftaran({
                                'pasien_id': pasienId,
                                'dokter_id': dokterId,
                                'poli_id': poliId,
                                'status': status,
                                'diagnosa': controller.diagnosaController.text,
                                'biaya_pemeriksaan': int.tryParse(
                                        controller.biayaController.text) ??
                                    0,
                                'tanggal_periksa': DateTime.now()
                                    .toIso8601String(), // dari date picker
                                'status_rawat': controller.statusRawat
                                    .value, // "Rawat Jalan" / "Rawat Inap"
                                'catatan': controller.catatanController.text,
                                'tanggal': DateTime.now()
                                    .toIso8601String(), // <- diubah
                              });
                              Get.back();
                            },
                            child: const Text("Simpan"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
      body: Obx(() {
        if (controller.pendaftaranList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_turned_in_rounded,
                    size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  "Belum ada antrean pendaftaran hari ini",
                  style: TextStyle(color: Colors.grey[500], fontSize: 15),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.pendaftaranList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          /** itemBuilder: (context, index) {
            final p = controller.pendaftaranList[index];
            return ListTile(
              title: Text(p.dokterId),
              subtitle: Text(p.pasienId),
            );
          }, **/
          itemBuilder: (context, index) {
            final data = controller.pendaftaranList[index];
            final String currentStatus = data['status'] ?? 'UMUM';

            // Customisasi warna badge berdasarkan tipe asuransi / status bayar
            final Color statusBg = currentStatus == 'BPJS'
                ? Colors.green.shade50
                : Colors.blue.shade50;
            final Color statusTxt = currentStatus == 'UMUM'
                ? Colors.green.shade700
                : Colors.blue.shade700;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: accentColor.withValues(alpha: 0.1),
                      child: const Icon(Icons.assignment_ind_rounded,
                          color: accentColor, size: 22),
                    ),
                    title: Text(
                      data['nama_pasien'] ?? '-',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              currentStatus,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: statusTxt),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Icon(Icons.door_sliding_rounded,
                          //     size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 3),
                          // Text(
                          //   data['nama_poli'] ?? '-',
                          //   style: TextStyle(
                          //       fontSize: 12, color: Colors.grey[600]),
                          // ),
                        ],
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            const Divider(height: 1),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.person_pin_rounded,
                                    size: 16, color: primaryColor),
                                const SizedBox(width: 8),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                        fontFamily: 'Roboto'),
                                    children: [
                                      const TextSpan(
                                          text: "Dokter Pemeriksa: ",
                                          style: TextStyle(color: Colors.grey)),
                                      TextSpan(
                                          text: data['nama_dokter'] ?? '-'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
}
