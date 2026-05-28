import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/poli_controller.dart';

class PoliView extends GetView<PoliController> {
  const PoliView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Poli"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final poliC = TextEditingController();

          Get.bottomSheet(
            FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: poliC,
                      decoration: const InputDecoration(
                        labelText: "Nama Poli",
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.tambahPoli({
                            'nama_poli': poliC.text,
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
          itemCount: controller.poliList.length,
          itemBuilder: (context, index) {
            final data = controller.poliList[index];

            return Card(
              child: ListTile(
                title: Text(data['nama_poli']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    controller.hapusPoli(data['id']);
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
