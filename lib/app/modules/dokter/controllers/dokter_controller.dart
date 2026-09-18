import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/models/dokter.dart';
import 'package:uas_medical/services/dokter_service.dart';

class DokterController extends GetxController {
  // var dokterList = [].obs;
  final DokterService _service = DokterService();
  var dokterList = <Dokter>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    bindStream();
    // getDokter();
  }

  void bindStream() {
    isLoading.value = true;
    _service.streamDokter().listen((data) {
      dokterList.value = data;
      isLoading.value = false;
    });
  }

  Future<void> tambahDokter(Dokter dokter) async {
    await _service.tambahDokter(dokter);
  }

  Future<void> updateDokter(String id, Dokter dokter) async {
    await _service.updateDokter(id, dokter);
  }

  Future<void> hapusDokter(String id) async {
    await _service.hapusDokter(id);
  }

  /** Future<void> getDokter() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_dokter');

    dokterList.assignAll(data);
  }

  Future<void> tambahDokter(
    Map<String, dynamic> data,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      't_dokter',
      data,
    );

    getDokter();
  }

  Future<void> hapusDokter(int id) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      't_dokter',
      where: 'id = ?',
      whereArgs: [id],
    );

    getDokter();
  } **/
}
