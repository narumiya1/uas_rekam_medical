import 'package:firebase_database/firebase_database.dart';
import '../models/obat.dart';

class ObatService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('obat');

  Future<void> tambahObat(Obat obat) async {
    await _ref.push().set(obat.toMap());
  }

  Future<List<Obat>> getObatList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => Obat.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<Obat>> streamObat() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <Obat>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => Obat.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  Future<void> updateObat(String id, Obat obat) async {
    await _ref.child(id).update(obat.toMap());
  }

  // Contoh operasi khusus: kurangi stok saat obat terjual
  Future<void> kurangiStok(String id, int jumlah) async {
    final ref = _ref.child(id).child('stok');
    await ref.runTransaction((currentData) {
      int stokSaatIni = (currentData as int?) ?? 0;
      return Transaction.success(stokSaatIni - jumlah);
    });
  }

  Future<void> hapusObat(String id) async {
    await _ref.child(id).remove();
  }
}
