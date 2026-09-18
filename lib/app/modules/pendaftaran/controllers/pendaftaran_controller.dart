import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/models/pendaftaran.dart';
import 'package:uas_medical/services/pendaftaran_service.dart';

class PendaftaranController extends GetxController {
  // var pendaftaranList = [].obs;

  // var pasienList = [].obs;
  // var dokterList = [].obs;`
  // var poliList = [].obs;
  final PendaftaranService _service = PendaftaranService();
  // var pendaftaranList = <Pendaftaran>[].obs;
  var isLoading = false.obs;
  TextEditingController diagnosaController = TextEditingController();
  TextEditingController biayaController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  TextEditingController tanggalC = TextEditingController();
  RxString statusRawat = "Rawat Jalan".obs;

  @override
  void onInit() {
    super.onInit();
    getPasien();
    getDokter();
    getPoli();
    getPendaftaran();
    // bindStream();

    // getPendaftaran();
    // getPasien();
    // getDokter();
    // getPoli();
  }

  // void bindStream() {
  //   isLoading.value = true;
  //   _service.streamPendaftaran().listen((data) async {
  //     // Lengkapi setiap item dengan nama pasien/dokter/poli untuk ditampilkan di UI
  //     final lengkap = await Future.wait(
  //       data.map((p) => _service.lengkapiDenganNama(p)),
  //     );
  //     pendaftaranList.value = lengkap;
  //     isLoading.value = false;
  //   });
  // }

  final _pasienRef = FirebaseDatabase.instance.ref('pasien');
  final _dokterRef = FirebaseDatabase.instance.ref('dokter');
  final _poliRef = FirebaseDatabase.instance.ref('poli');
  final _pendaftaranRef = FirebaseDatabase.instance.ref('pendaftaran');

  var pasienList = <Map<String, dynamic>>[].obs;
  var dokterList = <Map<String, dynamic>>[].obs;
  var poliList = <Map<String, dynamic>>[].obs;
  var pendaftaranList = <Map<String, dynamic>>[].obs;

  Future<void> getPasien() async {
    final snapshot = await _pasienRef.get();
    if (!snapshot.exists) {
      pasienList.clear();
      return;
    }
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final list = data.entries.map((e) {
      final item = Map<String, dynamic>.from(e.value as Map);
      item['id'] = e.key; // push key Firebase, gantikan id INTEGER
      return item;
    }).toList();
    pasienList.assignAll(list);
  }

  Future<void> getDokter() async {
    final snapshot = await _dokterRef.get();
    if (!snapshot.exists) {
      dokterList.clear();
      return;
    }
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final list = data.entries.map((e) {
      final item = Map<String, dynamic>.from(e.value as Map);
      item['id'] = e.key;
      return item;
    }).toList();
    dokterList.assignAll(list);
  }

  Future<void> getPoli() async {
    final snapshot = await _poliRef.get();
    if (!snapshot.exists) {
      poliList.clear();
      return;
    }
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final list = data.entries.map((e) {
      final item = Map<String, dynamic>.from(e.value as Map);
      item['id'] = e.key;
      return item;
    }).toList();
    poliList.assignAll(list);
  }

  Future<void> tambahPendaftaran(Map<String, dynamic> data) async {
    await _pendaftaranRef.push().set(data);
    await getPendaftaran();
  }

  Future<void> getPendaftaran() async {
    final snapshot = await _pendaftaranRef.get();
    if (!snapshot.exists) {
      pendaftaranList.clear();
      return;
    }

    final rawData = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final List<Map<String, dynamic>> hasil = [];

    // Firebase Realtime Database tidak punya JOIN, jadi digabung manual per item
    for (final entry in rawData.entries) {
      final item = Map<String, dynamic>.from(entry.value as Map);
      item['id'] = entry.key;

      if (item['pasien_id'] != null) {
        final s = await _pasienRef.child(item['pasien_id'].toString()).get();
        item['nama_pasien'] = s.exists ? (s.value as Map)['nama'] : '-';
      } else {
        item['nama_pasien'] = '-';
      }

      if (item['dokter_id'] != null) {
        final s = await _dokterRef.child(item['dokter_id'].toString()).get();
        item['nama_dokter'] = s.exists ? (s.value as Map)['nama'] : '-';
      } else {
        item['nama_dokter'] = '-';
      }

      if (item['poli_id'] != null) {
        final s = await _poliRef.child(item['poli_id'].toString()).get();
        item['nama_poli'] = s.exists ? (s.value as Map)['nama_poli'] : '-';
      } else {
        item['nama_poli'] = '-';
      }

      hasil.add(item);
    }

    // Push key Firebase otomatis urut waktu, jadi bisa disortir sebagai string
    hasil.sort((a, b) => (b['id'] as String).compareTo(a['id'] as String));

    pendaftaranList.assignAll(hasil);
  }

  Future<List<Map<String, dynamic>>> getRiwayatPasien(String pasienId) async {
    final snapshot =
        await _pendaftaranRef.orderByChild('pasien_id').equalTo(pasienId).get();

    if (!snapshot.exists) return [];

    final rawData = Map<dynamic, dynamic>.from(snapshot.value as Map);
    final List<Map<String, dynamic>> hasil = [];

    for (final entry in rawData.entries) {
      final item = Map<String, dynamic>.from(entry.value as Map);
      item['id'] = entry.key;

      // lengkapi nama dokter & poli untuk ditampilkan di riwayat
      if (item['dokter_id'] != null) {
        final s = await _dokterRef.child(item['dokter_id'].toString()).get();
        item['nama_dokter'] = s.exists ? (s.value as Map)['nama'] : '-';
      }
      if (item['poli_id'] != null) {
        final s = await _poliRef.child(item['poli_id'].toString()).get();
        item['nama_poli'] = s.exists ? (s.value as Map)['namaPoli'] : '-';
      }

      hasil.add(item);
    }

    // urutkan dari yang terbaru
    hasil.sort((a, b) =>
        (b['tanggal_periksa'] ?? '').compareTo(a['tanggal_periksa'] ?? ''));

    return hasil;
  }

  /**  Future<void> tambahPendaftaran(Pendaftaran p) async {
    await _service.tambahPendaftaran(p);
  }
**/
  Future<void> updatePendaftaran(String id, Pendaftaran p) async {
    await _service.updatePendaftaran(id, p);
  }

  Future<void> hapusPendaftaran(String id) async {
    await _service.hapusPendaftaran(id);
  }

  /**
  Future<void> getPasien() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_pasien');

    pasienList.assignAll(data);
  }

  Future<void> getDokter() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_dokter');

    dokterList.assignAll(data);
  }

  Future<void> getPoli() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_poli');

    poliList.assignAll(data);
  }

  Future<void> tambahPendaftaran(
    Map<String, dynamic> data,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      't_pendaftaran',
      data,
    );

    getPendaftaran();
  }

  Future<void> getPendaftaran() async {
    final db = await DatabaseHelper.database;

    final data = await db.rawQuery('''

      SELECT
        t_pendaftaran.*,
        t_pasien.nama as nama_pasien,
        t_dokter.nama as nama_dokter,
        t_poli.nama_poli as nama_poli

      FROM t_pendaftaran

      LEFT JOIN t_pasien
      ON t_pasien.id = t_pendaftaran.pasien_id

      LEFT JOIN t_dokter
      ON t_dokter.id = t_pendaftaran.dokter_id

      LEFT JOIN t_poli
      ON t_poli.id = t_pendaftaran.poli_id

      ORDER BY t_pendaftaran.id DESC

    ''');

    pendaftaranList.assignAll(data);
  }
**/
}
