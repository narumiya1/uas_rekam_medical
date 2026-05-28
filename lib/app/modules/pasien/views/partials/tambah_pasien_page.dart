import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pasien_controller.dart';

class TambahPasienPage extends StatefulWidget {
  const TambahPasienPage({super.key});

  @override
  State<TambahPasienPage> createState() => _TambahPasienPageState();
}

class _TambahPasienPageState extends State<TambahPasienPage> {
  final controller = Get.put(PasienController());

  final namaC = TextEditingController();
  final alamatC = TextEditingController();
  final teleponC = TextEditingController();
  final tanggalC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pasien"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(
                labelText: 'Nama Pasien',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: alamatC,
              decoration: const InputDecoration(
                labelText: 'Alamat',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: teleponC,
              decoration: const InputDecoration(
                labelText: 'Telepon',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: tanggalC,
              decoration: const InputDecoration(
                labelText: 'Tanggal Lahir',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await controller.tambahPasien({
                  'nama': namaC.text,
                  'alamat': alamatC.text,
                  'telepon': teleponC.text,
                  'tanggal_lahir': tanggalC.text,
                });

                Get.back();
              },
              child: const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
