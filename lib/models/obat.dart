class Obat {
  String? id;
  String namaObat;
  int stok;
  int harga;

  Obat({
    this.id,
    required this.namaObat,
    required this.stok,
    required this.harga,
  });

  Map<String, dynamic> toMap() {
    return {
      'namaObat': namaObat,
      'stok': stok,
      'harga': harga,
    };
  }

  factory Obat.fromMap(String id, Map<dynamic, dynamic> map) {
    return Obat(
      id: id,
      namaObat: map['namaObat'] ?? '',
      stok: map['stok'] is int ? map['stok'] : int.tryParse('${map['stok']}') ?? 0,
      harga: map['harga'] is int ? map['harga'] : int.tryParse('${map['harga']}') ?? 0,
    );
  }
}
