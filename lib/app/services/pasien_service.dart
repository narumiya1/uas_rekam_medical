import 'package:firebase_database/firebase_database.dart';
import '../models/pasien.dart';

class PasienService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('pasien');

  // CREATE
  Future<void> tambahPasien(Pasien pasien) async {
    await _ref.push().set(pasien.toMap());
  }

  // READ (sekali ambil)
  Future<List<Pasien>> getPasienList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];

    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Pasien.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  // READ (realtime stream, auto-update UI)
  Stream<List<Pasien>> streamPasien() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Pasien>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map(
              (e) => Pasien.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  // UPDATE
  Future<void> updatePasien(String id, Pasien pasien) async {
    await _ref.child(id).update(pasien.toMap());
  }

  // DELETE
  Future<void> hapusPasien(String id) async {
    await _ref.child(id).remove();
  }
}
