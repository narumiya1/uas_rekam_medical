import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/halaman_laporan_pkm_controller.dart';

class HalamanLaporanPkmView extends GetView<HalamanLaporanPkmController> {
  const HalamanLaporanPkmView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HalamanLaporanPkmView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HalamanLaporanPkmView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
