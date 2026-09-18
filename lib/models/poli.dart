class Poli {
  String? id;
  String namaPoli;

  Poli({
    this.id,
    required this.namaPoli,
  });

  Map<String, dynamic> toMap() {
    return {
      'namaPoli': namaPoli,
    };
  }

  factory Poli.fromMap(String id, Map<dynamic, dynamic> map) {
    return Poli(
      id: id,
      namaPoli: map['namaPoli'] ?? '',
    );
  }
}
