class Pasien {
  String? id;
  String nama;
  String alamat;
  String telepon;
  String tanggalLahir;

  Pasien({
    this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.tanggalLahir,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'alamat': alamat,
      'telepon': telepon,
      'tanggalLahir': tanggalLahir,
    };
  }

  factory Pasien.fromMap(String id, Map<dynamic, dynamic> map) {
    return Pasien(
      id: id,
      nama: map['nama'] ?? '',
      alamat: map['alamat'] ?? '',
      telepon: map['telepon'] ?? '',
      tanggalLahir: map['tanggalLahir'] ?? '',
    );
  }
}
