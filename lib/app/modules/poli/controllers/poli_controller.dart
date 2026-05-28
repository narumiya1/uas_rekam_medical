import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class PoliController extends GetxController {
  var poliList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getPoli();
  }

  Future<void> getPoli() async {
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
}
