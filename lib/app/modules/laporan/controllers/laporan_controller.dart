import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/services/laporan_service.dart';

class LaporanController extends GetxController {
  //TODO: Implement LaporanController
  Future<void> cetakLaporanPasien() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_pasien');

    await LaporanService.generatePdf(
      title: "Laporan Data Pasien",
      data: data,
    );
  }

  Future<void> cetakLaporanDokter() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_dokter');

    await LaporanService.generatePdf(
      title: "Laporan Data Dokter",
      data: data,
    );
  }

  Future<void> cetakLaporanObat() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_obat');

    await LaporanService.generatePdf(
      title: "Laporan Data Obat",
      data: data,
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
