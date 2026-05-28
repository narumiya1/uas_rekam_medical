class PasienModel {
  int? id;
  String nama;
  String alamat;
  String telepon;
  String tanggalLahir;

  PasienModel({
    this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.tanggalLahir,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'telepon': telepon,
      'tanggal_lahir': tanggalLahir,
    };
  }

  factory PasienModel.fromMap(Map<String, dynamic> map) {
    return PasienModel(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
      telepon: map['telepon'],
      tanggalLahir: map['tanggal_lahir'],
    );
  }
}
