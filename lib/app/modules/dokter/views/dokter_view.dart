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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Dokter"),
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
        return ListView.builder(
          itemCount: controller.dokterList.length,
          itemBuilder: (context, index) {
            final data = controller.dokterList[index];

            return Card(
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
            );
          },
        );
      }),
    );
  }
}
