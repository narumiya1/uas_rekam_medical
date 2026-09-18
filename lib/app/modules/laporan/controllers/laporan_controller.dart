import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/services/laporan_service.dart';

class LaporanController extends GetxController {
  final _pasienRef = FirebaseDatabase.instance.ref('pasien');
  final _dokterRef = FirebaseDatabase.instance.ref('dokter');
  final _poliRef = FirebaseDatabase.instance.ref('poli');
  final _pendaftaranRef = FirebaseDatabase.instance.ref('pendaftaran');

  var pasienList = <Map<String, dynamic>>[].obs;
  var riwayatList = <Map<String, dynamic>>[].obs;

  var selectedPasienId = RxnString();
  var selectedPasienNama = RxnString();

  var isLoadingPasien = false.obs;
  var isLoadingRiwayat = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPasien();
  }

  // Ambil semua pasien untuk ditampilkan sebagai daftar pilihan
  Future<void> getPasien() async {
    isLoadingPasien.value = true;
    final snapshot = await _pasienRef.get();

    if (!snapshot.exists) {
      pasienList.clear();
      isLoadingPasien.value = false;
      return;
    }

    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final list = data.entries.map((e) {
      final item = Map<String, dynamic>.from(e.value as Map);
      item['id'] = e.key;
      return item;
    }).toList();

    // Urutkan berdasarkan nama biar gampang dicari
    list.sort((a, b) =>
        (a['nama'] ?? '').toString().compareTo((b['nama'] ?? '').toString()));

    pasienList.assignAll(list);
    isLoadingPasien.value = false;
  }

  // Dipanggil saat user memilih salah satu pasien dari daftar
  Future<void> pilihPasien(String pasienId, String namaPasien) async {
    selectedPasienId.value = pasienId;
    selectedPasienNama.value = namaPasien;
    await getRiwayat(pasienId);
  }

  // Ambil semua pendaftaran milik pasien tsb, lengkap dengan nama dokter & poli
  Future<void> getRiwayat(String pasienId) async {
    isLoadingRiwayat.value = true;

    final snapshot =
        await _pendaftaranRef.orderByChild('pasien_id').equalTo(pasienId).get();

    if (!snapshot.exists) {
      riwayatList.clear();
      isLoadingRiwayat.value = false;
      return;
    }

    final rawData = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final List<Map<String, dynamic>> hasil = [];

    for (final entry in rawData.entries) {
      final item = Map<String, dynamic>.from(entry.value as Map);
      item['id'] = entry.key;

      if (item['dokter_id'] != null) {
        final s = await _dokterRef.child(item['dokter_id'].toString()).get();
        item['nama_dokter'] = s.exists ? (s.value as Map)['nama'] : '-';
      } else {
        item['nama_dokter'] = '-';
      }

      if (item['poli_id'] != null) {
        final s = await _poliRef.child(item['poli_id'].toString()).get();
        item['nama_poli'] = s.exists ? (s.value as Map)['namaPoli'] : '-';
      } else {
        item['nama_poli'] = '-';
      }

      hasil.add(item);
    }

    // Urutkan dari pemeriksaan terbaru; fallback ke tanggal daftar kalau
    // tanggal_periksa belum diisi (misal data lama sebelum kolom ditambahkan)
    hasil.sort((a, b) {
      final tglA = (a['tanggal_periksa'] ?? a['tanggal'] ?? '').toString();
      final tglB = (b['tanggal_periksa'] ?? b['tanggal'] ?? '').toString();
      return tglB.compareTo(tglA);
    });

    riwayatList.assignAll(hasil);
    isLoadingRiwayat.value = false;
  }

  void kembaliKeDaftarPasien() {
    selectedPasienId.value = null;
    selectedPasienNama.value = null;
    riwayatList.clear();
  }

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

  void increment() => count.value++;
}
