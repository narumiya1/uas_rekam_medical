import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanPasien();
                },
                child: Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Laporan Pasien',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanDokter();
                },
                child: Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Laporan Dokter',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanObat();
                },
                child: Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Laporan Obat',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
