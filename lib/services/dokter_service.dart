import 'package:firebase_database/firebase_database.dart';
import '../models/dokter.dart';

class DokterService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('dokter');

  Future<void> tambahDokter(Dokter dokter) async {
    await _ref.push().set(dokter.toMap());
  }

  Future<List<Dokter>> getDokterList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Dokter.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<Dokter>> streamDokter() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Dokter>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Dokter.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  Future<void> updateDokter(String id, Dokter dokter) async {
    await _ref.child(id).update(dokter.toMap());
  }

  Future<void> hapusDokter(String id) async {
    await _ref.child(id).remove();
  }
}
