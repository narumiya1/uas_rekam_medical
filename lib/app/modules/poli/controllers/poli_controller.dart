import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/models/poli.dart';
import 'package:uas_medical/services/poli_service.dart';

class PoliController extends GetxController {
  // var poliList = [].obs;
  final PoliService _service = PoliService();
  var poliList = <Poli>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    bindStream();

    // getPoli();
  }

  void bindStream() {
    isLoading.value = true;
    _service.streamPoli().listen((data) {
      poliList.value = data;
      isLoading.value = false;
    });
  }

  Future<void> tambahPoli(Poli poli) async {
    await _service.tambahPoli(poli);
  }

  Future<void> updatePoli(String id, Poli poli) async {
    await _service.updatePoli(id, poli);
  }

  Future<void> hapusPoli(String id) async {
    await _service.hapusPoli(id);
  }

/**   Future<void> getPoli() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_poli');

    poliList.assignAll(data);
  }

  Future<void> tambahPoli(
    Map<String, dynamic> data,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      't_poli',
      data,
    );

    getPoli();
  }

  Future<void> hapusPoli(int id) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      't_poli',
      where: 'id = ?',
      whereArgs: [id],
    );

    getPoli();
  }
  **/
}
