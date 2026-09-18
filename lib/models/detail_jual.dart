class DetailJual {
  String? id;
  String pemeriksaanId;
  String obatId;
  int jumlah;

  DetailJual({
    this.id,
    required this.pemeriksaanId,
    required this.obatId,
    required this.jumlah,
  });

  Map<String, dynamic> toMap() {
    return {
      'pemeriksaanId': pemeriksaanId,
      'obatId': obatId,
      'jumlah': jumlah,
    };
  }

  factory DetailJual.fromMap(String id, Map<dynamic, dynamic> map) {
    return DetailJual(
      id: id,
      pemeriksaanId: map['pemeriksaanId'] ?? '',
      obatId: map['obatId'] ?? '',
      jumlah: map['jumlah'] is int
          ? map['jumlah']
          : int.tryParse('${map['jumlah']}') ?? 0,
    );
  }
}
