import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class DokterController extends GetxController {
  var dokterList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getDokter();
  }

  Future<void> getDokter() async {
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
  }
}
