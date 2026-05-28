import 'package:get/get.dart';
import 'package:uas_medical/helpers/db_helpers.dart';

class PendaftaranController extends GetxController {
  var pendaftaranList = [].obs;

  var pasienList = [].obs;
  var dokterList = [].obs;
  var poliList = [].obs;

  @override
  void onInit() {
    super.onInit();

    getPendaftaran();
    getPasien();
    getDokter();
    getPoli();
  }

  Future<void> getPasien() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_pasien');

    pasienList.assignAll(data);
  }

  Future<void> getDokter() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_dokter');

    dokterList.assignAll(data);
  }

  Future<void> getPoli() async {
    final db = await DatabaseHelper.database;

    final data = await db.query('t_poli');

    poliList.assignAll(data);
  }

  Future<void> tambahPendaftaran(
    Map<String, dynamic> data,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      't_pendaftaran',
      data,
    );

    getPendaftaran();
  }

  Future<void> getPendaftaran() async {
    final db = await DatabaseHelper.database;

    final data = await db.rawQuery('''

      SELECT
        t_pendaftaran.*,
        t_pasien.nama as nama_pasien,
        t_dokter.nama as nama_dokter,
        t_poli.nama_poli as nama_poli

      FROM t_pendaftaran

      LEFT JOIN t_pasien
      ON t_pasien.id = t_pendaftaran.pasien_id

      LEFT JOIN t_dokter
      ON t_dokter.id = t_pendaftaran.dokter_id

      LEFT JOIN t_poli
      ON t_poli.id = t_pendaftaran.poli_id

      ORDER BY t_pendaftaran.id DESC

    ''');

    pendaftaranList.assignAll(data);
  }
}
