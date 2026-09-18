class Dokter {
  String? id;
  String nama;
  String spesialis;
  String telepon;

  Dokter({
    this.id,
    required this.nama,
    required this.spesialis,
    required this.telepon,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'spesialis': spesialis,
      'telepon': telepon,
    };
  }

  factory Dokter.fromMap(String id, Map<dynamic, dynamic> map) {
    return Dokter(
      id: id,
      nama: map['nama'] ?? '',
      spesialis: map['spesialis'] ?? '',
      telepon: map['telepon'] ?? '',
    );
  }
}
