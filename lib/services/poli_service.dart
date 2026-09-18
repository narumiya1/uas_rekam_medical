import 'package:firebase_database/firebase_database.dart';
import '../models/poli.dart';

class PoliService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('poli');

  Future<void> tambahPoli(Poli poli) async {
    await _ref.push().set(poli.toMap());
  }

  Future<List<Poli>> getPoliList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Poli.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<Poli>> streamPoli() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Poli>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Poli.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  Future<void> updatePoli(String id, Poli poli) async {
    await _ref.child(id).update(poli.toMap());
  }

  Future<void> hapusPoli(String id) async {
    await _ref.child(id).remove();
  }
}
