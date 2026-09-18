import 'package:firebase_database/firebase_database.dart';
import '../models/pendaftaran.dart';

class PendaftaranService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('pendaftaran');
  final DatabaseReference _pasienRef =
      FirebaseDatabase.instance.ref().child('pasien');
  final DatabaseReference _dokterRef =
      FirebaseDatabase.instance.ref().child('dokter');
  final DatabaseReference _poliRef =
      FirebaseDatabase.instance.ref().child('poli');

  Future<void> tambahPendaftaran(Pendaftaran p) async {
    await _ref.push().set(p.toMap());
  }

  Future<List<Pendaftaran>> getPendaftaranList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Pendaftaran.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<Pendaftaran>> streamPendaftaran() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Pendaftaran>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Pendaftaran.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  // Karena Realtime Database tidak punya JOIN, ambil nama pasien/dokter/poli
  // dengan fetch tambahan per record. Cocok dipakai saat menampilkan detail
  // atau daftar kecil; untuk daftar besar sebaiknya di-cache di controller.
  Future<Pendaftaran> lengkapiDenganNama(Pendaftaran p) async {
    final pasienSnap = await _pasienRef.child(p.pasienId).get();
    final dokterSnap = await _dokterRef.child(p.dokterId).get();
    final poliSnap = await _poliRef.child(p.poliId).get();

    p.namaPasien = pasienSnap.exists
        ? (pasienSnap.value as Map)['nama']?.toString()
        : 'Tidak ditemukan';
    p.namaDokter = dokterSnap.exists
        ? (dokterSnap.value as Map)['nama']?.toString()
        : 'Tidak ditemukan';
    p.namaPoli = poliSnap.exists
        ? (poliSnap.value as Map)['namaPoli']?.toString()
        : 'Tidak ditemukan';

    return p;
  }

  Future<void> updatePendaftaran(String id, Pendaftaran p) async {
    await _ref.child(id).update(p.toMap());
  }

  Future<void> hapusPendaftaran(String id) async {
    await _ref.child(id).remove();
  }
}
