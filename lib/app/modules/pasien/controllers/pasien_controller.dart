import 'package:get/get.dart';
import 'package:uas_medical/app/models/pasien.dart';
import 'package:uas_medical/app/services/pasien_service.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class PasienController extends GetxController {
  final PasienService _service = PasienService();
  var pasienList = <Pasien>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getPasien();
    bindStream();
  }

  void bindStream() {
    isLoading.value = true;
    // BKS logika untuk memanggil data dari firebase
    _service.streamPasien().listen((data) {
      pasienList.value = data;
      isLoading.value = false;
    });
  }

  // BKS logika untuk menambahkan pasien ke firebase
  Future<void> tambahPasien(Pasien pasien) async {
    await _service.tambahPasien(pasien);
    // tidak perlu refresh manual — stream otomatis update
  }

  Future<void> hapusPasien(String id) async {
    await _service.hapusPasien(id);
  }

  var pasienLists = [].obs;

  Future<void> getPasien() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_pasien');

    pasienLists.assignAll(data);
  }

  // Future<void> tambahPasien(Map<String, dynamic> data) async {
  //   final db = await DatabaseHelper.database;

  //   await db.insert('t_pasien', data);

  //   getPasien();
  // }

  // Future<void> hapusPasien(int id) async {
  //   final db = await DatabaseHelper.database;

  //   await db.delete(
  //     't_pasien',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   getPasien();
  // }
}
