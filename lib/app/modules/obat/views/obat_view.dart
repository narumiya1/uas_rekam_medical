import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/currency.dart';

import '../controllers/obat_controller.dart';

class ObatView extends GetView<ObatController> {
  const ObatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Obat"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final namaC = TextEditingController();
          final stokC = TextEditingController();
          final hargaC = TextEditingController();

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
                        onPressed: () async {
                          await controller.tambahObat({
                            'nama_obat': namaC.text,
                            'stok': int.parse(stokC.text),
                            'harga': int.parse(
                              hargaC.text.replaceAll(".", ""),
                            ),
                          });

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
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.obatList.length,
          itemBuilder: (context, index) {
            final data = controller.obatList[index];

            return Card(
              child: ListTile(
                title: Text(data['nama_obat']),
                subtitle: Text(
                  "Stok : ${data['stok']} | Harga : ${CurrencyHelper.formatRupiah(data['harga'])}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.hapusObat(data['id']);
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
