import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';
import 'package:uas_medical/models/obat.dart';
import 'package:uas_medical/services/obat_service.dart';

class ObatController extends GetxController {
  // var obatList = [].obs;
  final ObatService _service = ObatService();
  var obatList = <Obat>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    // getObat();
    bindStream();
  }

  void bindStream() {
    isLoading.value = true;
    _service.streamObat().listen((data) {
      obatList.value = data;
      isLoading.value = false;
    });
  }

  Future<void> tambahObat(Obat obat) async {
    await _service.tambahObat(obat);
  }

  Future<void> updateObat(String id, Obat obat) async {
    await _service.updateObat(id, obat);
  }

  Future<void> kurangiStok(String id, int jumlah) async {
    await _service.kurangiStok(id, jumlah);
  }

  Future<void> hapusObat(String id) async {
    await _service.hapusObat(id);
  }

  /**Future<void> getObat() async {
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
  } **/
}
