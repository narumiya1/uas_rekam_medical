import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class ObatController extends GetxController {
  var obatList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getObat();
  }

  Future<void> getObat() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_obat');

    obatList.assignAll(data);
  }

  Future<void> tambahObat(
    Map<String, dynamic> data,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      't_obat',
      data,
    );

    getObat();
  }

  Future<void> hapusObat(int id) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      't_obat',
      where: 'id = ?',
      whereArgs: [id],
    );

    getObat();
  }
}
