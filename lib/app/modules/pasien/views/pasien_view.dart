import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/pasien_controller.dart';

class PasienView extends GetView<PasienController> {
  const PasienView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pasien"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final namaC = TextEditingController();
          final alamatC = TextEditingController();
          final teleponC = TextEditingController();
          final tanggalC = TextEditingController();

          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: 0.8,
              child: Container(
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
                        "Tambah Pasien",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.pasienList.length,
          itemBuilder: (context, index) {
            final data = controller.pasienList[index];

            return Card(
              child: ListTile(
                title: Text('Nama : ${data['nama']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text(data['alamat']),
                    Text(data['telepon']),
                    Text(data['tanggal_lahir']),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.hapusPasien(data['id']);
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
