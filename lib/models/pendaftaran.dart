class Pendaftaran {
  String? id;
  String pasienId;
  String dokterId;
  String poliId;
  String status;
  String tanggal;

  // Field tambahan (opsional) hasil join manual, tidak disimpan ke Firebase
  String? namaPasien;
  String? namaDokter;
  String? namaPoli;

  Pendaftaran({
    this.id,
    required this.pasienId,
    required this.dokterId,
    required this.poliId,
    required this.status,
    required this.tanggal,
    this.namaPasien,
    this.namaDokter,
    this.namaPoli,
  });

  Map<String, dynamic> toMap() {
    return {
      'pasienId': pasienId,
      'dokterId': dokterId,
      'poliId': poliId,
      'status': status,
      'tanggal': tanggal,
    };
  }

  factory Pendaftaran.fromMap(String id, Map<dynamic, dynamic> map) {
    return Pendaftaran(
      id: id,
      pasienId: map['pasienId'] ?? '',
      dokterId: map['dokterId'] ?? '',
      poliId: map['poliId'] ?? '',
      status: map['status'] ?? '',
      tanggal: map['tanggal'] ?? '',
    );
  }
}
