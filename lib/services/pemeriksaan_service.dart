import 'package:firebase_database/firebase_database.dart';
import '../models/pemeriksaan.dart';

class PemeriksaanService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('pemeriksaan');

  Future<void> tambahPemeriksaan(Pemeriksaan p) async {
    await _ref.push().set(p.toMap());
  }

  Future<List<Pemeriksaan>> getPemeriksaanList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Pemeriksaan.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  // Ambil pemeriksaan berdasarkan pendaftaranId (mirip WHERE di SQL)
  Future<List<Pemeriksaan>> getByPendaftaranId(String pendaftaranId) async {
    final snapshot = await _ref
        .orderByChild('pendaftaranId')
        .equalTo(pendaftaranId)
        .get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Pemeriksaan.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<Pemeriksaan>> streamPemeriksaan() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Pemeriksaan>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Pemeriksaan.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  Future<void> updatePemeriksaan(String id, Pemeriksaan p) async {
    await _ref.child(id).update(p.toMap());
  }

  Future<void> hapusPemeriksaan(String id) async {
    await _ref.child(id).remove();
  }
}
