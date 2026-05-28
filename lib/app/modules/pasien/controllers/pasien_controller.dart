import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class PasienController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getPasien();
  }

  var pasienList = [].obs;

  Future<void> getPasien() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_pasien');

    pasienList.assignAll(data);
  }

  Future<void> tambahPasien(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.database;

    await db.insert('t_pasien', data);

    getPasien();
  }

  Future<void> hapusPasien(int id) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      't_pasien',
      where: 'id = ?',
      whereArgs: [id],
    );

    getPasien();
  }
}
