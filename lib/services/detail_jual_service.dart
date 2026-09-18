import 'package:firebase_database/firebase_database.dart';
import '../models/detail_jual.dart';

class DetailJualService {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.ref().child('detailJual');
  final DatabaseReference _obatRef =
      FirebaseDatabase.instance.ref().child('obat');

  // Tambah detail jual sekaligus kurangi stok obat (pakai transaction agar aman)
  Future<void> tambahDetailJual(DetailJual d) async {
    await _ref.push().set(d.toMap());

    final stokRef = _obatRef.child(d.obatId).child('stok');
    await stokRef.runTransaction((currentData) {
      int stokSaatIni = (currentData as int?) ?? 0;
      return Transaction.success(stokSaatIni - d.jumlah);
    });
  }

  Future<List<DetailJual>> getDetailJualList() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => DetailJual.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Future<List<DetailJual>> getByPemeriksaanId(String pemeriksaanId) async {
    final snapshot = await _ref
        .orderByChild('pemeriksaanId')
        .equalTo(pemeriksaanId)
        .get();
    if (!snapshot.exists) return [];
    final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
    return data.entries
        .map((e) => DetailJual.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
        .toList();
  }

  Stream<List<DetailJual>> streamDetailJual() {
    return _ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return <DetailJual>[];
      final map = Map<dynamic, dynamic>.from(data as Map);
      return map.entries
          .map((e) => DetailJual.fromMap(e.key, Map<dynamic, dynamic>.from(e.value)))
          .toList();
    });
  }

  Future<void> updateDetailJual(String id, DetailJual d) async {
    await _ref.child(id).update(d.toMap());
  }

  Future<void> hapusDetailJual(String id) async {
    await _ref.child(id).remove();
  }
}
