import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'rekam_medis.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // TABEL PASIEN
        await db.execute('''
        CREATE TABLE t_pasien(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          alamat TEXT,
          telepon TEXT,
          tanggal_lahir TEXT
        )
        ''');

        // TABEL DOKTER
        await db.execute('''
        CREATE TABLE t_dokter(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          spesialis TEXT,
          telepon TEXT
        )
        ''');

        // TABEL OBAT
        await db.execute('''
        CREATE TABLE t_obat(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama_obat TEXT,
          stok INTEGER,
          harga INTEGER
        )
        ''');

        // TABEL POLI
        await db.execute('''
        CREATE TABLE t_poli(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama_poli TEXT
        )
        ''');

        // TABEL PENDAFTARAN
        await db.execute('''
        CREATE TABLE t_pendaftaran(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pasien_id INTEGER,
          dokter_id INTEGER,
          poli_id INTEGER,
          status TEXT,
          tanggal TEXT
        )
        ''');

        // TABEL PEMERIKSAAN
        await db.execute('''
        CREATE TABLE t_pemeriksaan(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pendaftaran_id INTEGER,
          keluhan TEXT,
          diagnosa TEXT,
          tindakan TEXT
        )
        ''');

        // TABEL DETAIL JUAL
        await db.execute('''
        CREATE TABLE t_detailjual(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pemeriksaan_id INTEGER,
          obat_id INTEGER,
          jumlah INTEGER
        )
        ''');

        // TABEL USER
        await db.execute('''
        CREATE TABLE t_user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          password TEXT
        )
        ''');
      },
    );
  }
}
