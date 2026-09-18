class Pemeriksaan {
  String? id;
  String pendaftaranId;
  String keluhan;
  String diagnosa;
  String tindakan;

  Pemeriksaan({
    this.id,
    required this.pendaftaranId,
    required this.keluhan,
    required this.diagnosa,
    required this.tindakan,
  });

  Map<String, dynamic> toMap() {
    return {
      'pendaftaranId': pendaftaranId,
      'keluhan': keluhan,
      'diagnosa': diagnosa,
      'tindakan': tindakan,
    };
  }

  factory Pemeriksaan.fromMap(String id, Map<dynamic, dynamic> map) {
    return Pemeriksaan(
      id: id,
      pendaftaranId: map['pendaftaranId'] ?? '',
      keluhan: map['keluhan'] ?? '',
      diagnosa: map['diagnosa'] ?? '',
      tindakan: map['tindakan'] ?? '',
    );
  }
}
