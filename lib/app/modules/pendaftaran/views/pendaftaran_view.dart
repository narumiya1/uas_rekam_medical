import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pendaftaran_controller.dart';

class PendaftaranView extends GetView<PendaftaranController> {
  const PendaftaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Pasien"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int? pasienId;
          int? dokterId;
          int? poliId;
          String? status;

          Get.bottomSheet(
            StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Tambah Pendaftaran",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PASIEN
                        DropdownButtonFormField<int>(
                          value: pasienId,
                          items: controller.pasienList.map((e) {
                            return DropdownMenuItem<int>(
                              value: e['id'],
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

                        // DOKTER
                        DropdownButtonFormField<int>(
                          value: dokterId,
                          items: controller.dokterList.map((e) {
                            return DropdownMenuItem<int>(
                              value: e['id'],
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

                        // POLI
                        DropdownButtonFormField<int>(
                          value: poliId,
                          items: controller.poliList.map((e) {
                            return DropdownMenuItem<int>(
                              value: e['id'],
                              child: Text(e['nama_poli']),
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

                        // STATUS
                        DropdownButtonFormField<String>(
                          value: status,
                          items: ['BPJS', 'UMUM']
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
                            labelText: "Status",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.tambahPendaftaran({
                                'pasien_id': pasienId,
                                'dokter_id': dokterId,
                                'poli_id': poliId,
                                'status': status,
                                'tanggal': DateTime.now().toString(),
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
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.pendaftaranList.length,
          itemBuilder: (context, index) {
            final data = controller.pendaftaranList[index];

            return Card(
              child: ListTile(
                title: Text('Nama : ${data['nama_pasien']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Text("Dokter : ${data['nama_dokter']}"),
                    Text("Poli : ${data['nama_poli']}"),
                    Text("Status : ${data['status']}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
