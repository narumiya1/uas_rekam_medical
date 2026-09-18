import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
  const LaporanView({super.key});
  @override
  /** Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanPasien();
                },
                child: const Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Laporan Pasien',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanDokter();
                },
                child: const Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Laporan Dokter',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 250,
              child: GestureDetector(
                onTap: () {
                  controller.cetakLaporanObat();
                },
                child: const Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Laporan Obat',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  **/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pemeriksaan Pasien"),
      ),
      body: Obx(() {
        // Kalau belum pilih pasien -> tampilkan daftar pasien
        if (controller.selectedPasienId.value == null) {
          return _buildDaftarPasien();
        }
        // Kalau sudah pilih pasien -> tampilkan riwayatnya
        return _buildRiwayat();
      }),
    );
  }

  Widget _buildDaftarPasien() {
    if (controller.isLoadingPasien.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.pasienList.isEmpty) {
      return const Center(child: Text("Belum ada data pasien"));
    }

    return RefreshIndicator(
      onRefresh: controller.getPasien,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: controller.pasienList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final p = controller.pasienList[index];
          return Card(
            elevation: 1,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(p['nama'] ?? '-'),
              subtitle: Text(p['alamat'] ?? '-'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                controller.pilihPasien(p['id'], p['nama'] ?? '-');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRiwayat() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.blue.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: controller.kembaliKeDaftarPasien,
              ),
              Expanded(
                child: Text(
                  controller.selectedPasienNama.value ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoadingRiwayat.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.riwayatList.isEmpty) {
              return const Center(
                child: Text("Belum ada riwayat pemeriksaan untuk pasien ini"),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: controller.riwayatList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final r = controller.riwayatList[index];
                return _buildKartuRiwayat(r);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildKartuRiwayat(Map<String, dynamic> r) {
    final tanggal = r['tanggal_periksa'] ?? r['tanggal'] ?? '-';
    final statusRawat = r['status_rawat'] ?? '-';
    final biaya = r['biaya_pemeriksaan'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    r['diagnosa'] ?? 'Belum ada diagnosa',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusRawat == 'Rawat Inap'
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    statusRawat,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusRawat == 'Rawat Inap'
                          ? Colors.red.shade800
                          : Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _baris(Icons.calendar_today, "Tanggal", _formatTanggal(tanggal)),
            _baris(Icons.medical_services, "Dokter", r['nama_dokter'] ?? '-'),
            _baris(Icons.local_hospital, "Poli", r['nama_poli'] ?? '-'),
            if (biaya != null) _baris(Icons.payments, "Biaya", "Rp $biaya"),
            if ((r['catatan'] ?? '').toString().isNotEmpty)
              _baris(Icons.note, "Catatan", r['catatan']),
          ],
        ),
      ),
    );
  }

  Widget _baris(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatTanggal(String isoString) {
    try {
      final dt = DateTime.parse(isoString);
      return "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return isoString;
    }
  }
}
